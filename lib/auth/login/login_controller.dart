import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../routes_pages/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Perform login logic here
    print("Logging in with $email and $password");
    // Navigate after login: Get.offNamed(AppRoutes.home);
  }

  void loginWithGoogle() {
    // Google login logic
  }

  void loginWithFacebook() {
    // Facebook login logic
  }

  void goToSignUp() {
    Get.toNamed(AppRoutes.signUp);
  }

  void goToForgetPassword() {
    Get.toNamed(AppRoutes.forgetPassword);
  }
}
