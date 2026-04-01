class SignupPayloadModel {
  final String signupMethod;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String country;
  final String thana;
  final String division;
  final String district;
  final String gender;

  const SignupPayloadModel({
    required this.signupMethod,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.country,
    required this.thana,
    required this.division,
    required this.district,
    required this.gender,
  });

  factory SignupPayloadModel.fromJson(Map<String, dynamic> json) {
    return SignupPayloadModel(
      signupMethod: json['signupMethod'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      country: json['country'] ?? '',
      thana: json['thana'] ?? '',
      division: json['division'] ?? '',
      district: json['district'] ?? '',
      gender: json['gender'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'signupMethod': signupMethod,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
      'country': country,
      'thana': thana,
      'division': division,
      'district': district,
      'gender': gender,
    };
  }

  SignupPayloadModel copyWith({
    String? signupMethod,
    String? name,
    String? username,
    String? email,
    String? phone,
    String? password,
    String? country,
    String? thana,
    String? division,
    String? district,
    String? gender,
  }) {
    return SignupPayloadModel(
      signupMethod: signupMethod ?? this.signupMethod,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      country: country ?? this.country,
      thana: thana ?? this.thana,
      division: division ?? this.division,
      district: district ?? this.district,
      gender: gender ?? this.gender,
    );
  }
}
