import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/user_model.dart';
import '../../../core/services/mock_data_service.dart';

class ProfileController extends GetxController {
  final currentUser = Rxn<UserModel>();
  final isLoading = false.obs;
  final isEditing = false.obs;
  final isSaving = false.obs;

  // Text controllers for profile fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final divisionController = TextEditingController();
  final districtController = TextEditingController();

  // Gender selection
  final selectedGender = ''.obs;
  final genderOptions = ['Male', 'Female', 'Other'];

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    countryController.dispose();
    divisionController.dispose();
    districtController.dispose();
    super.onClose();
  }

  void loadUserProfile() {
    isLoading.value = true;

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 300), () {
      // Use first mock user as current user
      final users = MockDataService.mockUsers;
      if (users.isNotEmpty) {
        currentUser.value = users.first;
        _populateControllers();
      }
      isLoading.value = false;
    });
  }

  void _populateControllers() {
    final user = currentUser.value;
    if (user != null) {
      nameController.text = user.name;
      emailController.text = user.email;
      countryController.text = user.country;
      divisionController.text = user.division;
      districtController.text = user.district;
      selectedGender.value = user.gender;
    }
  }

  void toggleEditing() {
    if (isEditing.value) {
      // If currently editing, restore original values
      _populateControllers();
    }
    isEditing.toggle();
  }

  void saveProfile() {
    if (currentUser.value == null) return;

    final name = nameController.text.trim();
    if (name.isEmpty) {
      Get.snackbar(
        'Error',
        'Name cannot be empty',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    isSaving.value = true;

    // Simulate API call
    Future.delayed(const Duration(milliseconds: 500), () {
      currentUser.value = UserModel(
        uid: currentUser.value!.uid,
        name: name,
        email: emailController.text.trim(),
        country: countryController.text.trim(),
        division: divisionController.text.trim(),
        district: districtController.text.trim(),
        gender: selectedGender.value,
        photoUrl: currentUser.value!.photoUrl,
      );

      isEditing.value = false;
      isSaving.value = false;
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
      isEditing.value = false;
    });
  }

  void updateProfile({
    String? name,
    String? email,
    String? country,
    String? division,
    String? district,
  }) {
    if (currentUser.value != null) {
      currentUser.value = UserModel(
        uid: currentUser.value!.uid,
        name: name ?? currentUser.value!.name,
        email: email ?? currentUser.value!.email,
        country: country ?? currentUser.value!.country,
        division: division ?? currentUser.value!.division,
        district: district ?? currentUser.value!.district,
        gender: currentUser.value!.gender,
        photoUrl: currentUser.value!.photoUrl,
      );

      isEditing.value = false;
      Get.snackbar('Success', 'Profile updated successfully');
    }
  }

  void pickProfileImage() {
    // TODO: Implement image picker
    Get.snackbar(
      'Coming Soon',
      'Image picker will be available soon',
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
    );
  }

  void logout() {
    Get.offAllNamed('/login');
    Get.snackbar('Logged Out', 'You have been logged out');
  }

  void changePassword() {
    Get.toNamed('/change-password');
  }
}
