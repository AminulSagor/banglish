import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import 'otp_controller.dart';

class OTPView extends GetView<OTPController> {
  const OTPView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 100.h),
              SizedBox(height: 32.h),

              Text(
                "Enter the 5-digit code sent to",
                style: TextStyle(fontSize: 16.sp, color: AppColors.blueGrey800),
              ),
              SizedBox(height: 4.h),
              Obx(
                () => Text(
                  controller.email.value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return SizedBox(
                    width: 50.w,
                    child: TextField(
                      controller: controller.otpControllers[index],
                      focusNode: controller.otpFocusNodes[index],
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: AppColors.grey100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 4) {
                          FocusScope.of(
                            context,
                          ).requestFocus(controller.otpFocusNodes[index + 1]);
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(
                            context,
                          ).requestFocus(controller.otpFocusNodes[index - 1]);
                        }
                      },
                    ),
                  );
                }),
              ),
              SizedBox(height: 24.h),

              // Resend Timer
              Obx(
                () => controller.isResendEnabled.value
                    ? TextButton(
                        onPressed: controller.resendCode,
                        child: Text(
                          "Resend Code",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Text(
                        "Resend in ${controller.secondsRemaining.value}s",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grey600,
                        ),
                      ),
              ),
              SizedBox(height: 24.h),

              // Submit Button
              Obx(
                () => CustomButton(
                  text: 'Verify',
                  onPressed: controller.submitOTP,
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
