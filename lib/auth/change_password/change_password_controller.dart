import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void changePassword() {
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar('Weak Password', 'Password must be at least 6 characters');
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar('Mismatch', 'Passwords do not match');
      return;
    }

    // TODO: Call your password change API here
    print('Password changed to: $newPassword');

    Get.snackbar('Success', 'Password changed successfully');
    // Optionally navigate back to login
    // Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
