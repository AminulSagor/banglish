class ForgotPasswordPayloadModel {
  final String email;

  const ForgotPasswordPayloadModel({required this.email});

  factory ForgotPasswordPayloadModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordPayloadModel(email: json['email'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'email': email};
  }

  ForgotPasswordPayloadModel copyWith({String? email}) {
    return ForgotPasswordPayloadModel(email: email ?? this.email);
  }
}
