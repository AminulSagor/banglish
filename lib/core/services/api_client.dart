import 'package:dio/dio.dart' as dio;
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'token_service.dart';

class ApiClient extends GetxService {
  static const Duration _defaultApiTimeout = Duration(seconds: 20);

  late final dio.Dio _dio;
  final TokenService _tokenService;

  ApiClient({required TokenService tokenService, dio.Dio? client})
    : _tokenService = tokenService {
    final String baseUrl =
        dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';
    _dio =
        client ??
        dio.Dio(
          dio.BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: _defaultApiTimeout,
            sendTimeout: _defaultApiTimeout,
            receiveTimeout: _defaultApiTimeout,
            headers: const <String, String>{
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );
  }

  @override
  void onInit() {
    super.onInit();
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _tokenService.token;
          final skipAuth = options.extra['skipAuth'] == true;
          if (!skipAuth && token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 120,
      ),
    );
  }

  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  Future<ApiClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool skipAuth = false,
  }) {
    return _request<T>(
      () => _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: _buildOptions(skipAuth: skipAuth),
      ),
    );
  }

  Future<ApiClientResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool skipAuth = false,
  }) {
    return _request<T>(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(skipAuth: skipAuth),
      ),
    );
  }

  Future<ApiClientResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool skipAuth = false,
  }) {
    return _request<T>(
      () => _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(skipAuth: skipAuth),
      ),
    );
  }

  Future<ApiClientResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool skipAuth = false,
  }) {
    return _request<T>(
      () => _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(skipAuth: skipAuth),
      ),
    );
  }

  Future<ApiClientResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool skipAuth = false,
  }) {
    return _request<T>(
      () => _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(skipAuth: skipAuth),
      ),
    );
  }

  dio.Options _buildOptions({required bool skipAuth}) {
    return dio.Options(extra: <String, dynamic>{'skipAuth': skipAuth});
  }

  Future<ApiClientResponse<T>> _request<T>(
    Future<dio.Response<T>> Function() request,
  ) async {
    try {
      final response = await request();
      return ApiClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
      );
    } on dio.DioException catch (e) {
      throw ApiClientException(
        message: _extractErrorMessage(e.response?.data),
        statusCode: e.response?.statusCode,
        data: e.response?.data,
      );
    }
  }

  String _extractErrorMessage(dynamic body) {
    if (body is Map<String, dynamic>) {
      final dynamic message = body['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message;
      }
      final dynamic error = body['error'];
      if (error is String && error.trim().isNotEmpty) {
        return error;
      }
    }

    if (body is String && body.trim().isNotEmpty) {
      try {
        final dynamic decoded = jsonDecode(body);
        if (decoded is Map<String, dynamic>) {
          final dynamic message = decoded['message'];
          if (message is String && message.trim().isNotEmpty) {
            return message;
          }
          final dynamic error = decoded['error'];
          if (error is String && error.trim().isNotEmpty) {
            return error;
          }
        }
      } catch (_) {
        return body;
      }
      return body;
    }

    return 'Request failed. Please try again.';
  }
}

class ApiClientResponse<T> {
  final T? data;
  final int? statusCode;

  const ApiClientResponse({required this.data, required this.statusCode});
}

class ApiClientException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiClientException({required this.message, this.statusCode, this.data});
}
