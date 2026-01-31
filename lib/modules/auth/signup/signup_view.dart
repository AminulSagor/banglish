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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Create Account',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/logo.png', height: 100.h)),
                SizedBox(height: 24.h),

                // Name
                CustomTextField(
                  controller: controller.nameController,
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: const Icon(Icons.person),
                ),
                SizedBox(height: 16.h),

                // Email
                CustomTextField(
                  controller: controller.emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                ),
                SizedBox(height: 16.h),

                // Country Dropdown
                Obx(
                  () => DropdownSearch<String>(
                    items: controller.countryList,
                    selectedItem: controller.selectedCountry.value.isEmpty
                        ? null
                        : controller.selectedCountry.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedCountry.value = value;
                        controller.selectedDivision.value = '';
                        controller.selectedDistrict.value = '';
                      }
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: _inputDecoration('Country'),
                    ),
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          hintText: "Search country",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Division (Bangladesh only)
                Obx(() {
                  if (controller.selectedCountry.value.toLowerCase() !=
                      'bangladesh') {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: controller.selectedDivision.value.isEmpty
                            ? null
                            : controller.selectedDivision.value,
                        items: controller.divisionList
                            .map(
                              (div) => DropdownMenuItem(
                                value: div,
                                child: Text(div),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          controller.selectedDivision.value = value ?? '';
                          controller.selectedDistrict.value = '';
                        },
                        decoration: _inputDecoration('Division'),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  );
                }),

                // District (Bangladesh only)
                Obx(() {
                  if (controller.selectedCountry.value.toLowerCase() !=
                          'bangladesh' ||
                      controller.selectedDivision.value.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: controller.selectedDistrict.value.isEmpty
                            ? null
                            : controller.selectedDistrict.value,
                        items: controller.districtList
                            .map(
                              (dist) => DropdownMenuItem(
                                value: dist,
                                child: Text(dist),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          controller.selectedDistrict.value = value ?? '';
                        },
                        decoration: _inputDecoration('District'),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  );
                }),

                // Gender
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedGender.value,
                    items: ['Male', 'Female', 'Other']
                        .map(
                          (gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      controller.selectedGender.value = value ?? 'Male';
                    },
                    decoration: _inputDecoration('Gender'),
                  ),
                ),
                SizedBox(height: 16.h),

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
                SizedBox(height: 16.h),

                // Confirm Password
                Obx(
                  () => CustomTextField(
                    controller: controller.confirmPasswordController,
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your password',
                    obscureText: controller.obscureConfirmPassword.value,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureConfirmPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Sign Up Button
                Obx(
                  () => CustomButton(
                    text: 'Sign Up',
                    onPressed: controller.signup,
                    isLoading: controller.isLoading.value,
                  ),
                ),
                SizedBox(height: 16.h),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    TextButton(
                      onPressed: controller.goToLogin,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: AppColors.grey100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }
}
