import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'otp_controller.dart';

class OTPView extends StatelessWidget {
  final controller = Get.put(OTPController());

  OTPView({Key? key}) : super(key: key) {
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      controller.email.value = args['email'] ?? '';
      controller.expectedOtp.value = args['otp'] ?? '';
      controller.isForgetPass.value = args['isForgetPass'] ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 100.h),
            SizedBox(height: 32.h),
            Text("Enter the 5-digit code sent to", style: TextStyle(fontSize: 16.sp)),
            Obx(() => Text(
              controller.email.value,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            )),
            SizedBox(height: 32.h),
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
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 4) {
                        FocusScope.of(context).requestFocus(
                          controller.otpFocusNodes[index + 1],
                        );
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).requestFocus(
                          controller.otpFocusNodes[index - 1],
                        );
                      }
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 24.h),
            Obx(() => controller.isResendEnabled.value
                ? TextButton(
              onPressed: controller.resendCode,
              child: const Text("Resend Code"),
            )
                : Text(
              "Resend in ${controller.secondsRemaining.value}s",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            )),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.submitOTP,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
