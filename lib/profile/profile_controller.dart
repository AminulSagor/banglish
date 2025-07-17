import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isEditable = false.obs;
  var isSelf = true.obs; // toggle this for testing
  var name = "Aminul Islam".obs;
  var email = "aminul@example.com".obs;
  var gender = "Male".obs;
  var country = "Bangladesh".obs;
  var division = "Dhaka".obs;
  var district = "Gazipur".obs;

  void toggleEdit() => isEditable.value = !isEditable.value;
  void saveProfile() {
    isEditable.value = false;
    // TODO: Save logic here
  }

  void deleteProfile() {
    // TODO: Delete logic
    Get.snackbar("Deleted", "Your profile has been deleted");
  }

  void changePassword() {
    // TODO: Navigate to change password screen
  }

  void callUser() {
    // TODO: Launch phone dialer
  }

  void messageUser() {
    // TODO: Navigate to chat screen
  }

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/login'); // 👈 Adjust route if needed
    } catch (e) {
      Get.snackbar('Logout Failed', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

}
