class SharedUiStateModel {
  final bool isLoading;
  final String? errorCode;

  const SharedUiStateModel({this.isLoading = false, this.errorCode});

  factory SharedUiStateModel.fromJson(Map<String, dynamic> json) {
    return SharedUiStateModel(
      isLoading: json['isLoading'] ?? false,
      errorCode: json['errorCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'isLoading': isLoading, 'errorCode': errorCode};
  }

  SharedUiStateModel copyWith({bool? isLoading, String? errorCode}) {
    return SharedUiStateModel(
      isLoading: isLoading ?? this.isLoading,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}
