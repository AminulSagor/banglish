import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  final otpControllers = List.generate(5, (_) => TextEditingController());
  final otpFocusNodes = List.generate(5, (_) => FocusNode());

  RxInt secondsRemaining = 30.obs;
  Timer? _timer;
  RxBool isResendEnabled = false.obs;
  RxString email = ''.obs;

  @override
  void onInit() {
    startTimer();
    super.onInit();
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

  void resendCode() {
    if (isResendEnabled.value) {
      // TODO: Call resend API here
      startTimer();
    }
  }

  void submitOTP() {
    final code = otpControllers.map((c) => c.text).join();
    if (code.length != 5) {
      Get.snackbar('Error', 'Please enter the 5-digit code.');
      return;
    }

    // TODO: Submit the code via API
    print('Submitted OTP: $code');
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpControllers.forEach((c) => c.dispose());
    otpFocusNodes.forEach((f) => f.dispose());
    super.onClose();
  }
}
