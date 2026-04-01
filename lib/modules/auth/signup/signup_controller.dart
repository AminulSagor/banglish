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
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final thanaController = TextEditingController();
  final districtController = TextEditingController();
  final passwordController = TextEditingController();

  var selectedCountry = ''.obs;
  var signupMethod = 'phone'.obs;
  var selectedGender = 'Male'.obs;

  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;
  final obscurePassword = true.obs;

  List<String> get countryList => MockDataService.countries;

  bool get isPhoneSignup => signupMethod.value == 'phone';

  @override
  void onInit() {
    super.onInit();
    selectedCountry.value = 'Bangladesh';
  }

  void setSignupMethod(String method) {
    signupMethod.value = method;
  }

  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }

  bool _isValidPhone(String value) {
    final normalized = value.replaceAll(RegExp(r'\s+'), '');
    return RegExp(r'^\+?[0-9]{7,15}$').hasMatch(normalized);
  }

  void signup() async {
    final name = nameController.text.trim();
    final username = usernameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final thana = thanaController.text.trim();
    final district = districtController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || username.isEmpty || password.isEmpty) {
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

    if (isPhoneSignup && !_isValidPhone(phone)) {
      Get.snackbar(
        'Error',
        'Please enter a valid phone number',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    if (!isPhoneSignup && !GetUtils.isEmail(email)) {
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

    if (password.length < 8) {
      Get.snackbar(
        'Error',
        'Password must be at least 8 characters',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    if (selectedCountry.value.isEmpty || thana.isEmpty || district.isEmpty) {
      Get.snackbar(
        'Error',
        'Please complete country, thana and district',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    isLoading.value = true;

    final payload = SignupPayloadModel(
      signupMethod: signupMethod.value,
      name: name,
      username: username,
      email: isPhoneSignup ? '' : email,
      phone: isPhoneSignup ? phone : '',
      password: password,
      country: selectedCountry.value,
      thana: thana,
      division: thana,
      district: district,
      gender: selectedGender.value,
    );

    final ApiResponse<AuthUserUiModel?> signupResponse = await _apiErrorHandler
        .call(
          () => _authService.signup(payload),
          defaultErrorCode: 'SIGNUP_FAILED',
        );

    if (signupResponse.success && signupResponse.data != null) {
      createdUser.value = signupResponse.data;
      Get.snackbar(
        'Success',
        'Account created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );

      Get.toNamed(
        AppRoutes.otp,
        arguments: {
          'email': isPhoneSignup ? phone : email,
          'otp': '12345',
          'isForgetPass': false,
        },
      );
    }

    isLoading.value = false;
  }

  void signupWithGoogle() async {
    isGoogleLoading.value = true;
    final response = await _apiErrorHandler.call<AuthUserUiModel?>(
      () => _authService.signInWithGoogle(),
      defaultErrorCode: 'GOOGLE_SIGNUP_FAILED',
    );

    if (response.success && response.data != null) {
      createdUser.value = response.data;
      Get.snackbar(
        'Success',
        'Google signup successful!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      Get.offAllNamed(AppRoutes.mainNavigation);
    }

    isGoogleLoading.value = false;
  }

  void signupWithFacebook() async {
    isFacebookLoading.value = true;
    final response = await _apiErrorHandler.call<AuthUserUiModel?>(
      () => _authService.signInWithFacebook(),
      defaultErrorCode: 'FACEBOOK_SIGNUP_FAILED',
    );

    if (response.success && response.data != null) {
      createdUser.value = response.data;
      Get.snackbar(
        'Success',
        'Facebook signup successful!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      Get.offAllNamed(AppRoutes.mainNavigation);
    }

    isFacebookLoading.value = false;
  }

  void goToLogin() {
    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    thanaController.dispose();
    districtController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
