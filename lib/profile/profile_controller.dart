import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  var isEditable = false.obs;
  var isSelf = true.obs;
  RxString photoUrl = ''.obs;


  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final countryController = TextEditingController();
  final divisionController = TextEditingController();
  final districtController = TextEditingController();

  String? userDocId;

  var countryList = <String>[
    'Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Argentina',
    'Australia', 'Austria', 'Bangladesh', 'Belgium', 'Bhutan', 'Brazil',
    'Canada', 'China', 'Denmark', 'Egypt', 'Finland', 'France', 'Germany',
    'Greece', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Italy',
    'Japan', 'Malaysia', 'Maldives', 'Nepal', 'Netherlands', 'New Zealand',
    'Norway', 'Pakistan', 'Portugal', 'Qatar', 'Russia', 'Saudi Arabia',
    'Singapore', 'South Africa', 'South Korea', 'Spain', 'Sri Lanka',
    'Sweden', 'Switzerland', 'Thailand', 'Turkey', 'United Arab Emirates',
    'United Kingdom', 'United States of America', 'Vietnam', 'Zimbabwe',
  ].obs;


  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final uid = prefs.getString("uid");

      if (uid == null) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (!doc.exists) {
        Get.snackbar("Error", "User not found");
        return;
      }

      final data = doc.data()!;
      print("✅ Fetched user data: $data"); // Debug print

      userDocId = doc.id;

      nameController.text = data['name'] ?? '';
      emailController.text = data['email'] ?? '';
      genderController.text = data['gender'] ?? '';
      countryController.text = data['country'] ?? '';
      divisionController.text = data['division'] ?? '';
      districtController.text = data['district'] ?? '';
      photoUrl.value = data['photoUrl'] ?? '';
    } catch (e) {
      print("❌ Error fetching user profile: $e");
      Get.snackbar("Error", e.toString());
    }
  }


  Future<void> saveProfile() async {
    try {
      if (userDocId == null) return;

      await FirebaseFirestore.instance.collection('users').doc(userDocId).update({
        'name': nameController.text,
        'gender': genderController.text,
        'country': countryController.text,
        'division': divisionController.text,
        'district': districtController.text,
      });

      isEditable.value = false;
      Get.snackbar("Success", "Profile updated");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void toggleEdit() => isEditable.value = !isEditable.value;

  void deleteProfile() {
    Get.snackbar("Deleted", "Your profile has been deleted");
    // Add actual delete logic here
  }

  void changePassword() {
    // Implement change password functionality
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
    Get.offAllNamed('/login');
  }

  void callUser() {}
  void messageUser() {}
}
