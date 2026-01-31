import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../core/services/auth_service.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();

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

    try {
      // TODO: Implement actual login logic with backend
      // For now, simulate a login delay
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(
        'Success',
        'Login successful!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );

      Get.offAllNamed(AppRoutes.bottomNav);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void loginWithGoogle() async {
    isGoogleLoading.value = true;
    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null) {
        Get.snackbar(
          'Success',
          'Google login successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(10),
        );
        Get.offAllNamed(AppRoutes.bottomNav);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google login failed: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
    } finally {
      isGoogleLoading.value = false;
    }
  }

  void loginWithFacebook() async {
    isFacebookLoading.value = true;
    try {
      final userCredential = await _authService.signInWithFacebook();
      if (userCredential != null) {
        Get.snackbar(
          'Success',
          'Facebook login successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(10),
        );
        Get.offAllNamed(AppRoutes.bottomNav);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Facebook login failed: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
    } finally {
      isFacebookLoading.value = false;
    }
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
