import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

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

    try {
      // Generate mock OTP
      final otp = _generateOTP(5);

      // Simulate sending OTP
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(
        'Success',
        'OTP sent to $email (Mock: $otp)',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );

      Get.toNamed(
        AppRoutes.otp,
        arguments: {'email': email, 'otp': otp, 'isForgetPass': true},
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
    } finally {
      isLoading.value = false;
    }
  }

  String _generateOTP(int length) {
    final random = Random();
    return List.generate(length, (_) => random.nextInt(10)).join();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
