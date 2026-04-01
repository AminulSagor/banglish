class AuthUserUiModel {
  final String uid;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String photoUrl;
  final bool isVerified;
  final String signupMethod;
  final String country;
  final String thana;
  final String division;
  final String district;
  final String gender;

  const AuthUserUiModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.photoUrl,
    required this.isVerified,
    required this.signupMethod,
    required this.country,
    required this.thana,
    required this.division,
    required this.district,
    required this.gender,
  });

  factory AuthUserUiModel.fromJson(Map<String, dynamic> json) {
    return AuthUserUiModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      isVerified: json['isVerified'] ?? false,
      signupMethod: json['signupMethod'] ?? '',
      country: json['country'] ?? '',
      thana: json['thana'] ?? '',
      division: json['division'] ?? '',
      district: json['district'] ?? '',
      gender: json['gender'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'isVerified': isVerified,
      'signupMethod': signupMethod,
      'country': country,
      'thana': thana,
      'division': division,
      'district': district,
      'gender': gender,
    };
  }

  AuthUserUiModel copyWith({
    String? uid,
    String? name,
    String? username,
    String? email,
    String? phone,
    String? photoUrl,
    bool? isVerified,
    String? signupMethod,
    String? country,
    String? thana,
    String? division,
    String? district,
    String? gender,
  }) {
    return AuthUserUiModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      isVerified: isVerified ?? this.isVerified,
      signupMethod: signupMethod ?? this.signupMethod,
      country: country ?? this.country,
      thana: thana ?? this.thana,
      division: division ?? this.division,
      district: district ?? this.district,
      gender: gender ?? this.gender,
    );
  }
}
