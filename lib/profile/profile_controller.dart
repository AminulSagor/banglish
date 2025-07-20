import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileController extends GetxController {
  var isEditable = false.obs;
  var isSelf = true.obs;

  var name = ''.obs;
  var email = ''.obs;
  var gender = ''.obs;
  var country = ''.obs;
  var division = ''.obs;
  var district = ''.obs;

  String? userDocId;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final uid = prefs.getString("uid"); // You should save this after login
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
      userDocId = doc.id;

      name.value = data['name'] ?? '';
      email.value = data['email'] ?? '';
      gender.value = data['gender'] ?? '';
      country.value = data['country'] ?? '';
      division.value = data['division'] ?? '';
      district.value = data['district'] ?? '';
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> saveProfile() async {
    try {
      if (userDocId == null) return;

      await FirebaseFirestore.instance.collection('users').doc(userDocId).update({
        'name': name.value,
        'gender': gender.value,
        'country': country.value,
        'division': division.value,
        'district': district.value,
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
    // optional: implement real deletion logic
  }

  void changePassword() {
    // Implement password change navigation or modal
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
    Get.offAllNamed('/login'); // Make sure this route exists in your AppRoutes
  }


  void callUser() {}
  void messageUser() {}
}
