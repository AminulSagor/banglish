class SignupPayloadModel {
  final String name;
  final String email;
  final String password;
  final String country;
  final String division;
  final String district;
  final String gender;

  const SignupPayloadModel({
    required this.name,
    required this.email,
    required this.password,
    required this.country,
    required this.division,
    required this.district,
    required this.gender,
  });

  factory SignupPayloadModel.fromJson(Map<String, dynamic> json) {
    return SignupPayloadModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      country: json['country'] ?? '',
      division: json['division'] ?? '',
      district: json['district'] ?? '',
      gender: json['gender'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'country': country,
      'division': division,
      'district': district,
      'gender': gender,
    };
  }

  SignupPayloadModel copyWith({
    String? name,
    String? email,
    String? password,
    String? country,
    String? division,
    String? district,
    String? gender,
  }) {
    return SignupPayloadModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      country: country ?? this.country,
      division: division ?? this.division,
      district: district ?? this.district,
      gender: gender ?? this.gender,
    );
  }
}
