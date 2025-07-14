import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'signup_controller.dart';

class SignUpView extends StatelessWidget {
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/logo.png', height: 120.h)),
              SizedBox(height: 30.h),

              _buildInput("Name", controller.nameController),
              _buildInput("Email", controller.emailController),

              // Country Dropdown (Searchable)
              Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedCountry.value.isEmpty
                    ? null
                    : controller.selectedCountry.value,
                items: controller.countryList
                    .map((country) => DropdownMenuItem(
                  value: country,
                  child: Text(country),
                ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedCountry.value = value!;
                },
                decoration: _inputDecoration('Country'),
              )),

              SizedBox(height: 16.h),

              // Division (if country == Bangladesh)
              Obx(() => controller.selectedCountry.value.toLowerCase() == 'bangladesh'
                  ? DropdownButtonFormField<String>(
                value: controller.selectedDivision.value.isEmpty
                    ? null
                    : controller.selectedDivision.value,
                items: controller.divisionList
                    .map((div) => DropdownMenuItem(
                  value: div,
                  child: Text(div),
                ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedDivision.value = value!;
                },
                decoration: _inputDecoration('Division'),
              )
                  : SizedBox.shrink()),

              // Show space only if country is Bangladesh
              Obx(() => controller.selectedCountry.value.toLowerCase() == 'bangladesh'
                  ? SizedBox(height: 16.h)
                  : SizedBox.shrink()),


              // District (if country == Bangladesh)
              Obx(() => controller.selectedCountry.value.toLowerCase() == 'bangladesh'
                  ? DropdownButtonFormField<String>(
                value: controller.selectedDistrict.value.isEmpty
                    ? null
                    : controller.selectedDistrict.value,
                items: controller.districtList
                    .map((dist) => DropdownMenuItem(
                  value: dist,
                  child: Text(dist),
                ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedDistrict.value = value!;
                },
                decoration: _inputDecoration('District'),
              )
                  : SizedBox.shrink()),

              // Show space only if country is Bangladesh
              Obx(() => controller.selectedCountry.value.toLowerCase() == 'bangladesh'
                  ? SizedBox(height: 16.h)
                  : SizedBox.shrink()),


              // Gender
              Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedGender.value,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedGender.value = value!;
                },
                decoration: _inputDecoration('Gender'),
              )),

              SizedBox(height: 16.h),

              _buildInput("Password", controller.passwordController, obscure: true),
              _buildInput("Confirm Password", controller.confirmPasswordController, obscure: true),

              SizedBox(height: 30.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/login'); // Replace with your actual login route
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
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

  Widget _buildInput(String label, TextEditingController controller,
      {bool obscure = false, Function(String)? onChanged}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        onChanged: onChanged,
        decoration: _inputDecoration(label),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
    );
  }
}
