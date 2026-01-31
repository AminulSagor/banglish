/// Room model for group/video rooms
class RoomModel {
  final String id;
  final String name;
  final String topic;
  final List<String> participants;
  final String createdAt;
  final String creatorUid;
  final bool isActive;

  RoomModel({
    required this.id,
    required this.name,
    required this.topic,
    required this.participants,
    required this.createdAt,
    required this.creatorUid,
    this.isActive = true,
  });

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      topic: map['topic'] ?? '',
      participants: List<String>.from(map['participants'] ?? []),
      createdAt: map['createdAt'] ?? '',
      creatorUid: map['creatorUid'] ?? '',
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'topic': topic,
      'participants': participants,
      'createdAt': createdAt,
      'creatorUid': creatorUid,
      'isActive': isActive,
    };
  }
}
