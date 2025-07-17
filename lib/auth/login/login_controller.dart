import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../routes_pages/app_routes.dart';
import '../auth_service.dart';


class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();

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
