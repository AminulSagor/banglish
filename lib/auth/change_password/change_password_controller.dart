import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes_pages/app_routes.dart';

class ChangePasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final RxString email = ''.obs; // Email passed from OTP flow

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void changePassword() async {
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

    final hashedPassword = hashPassword(newPassword);

    try {
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email.value)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        Get.snackbar('Error', 'User not found');
        return;
      }

      final docId = query.docs.first.id;
      await FirebaseFirestore.instance.collection('users').doc(docId).update({
        'password': hashedPassword,
      });

      Get.snackbar('Success', 'Password updated successfully');
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null && args['email'] != null) {
      email.value = args['email'];
    }
    super.onInit();
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
