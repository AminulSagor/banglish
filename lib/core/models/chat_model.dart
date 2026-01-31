/// Chat model for conversation list
class ChatModel {
  final String id;
  final String name;
  final String photo;
  final String lastMessage;
  final String time;
  final String recipientUid;
  final int unreadCount;

  ChatModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.lastMessage,
    required this.time,
    required this.recipientUid,
    this.unreadCount = 0,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      photo: map['photo'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      time: map['time'] ?? '',
      recipientUid: map['recipientUid'] ?? '',
      unreadCount: map['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'lastMessage': lastMessage,
      'time': time,
      'recipientUid': recipientUid,
      'unreadCount': unreadCount,
    };
  }
}
