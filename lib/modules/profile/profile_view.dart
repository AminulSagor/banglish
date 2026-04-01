import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import 'edit_profile_view.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fixed Header Background
          Positioned(top: 0, left: 0, right: 0, child: _buildHeader()),

          // Scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                // Spacer for header
                SizedBox(height: 196.h),
                // Content container with rounded top corners
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 196.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Column(
                      children: [
                        _buildMenuItem(
                          icon: Icons.person_outline,
                          title: "Profile",
                          onTap: () => Get.to(() => const EditProfileView()),
                        ),
                        _buildMenuItem(
                          icon: Icons.block,
                          title: "Blocked Users",
                          onTap: () =>
                              Get.snackbar('Coming Soon', 'Blocked Users'),
                        ),
                        _buildMenuItem(
                          icon: Icons.lock_outline,
                          title: "Change Password",
                          onTap: controller.goToChangePassword,
                        ),
                        _buildMenuItem(
                          icon: Icons.delete_outline,
                          title: "Delete Account",
                          iconColor: AppColors.error,
                          onTap: () => controller.deleteAccount(context),
                        ),
                        _buildMenuItem(
                          icon: Icons.privacy_tip_outlined,
                          title: "Privacy Policy",
                          onTap: () => controller.goToPrivacyPolicy(),
                        ),
                        _buildMenuItem(
                          icon: Icons.description_outlined,
                          title: "Terms & Conditions",
                          onTap: () => controller.goToTermsAndConditions(),
                        ),
                        _buildMenuItem(
                          icon: Icons.headset_mic_outlined,
                          title: "Support",
                          onTap: () => Get.snackbar('Coming Soon', 'Support'),
                        ),
                        _buildMenuItem(
                          icon: Icons.info_outline,
                          title: "About",
                          onTap: () => controller.goToAbout(),
                        ),
                        _buildMenuItem(
                          icon: Icons.logout,
                          title: "Logout",
                          showArrow: false,
                          onTap: controller.logout,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 220.h,
      padding: EdgeInsets.only(
        top: 60.h,
        bottom: 44.h,
        left: 20.w,
        right: 20.w,
      ),
      color: AppColors.primary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Account",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 20.h),
          Obx(() {
            final user = controller.editProfileController.currentUser.value;
            return Row(
              children: [
                CircleAvatar(
                  radius: 32.r,
                  backgroundColor: AppColors.white.withAlpha(85),
                  backgroundImage: user?.photoUrl.isNotEmpty == true
                      ? NetworkImage(user!.photoUrl)
                      : null,
                  child: user?.photoUrl.isEmpty == true || user == null
                      ? Text(
                          user?.name[0].toUpperCase() ?? "U",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? "Loading...",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        user?.email ?? "",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    bool showArrow = true,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      leading: Icon(icon, color: iconColor ?? AppColors.grey700, size: 24.sp),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.blueGrey800,
        ),
      ),
      trailing: showArrow
          ? Icon(Icons.chevron_right, color: AppColors.grey500, size: 24.sp)
          : null,
      onTap: onTap,
    );
  }
}
