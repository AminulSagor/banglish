import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'edit_profile_controller.dart';
import '../../../routes/app_routes.dart';

/// Controller for the Account View
/// This controller manages the account settings page
class ProfileController extends GetxController {
  // Get the profile controller instance
  EditProfileController get editProfileController =>
      Get.find<EditProfileController>();

  // Loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Any initialization logic for account view
  }

  /// Navigate to profile page
  void goToProfile() {
    Get.toNamed(AppRoutes.profile);
  }

  /// Navigate to blocked users page
  void goToBlockedUsers() {
    Get.snackbar('Coming Soon', 'Blocked Users feature is under development');
  }

  /// Navigate to change password page
  void goToChangePassword() {
    Get.toNamed(AppRoutes.changePassword);
  }

  /// Show delete account dialog

  void deleteAccount(BuildContext context) {
    final passwordController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning_rounded,
                  color: Colors.red.shade600,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              const Text(
                'Delete your account?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Description
              const Text(
                'You will lose all your data by deleting your account. This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Password confirmation text
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'To confirm, please type your password below.',
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 8),

              // Password TextField
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter password to confirm',
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.deepPurple),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // No, Keep Account Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    passwordController.dispose();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'No, Keep Account',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Delete Account Button
              TextButton(
                onPressed: () {
                  if (passwordController.text.isEmpty) {
                    //Get.snackbar() not working.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter your password to confirm'),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(10),
                      ),
                    );
                    return;
                  }
                  passwordController.dispose();
                  Navigator.pop(context); //Get.back() not working.
                  Navigator.pushNamedAndRemoveUntil(
                    //Get.offAllNamed() not working.
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                },
                child: Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Navigate to privacy policy
  void goToPrivacyPolicy() {
    //Get.snackbar('Coming Soon', 'Privacy Policy will be available soon');
    Get.toNamed(AppRoutes.privacyPolicy);
  }

  /// Navigate to terms and conditions
  void goToTermsAndConditions() {
    //Get.snackbar('Coming Soon', 'Terms & Conditions will be available soon');
    Get.toNamed(AppRoutes.termsAndConditions);
  }

  /// Navigate to support
  void goToSupport() {
    Get.snackbar('Coming Soon', 'Support feature is under development');
    //Get.toNamed(AppRoutes.support);
  }

  /// Navigate to about page
  void goToAbout() {
    //Get.snackbar('Coming Soon', 'About page is under development');
    Get.toNamed(AppRoutes.aboutApp);
  }

  /// Logout user
  void logout() {
    editProfileController.logout();
  }
}
