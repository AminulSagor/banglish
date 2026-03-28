class OtpUiModel {
  final String email;
  final String otp;

  const OtpUiModel({required this.email, required this.otp});

  factory OtpUiModel.fromJson(Map<String, dynamic> json) {
    return OtpUiModel(email: json['email'] ?? '', otp: json['otp'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }

  OtpUiModel copyWith({String? email, String? otp}) {
    return OtpUiModel(email: email ?? this.email, otp: otp ?? this.otp);
  }
}
