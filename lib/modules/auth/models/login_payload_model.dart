class LoginPayloadModel {
  final String email;
  final String password;

  const LoginPayloadModel({required this.email, required this.password});

  factory LoginPayloadModel.fromJson(Map<String, dynamic> json) {
    return LoginPayloadModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  LoginPayloadModel copyWith({String? email, String? password}) {
    return LoginPayloadModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
