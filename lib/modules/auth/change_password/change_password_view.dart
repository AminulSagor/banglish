import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Change Password',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                // Logo centered
                Center(child: Image.asset('assets/logo.png', height: 80.h)),
                SizedBox(height: 32.h),

                // Title
                Text(
                  'Update Your Password',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),

                // Subtitle
                Text(
                  'Make sure your new password is secure and easy to remember.',
                  style: TextStyle(color: AppColors.grey600, fontSize: 14.sp),
                ),
                SizedBox(height: 32.h),

                // Old Password
                Obx(
                  () => CustomTextField(
                    controller: controller.confirmPasswordController,
                    labelText: 'Old Password',
                    hintText: 'Old Password',
                    obscureText: controller.obscureConfirmPassword.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureConfirmPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.grey500,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // New Password
                Obx(
                  () => CustomTextField(
                    controller: controller.newPasswordController,
                    labelText: 'New Password',
                    hintText: 'New Password',
                    obscureText: controller.obscureNewPassword.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureNewPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.grey500,
                      ),
                      onPressed: controller.toggleNewPasswordVisibility,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                Obx(
                  () => CustomButton(
                    text: 'Change Password',
                    onPressed: controller.changePassword,
                    isLoading: controller.isLoading.value,
                    backgroundColor: AppColors.secondary,
                  ),
                ),
                SizedBox(height: 16.h),

                // Forgot password link
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.forgotPassword);
                    },
                    child: Text(
                      'Forgot old password, click here',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 14.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.secondary,
                      ),
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
