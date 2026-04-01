import 'package:get/get.dart';

/// Stores the auth token for API requests.
class TokenService extends GetxService {
  String? _token;

  String? get token => _token;

  void setToken(String? value) {
    _token = value;
  }

  void clearToken() {
    _token = null;
  }
}
