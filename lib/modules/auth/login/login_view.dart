import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Logo
                  Image.asset('assets/logo.png', height: 140.h),
                  SizedBox(height: 40.h),

                  // Email
                  CustomTextField(
                    controller: controller.emailController,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  SizedBox(height: 20.h),

                  // Password
                  Obx(
                    () => CustomTextField(
                      controller: controller.passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      obscureText: controller.obscurePassword.value,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Login Button
                  Obx(
                    () => CustomButton(
                      text: 'Login',
                      onPressed: controller.login,
                      isLoading: controller.isLoading.value,
                    ),
                  ),
                  SizedBox(height: 25.h),

                  // Social logins
                  Text(
                    "Or login with",
                    style: TextStyle(color: AppColors.grey600, fontSize: 14.sp),
                  ),
                  SizedBox(height: 15.h),

                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => CustomButton(
                            text: 'Google',
                            onPressed: controller.loginWithGoogle,
                            isLoading: controller.isGoogleLoading.value,
                            backgroundColor: AppColors.googleRed,
                            icon: Icon(
                              Icons.g_mobiledata,
                              color: AppColors.white,
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Obx(
                          () => CustomButton(
                            text: 'Facebook',
                            onPressed: controller.loginWithFacebook,
                            isLoading: controller.isFacebookLoading.value,
                            backgroundColor: AppColors.facebookBlue,
                            icon: Icon(
                              Icons.facebook,
                              color: AppColors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),

                  // SignUp link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      TextButton(
                        onPressed: controller.goToSignUp,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Forget password
                  TextButton(
                    onPressed: controller.goToForgetPassword,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
