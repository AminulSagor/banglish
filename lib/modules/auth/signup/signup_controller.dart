import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api_error_handler.dart';
import '../../../core/services/mock_data_service.dart';
import '../../../routes/app_routes.dart';
import '../models/auth_models.dart';
import '../services/auth_module_service.dart';

class SignupController extends GetxController {
  final AuthModuleService _authService = Get.find<AuthModuleService>();
  final ApiErrorHandler _apiErrorHandler = Get.find<ApiErrorHandler>();
  final createdUser = Rxn<AuthUserUiModel>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var selectedCountry = ''.obs;
  var selectedDivision = ''.obs;
  var selectedDistrict = ''.obs;
  var selectedGender = 'Male'.obs;

  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;

  List<String> get countryList => MockDataService.countries;
  List<String> get divisionList => MockDataService.bangladeshDivisions;
  List<String> get districtList {
    if (selectedDivision.value.isEmpty) return [];
    return MockDataService.bangladeshDistricts[selectedDivision.value] ?? [];
  }

  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.toggle();
  }

  void signup() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all required fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    if (selectedCountry.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a country',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    isLoading.value = true;

    final payload = SignupPayloadModel(
      name: name,
      email: email,
      password: password,
      country: selectedCountry.value,
      division: selectedDivision.value,
      district: selectedDistrict.value,
      gender: selectedGender.value,
    );

    final ApiResponse<AuthUserUiModel?> signupResponse = await _apiErrorHandler
        .handle(
          () => _authService.signup(payload),
          defaultErrorCode: 'SIGNUP_FAILED',
        );

    if (signupResponse.success && signupResponse.data != null) {
      createdUser.value = signupResponse.data;
      Get.snackbar(
        'Success',
        'Account created! Please verify your email.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );

      Get.toNamed(
        AppRoutes.otp,
        arguments: {'email': email, 'otp': '12345', 'isForgetPass': false},
      );
    }

    isLoading.value = false;
  }

  void goToLogin() {
    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
