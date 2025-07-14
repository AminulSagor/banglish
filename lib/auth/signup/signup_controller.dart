import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var countryList = ['Bangladesh', 'India', 'USA', 'UK', 'Canada'].obs;
  var selectedCountry = ''.obs;

  var divisionList = ['Dhaka', 'Chittagong', 'Khulna', 'Barishal'].obs;
  var selectedDivision = ''.obs;

  var districtList = ['Dhaka', 'Comilla', 'Khulna', 'Barishal'].obs;
  var selectedDistrict = ''.obs;

  var selectedGender = 'Male'.obs;

  void signUp() {
    Get.snackbar('Sign Up', 'Signing up...');
  }
}
