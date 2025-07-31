import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class UserService {
  final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  Future<List<UserModel>> fetchUsers({
    DocumentSnapshot? startAfter,
    int limit = 10,
    required String excludeUid,
    String? gender,
    String? country,
    String? division,
    String? district,
  }) async {
    try {
      Query query = usersRef.orderBy('createdAt', descending: true).limit(limit);

      if (gender != null && gender.isNotEmpty) {
        query = query.where('gender', isEqualTo: gender);
      }
      if (country != null && country.isNotEmpty) {
        query = query.where('country', isEqualTo: country);
      }
      if (division != null && division.isNotEmpty) {
        query = query.where('division', isEqualTo: division);
      }
      if (district != null && district.isNotEmpty) {
        query = query.where('district', isEqualTo: district);
      }

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final snapshot = await query.get();

      return snapshot.docs
          .where((doc) => doc.id != excludeUid)
          .map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromMap(data)..firestoreDoc = doc;
      })
          .toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }


}
