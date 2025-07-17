import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes_pages/app_routes.dart';
import '../auth_service.dart';

class OTPController extends GetxController {
  final otpControllers = List.generate(5, (_) => TextEditingController());
  final otpFocusNodes = List.generate(5, (_) => FocusNode());
  final AuthService _authService = AuthService();

  RxInt secondsRemaining = 30.obs;
  Timer? _timer;
  RxBool isResendEnabled = false.obs;
  RxString email = ''.obs;

  // ✅ Add this line to fix the error
  RxString expectedOtp = ''.obs;

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

  void resendCode() async {
    if (!isResendEnabled.value) return;

    final newOtp = (10000 + (DateTime.now().millisecondsSinceEpoch % 90000)).toString();

    try {
      await _authService.sendOTPEmail(email.value, newOtp);
      expectedOtp.value = newOtp;
      Get.snackbar('OTP Sent', 'A new OTP has been sent to your email.');
      startTimer();
    } catch (e) {
      Get.snackbar('Error', 'Failed to resend OTP: $e');
    }
  }



  void submitOTP() async {
    final code = otpControllers.map((c) => c.text).join();

    if (code.length != 5) {
      Get.snackbar('Error', 'Please enter the 5-digit code.');
      return;
    }

    if (code == expectedOtp.value) {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'isLoggedIn': true,
          'isVerified': true,
          'lastLogin': FieldValue.serverTimestamp(),
        });

        Get.snackbar('Success', 'OTP Verified!');
        Get.offAllNamed(AppRoutes.home); // ✅ Go to Home
      } else {
        Get.snackbar('Error', 'User not found.');
      }
    } else {
      Get.snackbar('Error', 'Invalid OTP. Please try again.');
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpControllers.forEach((c) => c.dispose());
    otpFocusNodes.forEach((f) => f.dispose());
    super.onClose();
  }
}
