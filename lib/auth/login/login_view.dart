import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.blue.shade700;
    final accentColor = Colors.grey.shade200;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Logo
                Image.asset('assets/logo.png', height: 140.h),

                SizedBox(height: 40.h),

                // Email
                TextField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    filled: true,
                    fillColor: accentColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Password
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    filled: true,
                    fillColor: accentColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 25.h),

                // Social logins
                Text(
                  "Or login with",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: controller.loginWithGoogle,
                      icon: Icon(Icons.g_mobiledata, color: Colors.white),
                      label: Text('Google', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: controller.loginWithFacebook,
                      icon: Icon(Icons.facebook, color: Colors.white),
                      label: Text('Facebook', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
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
                    Text("Don't have an account? ",
                        style: TextStyle(fontSize: 14.sp)),
                    TextButton(
                      onPressed: controller.goToSignUp,
                      child: Text("Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: primaryColor)),
                    ),
                  ],
                ),

                // Forget password
                TextButton(
                  onPressed: controller.goToForgetPassword,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
