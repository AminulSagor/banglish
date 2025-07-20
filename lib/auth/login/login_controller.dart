import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes_pages/app_routes.dart';
import '../auth_service.dart';


class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();


  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      // 🔍 Get user by email
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        Get.snackbar('Error', 'User not found',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      final doc = query.docs.first;
      final userData = doc.data();
      final storedHashedPassword = userData['password'];
      final isVerified = userData['isVerified'] ?? false;

      // 🔐 Hash entered password
      final hashedInputPassword = hashPassword(password);

      if (hashedInputPassword != storedHashedPassword) {
        Get.snackbar('Error', 'Incorrect password',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      if (!isVerified) {
        Get.snackbar('Not Verified', 'Please verify your email before login.',
            backgroundColor: Colors.orange, colorText: Colors.white);
        return;
      }

      // ✅ Update login flag
      await FirebaseFirestore.instance.collection('users').doc(doc.id).update({
        'isLoggedIn': true,
        'lastLogin': FieldValue.serverTimestamp(),
      });


      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', doc.id);

      // 🎯 Navigate to home
      Get.offNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Login Failed', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      print('❌ Login Error: $e');
    }
  }



  void loginWithGoogle() async {
    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null) {
        Get.snackbar("Success", "Logged in as ${userCredential.user?.displayName}",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offNamed(AppRoutes.home);
      }
    } catch (e) {
      Get.snackbar("Login Failed", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void loginWithFacebook() async {
    try {
      final userCredential = await _authService.signInWithFacebook();
      if (userCredential != null) {
        Get.snackbar("Success", "Logged in as ${userCredential.user?.displayName}",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offNamed(AppRoutes.home);
      }
    } catch (e) {
      Get.snackbar("Login Failed", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }


  void goToSignUp() {
    Get.toNamed(AppRoutes.signUp);
  }

  void goToForgetPassword() {
    Get.toNamed(AppRoutes.forgetPassword);
  }
}
