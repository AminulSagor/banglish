import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeKnownPasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  void changePassword() {
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields");
      return;
    }

    // TODO: Replace this with actual API call
    if (oldPassword == "123456") {
      Get.snackbar("Success", "Password changed successfully");
    } else {
      Get.snackbar("Failed", "Old password is incorrect");
    }
  }

  void goToForgotPassword() {
    // Navigate to forgot password screen
    Get.toNamed("/forgot-password");
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.onClose();
  }
}
