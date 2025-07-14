import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'change_known_password_controller.dart';

class ChangeKnownPasswordView extends StatelessWidget {
  final controller = Get.put(ChangeKnownPasswordController());

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF00695C); // Teal-like professional color
    final textColor = Colors.black87;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Change Password"),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 2,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo
            Center(
              child: Image.asset('assets/logo.png', height: 80.h),
            ),
            SizedBox(height: 30.h),

            Text(
              "Update Your Password",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Make sure your new password is secure and easy to remember.",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 24.h),

            // Old Password
            TextField(
              controller: controller.oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Old Password',
                labelStyle: TextStyle(color: textColor),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // New Password
            TextField(
              controller: controller.newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(color: textColor),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Change Password Button
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: controller.changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  "Change Password",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500,color: Colors.white),
                ),
              ),
            ),

            // Forgot Link
            Center(
              child: TextButton(
                onPressed: controller.goToForgotPassword,
                child: Text(
                  "Forgot old password, click here",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
