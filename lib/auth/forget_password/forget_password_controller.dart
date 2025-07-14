import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes_pages/app_routes.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();

  void goToOTP() {
    final email = emailController.text.trim();
    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Invalid Email', 'Please enter a valid email address');
      return;
    }

    // TODO: Call API to request OTP or reset
    print('Sending reset to: $email');

    // Navigate to OTP screen and pass email if needed
    Get.toNamed(AppRoutes.otp);
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
