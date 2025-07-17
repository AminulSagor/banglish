import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../routes_pages/app_routes.dart';
import '../auth_service.dart';


class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      // 🔐 Sign in using FirebaseAuth
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user?.uid;
      if (uid == null) throw 'User UID not found';

      // 📄 Fetch user info from Firestore
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        Get.snackbar('Error', 'User data not found in Firestore',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      final userData = userDoc.data()!;
      final isVerified = userData['isVerified'] ?? false;

      if (!isVerified) {
        Get.snackbar('Not Verified', 'Please verify your email before login.',
            backgroundColor: Colors.orange, colorText: Colors.white);
        return;
      }

      // ✅ Update login flag
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'isLoggedIn': true,
        'lastLogin': FieldValue.serverTimestamp(),
      });

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
