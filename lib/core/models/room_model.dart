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

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      topic: json['topic'] ?? '',
      participants: List<String>.from(json['participants'] ?? []),
      createdAt: json['createdAt'] ?? '',
      creatorUid: json['creatorUid'] ?? '',
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
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

  RoomModel copyWith({
    String? id,
    String? name,
    String? topic,
    List<String>? participants,
    String? createdAt,
    String? creatorUid,
    bool? isActive,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      topic: topic ?? this.topic,
      participants: participants ?? this.participants,
      createdAt: createdAt ?? this.createdAt,
      creatorUid: creatorUid ?? this.creatorUid,
      isActive: isActive ?? this.isActive,
    );
  }
}
