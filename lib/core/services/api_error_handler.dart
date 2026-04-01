import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

/// Handles service errors consistently and returns a fixed response contract.
class ApiErrorHandler {
  Future<ApiResponse<T>> call<T>(
    Future<T> Function() serviceCall, {
    String defaultErrorCode = 'UNKNOWN_ERROR',
    bool showSnackbar = true,
  }) async {
    try {
      final data = await serviceCall();
      return ApiResponse<T>.success(data);
    } on ApiServiceException catch (e) {
      if (showSnackbar) {
        Get.snackbar('Error', e.message);
      }
      return ApiResponse<T>.failure(errorCode: e.errorCode ?? defaultErrorCode);
    } on FirebaseAuthException catch (e) {
      if (showSnackbar) {
        Get.snackbar('Error', e.message ?? 'Authentication failed');
      }
      return ApiResponse<T>.failure(errorCode: e.code);
    } catch (_) {
      if (showSnackbar) {
        Get.snackbar('Error', 'Something went wrong. Please try again.');
      }
      return ApiResponse<T>.failure(errorCode: defaultErrorCode);
    }
  }
}

/// Exception raised by module services when API calls fail with known messages.
class ApiServiceException implements Exception {
  final String message;
  final String? errorCode;

  const ApiServiceException({required this.message, this.errorCode});
}

/// Standard API response wrapper for service-controller communication.
class ApiResponse<T> {
  final T? data;
  final bool success;
  final String? errorCode;

  const ApiResponse({
    required this.data,
    required this.success,
    this.errorCode,
  });

  factory ApiResponse.success(T? data) {
    return ApiResponse<T>(data: data, success: true);
  }

  factory ApiResponse.failure({String? errorCode, T? data}) {
    return ApiResponse<T>(data: data, success: false, errorCode: errorCode);
  }
}
