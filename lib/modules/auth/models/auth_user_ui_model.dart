class AuthUserUiModel {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final bool isVerified;
  final String country;
  final String division;
  final String district;
  final String gender;

  const AuthUserUiModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.isVerified,
    required this.country,
    required this.division,
    required this.district,
    required this.gender,
  });

  factory AuthUserUiModel.fromJson(Map<String, dynamic> json) {
    return AuthUserUiModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      isVerified: json['isVerified'] ?? false,
      country: json['country'] ?? '',
      division: json['division'] ?? '',
      district: json['district'] ?? '',
      gender: json['gender'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'isVerified': isVerified,
      'country': country,
      'division': division,
      'district': district,
      'gender': gender,
    };
  }

  AuthUserUiModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    bool? isVerified,
    String? country,
    String? division,
    String? district,
    String? gender,
  }) {
    return AuthUserUiModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      isVerified: isVerified ?? this.isVerified,
      country: country ?? this.country,
      division: division ?? this.division,
      district: district ?? this.district,
      gender: gender ?? this.gender,
    );
  }
}
