import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  RxString expectedOtp = ''.obs;
  RxBool isForgetPass = false.obs;

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

    final newOtp = _generateOTP(5);
    try {
      await _authService.sendOTPEmail(email.value, newOtp);
      expectedOtp.value = newOtp;
      Get.snackbar('OTP Sent', 'A new OTP has been sent to your email.');
      startTimer();
    } catch (e) {
      Get.snackbar('Error', 'Failed to resend OTP: $e');
    }
  }

  String _generateOTP(int length) {
    final random = Random();
    return List.generate(length, (_) => random.nextInt(10)).join();
  }

  void submitOTP() async {
    final code = otpControllers.map((c) => c.text).join();

    if (code.length != 5) {
      Get.snackbar('Error', 'Please enter the 5-digit code.');
      return;
    }

    if (code == expectedOtp.value) {
      if (isForgetPass.value) {
        Get.snackbar('Success', 'OTP Verified!');
        Get.toNamed(AppRoutes.changePassword, arguments: {'email': email.value});
        return;
      }

      try {
        final query = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email.value)
            .limit(1)
            .get();

        if (query.docs.isNotEmpty) {
          final doc = query.docs.first;
          final docId = doc.id;

          await FirebaseFirestore.instance.collection('users').doc(docId).update({
            'isVerified': true,
            'lastLogin': FieldValue.serverTimestamp(),
          });

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('uid', docId);

          Get.snackbar('Success', 'Account Verified!');
          Get.offAllNamed(AppRoutes.home);
        } else {
          Get.snackbar('Error', 'User not found.');
        }
      } catch (e) {
        Get.snackbar('Error', 'Something went wrong: $e');
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
