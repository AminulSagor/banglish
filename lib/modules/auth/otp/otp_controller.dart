import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class OTPController extends GetxController {
  final otpControllers = List.generate(5, (_) => TextEditingController());
  final otpFocusNodes = List.generate(5, (_) => FocusNode());

  RxInt secondsRemaining = 30.obs;
  Timer? _timer;
  RxBool isResendEnabled = false.obs;
  RxString email = ''.obs;
  RxString expectedOtp = ''.obs;
  RxBool isForgetPass = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      email.value = args['email'] ?? '';
      expectedOtp.value = args['otp'] ?? '';
      isForgetPass.value = args['isForgetPass'] ?? false;
    }
    startTimer();
  }

  void startTimer() {
    isResendEnabled.value = false;
    secondsRemaining.value = 30;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value == 0) {
        isResendEnabled.value = true;
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  void resendCode() async {
    if (!isResendEnabled.value) return;

    final newOtp = _generateOTP(5);

    // Simulate sending OTP
    await Future.delayed(const Duration(milliseconds: 500));

    expectedOtp.value = newOtp;
    Get.snackbar(
      'OTP Sent',
      'A new OTP has been sent. (Mock: $newOtp)',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
    );
    startTimer();
  }

  String _generateOTP(int length) {
    final random = Random();
    return List.generate(length, (_) => random.nextInt(10)).join();
  }

  void submitOTP() async {
    final code = otpControllers.map((c) => c.text).join();

    if (code.length != 5) {
      Get.snackbar(
        'Error',
        'Please enter the 5-digit code.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    isLoading.value = true;

    try {
      // Simulate verification
      await Future.delayed(const Duration(milliseconds: 500));

      if (code == expectedOtp.value) {
        Get.snackbar(
          'Success',
          'OTP Verified!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(10),
        );

        if (isForgetPass.value) {
          Get.toNamed(
            AppRoutes.changePassword,
            arguments: {'email': email.value},
          );
        } else {
          Get.offAllNamed(AppRoutes.bottomNav);
        }
      } else {
        Get.snackbar(
          'Error',
          'Invalid OTP. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(10),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
