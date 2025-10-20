import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Real-time stream with pagination support
  Stream<List<Map<String, dynamic>>> getMessages({
    required String userId,
    DocumentSnapshot? startAfter,
    int limit = 20,
  }) {
    Query query = _firestore
        .collection('messages')
        .doc(userId)
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    return query.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['doc'] = doc; // attach doc for pagination
        return data;
      }).toList(),
    );
  }

  /// One-time fetch for loading older messages (pagination)
  Future<List<Map<String, dynamic>>> fetchMoreMessages({
    required String userId,
    required DocumentSnapshot lastDoc,
    int limit = 20,
  }) async {
    final snapshot = await _firestore
        .collection('messages')
        .doc(userId)
        .collection('chats')
        .orderBy('timestamp', descending: false)
        .startAfterDocument(lastDoc)
        .limit(limit)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['doc'] = doc;
      return data;
    }).toList();
  }

  /// Send a new message to both sender and receiver paths
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    final time = Timestamp.now();

    final message = {
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': time,
    };

    await Future.wait([
      _firestore
          .collection('messages')
          .doc(receiverId)
          .collection('chats')
          .add(message),
      _firestore
          .collection('messages')
          .doc(senderId)
          .collection('chats')
          .add(message),
    ]);
  }
}
