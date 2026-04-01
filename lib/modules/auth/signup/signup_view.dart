import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              Text(
                'Sign Up Message Goes Here',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6.h),
              Text(
                'Sub section of the signup page',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(28.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Sign up with:',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Obx(
                            () => Row(
                              children: [
                                Expanded(
                                  child: _signupModeButton(
                                    text: 'Phone',
                                    isActive: controller.isPhoneSignup,
                                    onTap: () =>
                                        controller.setSignupMethod('phone'),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: _signupModeButton(
                                    text: 'Email',
                                    isActive: !controller.isPhoneSignup,
                                    onTap: () =>
                                        controller.setSignupMethod('email'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    _fieldLabel('Full Name'),
                    CustomTextField(
                      controller: controller.nameController,
                      hintText: 'Enter your full name',
                    ),
                    SizedBox(height: 14.h),
                    Obx(() {
                      if (controller.isPhoneSignup) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _fieldLabel('Phone'),
                            CustomTextField(
                              controller: controller.phoneController,
                              hintText: 'Enter your phone address',
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel('Email'),
                          CustomTextField(
                            controller: controller.emailController,
                            hintText: 'Enter your email address',
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 14.h),
                    _fieldLabel('Username'),
                    CustomTextField(
                      controller: controller.usernameController,
                      hintText: 'Enter your username',
                    ),
                    SizedBox(height: 14.h),
                    _fieldLabel('Your Country'),
                    Row(
                      children: [
                        Container(
                          width: 56.w,
                          height: 46.h,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.border),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'BD',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Obx(
                            () => DropdownSearch<String>(
                              items: controller.countryList,
                              selectedItem:
                                  controller.selectedCountry.value.isEmpty
                                  ? null
                                  : controller.selectedCountry.value,
                              onChanged: (value) {
                                controller.selectedCountry.value = value ?? '';
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: _dropdownDecoration(
                                  'Bangladesh',
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: 'Search country',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    _fieldLabel('Thana'),
                    CustomTextField(
                      controller: controller.thanaController,
                      hintText: '8 to 12 characters minimum',
                    ),
                    SizedBox(height: 14.h),
                    _fieldLabel('District'),
                    CustomTextField(
                      controller: controller.districtController,
                      hintText: '8 to 12 characters minimum',
                    ),
                    SizedBox(height: 14.h),
                    _fieldLabel('Password'),
                    Obx(
                      () => CustomTextField(
                        controller: controller.passwordController,
                        hintText: '8 to 12 characters minimum',
                        obscureText: controller.obscurePassword.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.primary,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Obx(
                      () => CustomButton(
                        text: 'Register',
                        onPressed: controller.signup,
                        isLoading: controller.isLoading.value,
                        height: 48.h,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Center(
                      child: Text(
                        'Or, Sign Up with',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => CustomButton(
                              text: '',
                              onPressed: controller.signupWithFacebook,
                              isLoading: controller.isFacebookLoading.value,
                              isSocial: true,
                              icon: Icon(
                                Icons.facebook,
                                color: AppColors.facebookBlue,
                                size: 34.sp,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                              height: 54.h,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Obx(
                            () => CustomButton(
                              text: '',
                              onPressed: controller.signupWithGoogle,
                              isLoading: controller.isGoogleLoading.value,
                              isSocial: true,
                              icon: Text(
                                'G',
                                style: TextStyle(
                                  color: AppColors.googleRed,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40.sp,
                                  height: 0.9,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                              height: 54.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    Center(
                      child: TextButton(
                        onPressed: controller.goToLogin,
                        child: Text(
                          'Already have an account? Login',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h, left: 2.w),
      child: RichText(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          children: const [
            TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signupModeButton({
    required String text,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 40.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isActive ? null : AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.border),
        ),
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? AppColors.white : AppColors.primary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: AppColors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }
}
