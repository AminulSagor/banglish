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

  factory UserModel.fromJson(Map<String, dynamic> json, {required String uid}) {
    return UserModel(
      uid: uid,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      country: json['country'] ?? '',
      division: json['division'] ?? '',
      district: json['district'] ?? '',
      gender: json['gender'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      isVerified: json['isVerified'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      lastLogin: json['lastLogin'] != null
          ? DateTime.tryParse(json['lastLogin'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
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
