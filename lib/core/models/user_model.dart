/// User model for the application
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String country;
  final String division;
  final String district;
  final String gender;
  final String photoUrl;
  final bool isVerified;
  final DateTime? createdAt;
  final DateTime? lastLogin;

  UserModel({
    required this.uid,
    required this.name,
    this.email = '',
    required this.country,
    this.division = '',
    this.district = '',
    required this.gender,
    this.photoUrl = '',
    this.isVerified = false,
    this.createdAt,
    this.lastLogin,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, {required String uid}) {
    return UserModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      country: map['country'] ?? '',
      division: map['division'] ?? '',
      district: map['district'] ?? '',
      gender: map['gender'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      isVerified: map['isVerified'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString())
          : null,
      lastLogin: map['lastLogin'] != null
          ? DateTime.tryParse(map['lastLogin'].toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'country': country,
      'division': division,
      'district': district,
      'gender': gender,
      'photoUrl': photoUrl,
      'isVerified': isVerified,
      'createdAt': createdAt?.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? country,
    String? division,
    String? district,
    String? gender,
    String? photoUrl,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      country: country ?? this.country,
      division: division ?? this.division,
      district: district ?? this.district,
      gender: gender ?? this.gender,
      photoUrl: photoUrl ?? this.photoUrl,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}
