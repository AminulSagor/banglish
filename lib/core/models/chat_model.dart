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

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      time: json['time'] ?? '',
      recipientUid: json['recipientUid'] ?? '',
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
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

  ChatModel copyWith({
    String? id,
    String? name,
    String? photo,
    String? lastMessage,
    String? time,
    String? recipientUid,
    int? unreadCount,
  }) {
    return ChatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      lastMessage: lastMessage ?? this.lastMessage,
      time: time ?? this.time,
      recipientUid: recipientUid ?? this.recipientUid,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
