import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/services/api_client.dart';
import '../../../core/services/api_error_handler.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/token_service.dart';
import '../models/auth_models.dart';

class AuthModuleService {
  AuthModuleService({
    required AuthService authService,
    required ApiClient apiClient,
    required TokenService tokenService,
  }) : _authService = authService,
       _apiClient = apiClient,
       _tokenService = tokenService;

  final AuthService _authService;
  final ApiClient _apiClient;
  final TokenService _tokenService;

  Future<AuthUserUiModel?> login(LoginPayloadModel payload) async {
    final response = await _safePost(
      '/auth/login',
      data: payload.toJson(),
      skipAuth: true,
    );

    return _parseAuthUserResponse(response, fallbackSignupMethod: 'email');
  }

  Future<AuthUserUiModel?> signup(SignupPayloadModel payload) async {
    if (payload.email.isEmpty && payload.phone.isEmpty) {
      throw const ApiServiceException(
        message: 'Email or phone is required for signup.',
        errorCode: 'INVALID_SIGNUP_PAYLOAD',
      );
    }

    final Map<String, dynamic> requestBody = <String, dynamic>{
      'password': payload.password,
      'profile': {
        'fullName': payload.name,
        'country': payload.country,
        'district': payload.district,
        'thana': payload.thana,
      },
    };

    if (payload.email.isNotEmpty) {
      requestBody['email'] = payload.email;
    }
    if (payload.phone.isNotEmpty) {
      requestBody['phone'] = payload.phone;
    }

    final response = await _safePost(
      '/auth/register',
      data: requestBody,
      skipAuth: true,
    );

    return _parseAuthUserResponse(
      response,
      fallbackSignupMethod: payload.signupMethod,
    );
  }

  Future<AuthUserUiModel?> signInWithGoogle() async {
    final userCredential = await _authService.signInWithGoogle();
    return _toAuthUiModel(userCredential?.user);
  }

  Future<AuthUserUiModel?> signInWithFacebook() async {
    final userCredential = await _authService.signInWithFacebook();
    return _toAuthUiModel(userCredential?.user);
  }

  Future<OtpUiModel> requestPasswordReset(
    ForgotPasswordPayloadModel payload,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final otp = _generateOtp(5);
    return OtpUiModel.fromJson({'email': payload.email, 'otp': otp});
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _tokenService.clearToken();
  }

  AuthUserUiModel _toAuthUiModel(User? user) {
    return AuthUserUiModel.fromJson({
      'uid': user?.uid ?? '',
      'name': user?.displayName ?? '',
      'username': user?.displayName ?? '',
      'email': user?.email ?? '',
      'phone': user?.phoneNumber ?? '',
      'photoUrl': user?.photoURL ?? '',
      'isVerified': user?.emailVerified ?? false,
      'signupMethod': 'social',
      'country': '',
      'thana': '',
      'division': '',
      'district': '',
      'gender': '',
    });
  }

  String _generateOtp(int length) {
    final random = Random();
    return List.generate(length, (_) => random.nextInt(10)).join();
  }

  AuthUserUiModel _parseAuthUserResponse(
    ApiClientResponse<dynamic> response, {
    required String fallbackSignupMethod,
  }) {
    final Map<String, dynamic> decoded = _decodeResponseBody(response.data);
    final int statusCode = response.statusCode ?? 404;
    final bool success = decoded['success'] == true;

    if ((statusCode == 200 || statusCode == 201) && success) {
      final Map<String, dynamic> data =
          (decoded['data'] as Map<String, dynamic>?) ?? <String, dynamic>{};
      final String? token = _extractToken(data);
      if (token != null && token.isNotEmpty) {
        _tokenService.setToken(token);
      }
      final Map<String, dynamic> user =
          (data['user'] as Map<String, dynamic>?) ?? <String, dynamic>{};
      final Map<String, dynamic> profile =
          (user['profile'] as Map<String, dynamic>?) ?? <String, dynamic>{};

      return AuthUserUiModel.fromJson({
        'uid': user['id'] ?? '',
        'name': profile['fullName'] ?? '',
        'username': profile['fullName'] ?? '',
        'email': user['email'] ?? '',
        'phone': user['phone'] ?? '',
        'photoUrl': profile['profilePicture'] ?? '',
        'isVerified': user['isVerified'] ?? false,
        'signupMethod': user['email'] != null
            ? 'email'
            : (user['phone'] != null ? 'phone' : fallbackSignupMethod),
        'country': profile['country'] ?? '',
        'thana': profile['thana'] ?? '',
        'division': profile['division'] ?? '',
        'district': profile['district'] ?? '',
        'gender': profile['gender'] ?? '',
      });
    }

    throw ApiServiceException(
      message: _extractErrorMessage(decoded),
      errorCode: 'AUTH_REQUEST_FAILED',
    );
  }

  Map<String, dynamic> _decodeResponseBody(dynamic body) {
    if (body == null) {
      return <String, dynamic>{};
    }

    if (body is Map<String, dynamic>) {
      return body;
    }

    if (body is String && body.isNotEmpty) {
      final dynamic decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    }

    throw const ApiServiceException(
      message: 'Unexpected server response format.',
      errorCode: 'INVALID_RESPONSE_FORMAT',
    );
  }

  String _extractErrorMessage(Map<String, dynamic> decoded) {
    final dynamic message = decoded['message'];
    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    final dynamic error = decoded['error'];
    if (error is String && error.trim().isNotEmpty) {
      return error;
    }

    return 'Request failed. Please check credentials and try again.';
  }

  String? _extractToken(Map<String, dynamic> data) {
    final dynamic directToken = data['token'] ?? data['accessToken'];
    if (directToken is String && directToken.isNotEmpty) {
      return directToken;
    }

    final dynamic auth = data['auth'];
    if (auth is Map<String, dynamic>) {
      final dynamic nestedToken = auth['token'] ?? auth['accessToken'];
      if (nestedToken is String && nestedToken.isNotEmpty) {
        return nestedToken;
      }
    }

    return null;
  }

  Future<ApiClientResponse<dynamic>> _safePost(
    String path, {
    required dynamic data,
    bool skipAuth = false,
  }) async {
    try {
      return await _apiClient.post<dynamic>(
        path,
        data: data,
        skipAuth: skipAuth,
      );
    } on ApiClientException catch (e) {
      final Map<String, dynamic> payload = _decodeResponseBody(e.data);
      throw ApiServiceException(
        message: e.message.isNotEmpty
            ? e.message
            : _extractErrorMessage(payload),
        errorCode: 'AUTH_REQUEST_FAILED',
      );
    }
  }
}
