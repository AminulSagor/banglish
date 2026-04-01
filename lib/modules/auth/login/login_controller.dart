import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/services/api_error_handler.dart';
import '../models/auth_models.dart';
import '../services/auth_module_service.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthModuleService _authService = Get.find<AuthModuleService>();
  final ApiErrorHandler _apiErrorHandler = Get.find<ApiErrorHandler>();
  final currentUser = Rxn<AuthUserUiModel>();

  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;
  final obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email and password cannot be empty',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    isLoading.value = true;

    final payload = LoginPayloadModel(email: email, password: password);
    final ApiResponse<AuthUserUiModel?> response = await _apiErrorHandler.call(
      () => _authService.login(payload),
      defaultErrorCode: 'LOGIN_FAILED',
    );

    if (response.success && response.data != null) {
      currentUser.value = response.data;
      Get.snackbar(
        'Success',
        'Login successful!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      Get.offAllNamed(AppRoutes.mainNavigation);
    }

    isLoading.value = false;
  }

  void loginWithGoogle() async {
    isGoogleLoading.value = true;
    final response = await _apiErrorHandler.call<AuthUserUiModel?>(
      () => _authService.signInWithGoogle(),
      defaultErrorCode: 'GOOGLE_LOGIN_FAILED',
    );

    if (response.success && response.data != null) {
      currentUser.value = response.data;
      Get.snackbar(
        'Success',
        'Google login successful!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      Get.offAllNamed(AppRoutes.mainNavigation);
    }

    isGoogleLoading.value = false;
  }

  void loginWithFacebook() async {
    isFacebookLoading.value = true;
    final response = await _apiErrorHandler.call<AuthUserUiModel?>(
      () => _authService.signInWithFacebook(),
      defaultErrorCode: 'FACEBOOK_LOGIN_FAILED',
    );

    if (response.success && response.data != null) {
      currentUser.value = response.data;
      Get.snackbar(
        'Success',
        'Facebook login successful!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      Get.offAllNamed(AppRoutes.mainNavigation);
    }

    isFacebookLoading.value = false;
  }

  void goToSignUp() {
    Get.toNamed(AppRoutes.signup);
  }

  void goToForgetPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
