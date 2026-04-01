import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api_error_handler.dart';
import '../../../routes/app_routes.dart';
import '../models/auth_models.dart';
import '../services/auth_module_service.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;
  final ApiErrorHandler _apiErrorHandler = Get.find<ApiErrorHandler>();
  final AuthModuleService _authService = Get.find<AuthModuleService>();

  void goToOTP() async {
    final email = emailController.text.trim();

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    isLoading.value = true;

    final payload = ForgotPasswordPayloadModel(email: email);
    final ApiResponse<OtpUiModel> response = await _apiErrorHandler.call(
      () => _authService.requestPasswordReset(payload),
      defaultErrorCode: 'OTP_SEND_FAILED',
    );

    if (response.success && response.data != null) {
      final otpData = response.data!;
      Get.snackbar(
        'Success',
        'OTP sent to ${otpData.email} (Mock: ${otpData.otp})',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );

      Get.toNamed(
        AppRoutes.otp,
        arguments: {
          'email': otpData.email,
          'otp': otpData.otp,
          'isForgetPass': true,
        },
      );
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
