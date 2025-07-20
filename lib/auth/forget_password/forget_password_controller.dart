import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../routes_pages/app_routes.dart';
import '../auth_service.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final AuthService _authService = AuthService();

  void goToOTP() async {
    final email = emailController.text.trim();

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Invalid Email', 'Please enter a valid email address');
      return;
    }

    try {
      // 🔍 Check if email exists in Firestore 'users' collection
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        Get.snackbar('Not Registered', 'You are not registered. Try Sign Up.');
        return;
      }

      // ✅ Generate 5-digit OTP
      final otp = _generateOTP(5);
      print('✅ Generated OTP: $otp');

      // ✉️ Send the OTP via email
      await _authService.sendOTPEmail(email, otp);
      Get.snackbar('Success', 'OTP sent to $email');

      // 🚀 Navigate to OTP screen with arguments
      Get.toNamed(AppRoutes.otp, arguments: {
        'email': email,
        'otp': otp,
        'isForgetPass': true,
      });


    } catch (e) {
      print('❌ Error: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  String _generateOTP(int length) {
    final random = Random();
    return List.generate(length, (_) => random.nextInt(10)).join(); // e.g., 38401
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
