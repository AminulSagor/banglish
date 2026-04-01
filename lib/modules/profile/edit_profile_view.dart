import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';
import 'edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => !controller.isEditing.value
                ? TextButton(
                    onPressed: controller.toggleEditing,
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              // Profile Image Section
              _buildProfileImageSection(),
              SizedBox(height: 24.h),

              // Profile Form
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withAlpha(60),
                      blurRadius: 8.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Name Field
                    _buildTextField(
                      controller: controller.nameController,
                      label: 'Name',
                      hint: 'Enter your name',
                      icon: Icons.person_outline,
                      enabled: controller.isEditing.value,
                    ),
                    SizedBox(height: 16.h),

                    // Email Field
                    _buildTextField(
                      controller: controller.emailController,
                      label: 'Email',
                      hint: 'Enter your email',
                      icon: Icons.email_outlined,
                      enabled: false, // Email is usually not editable
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.h),

                    // Country Field
                    _buildTextField(
                      controller: controller.countryController,
                      label: 'Country',
                      hint: 'Enter your country',
                      icon: Icons.public,
                      enabled: controller.isEditing.value,
                    ),
                    SizedBox(height: 16.h),

                    // Division Field
                    _buildTextField(
                      controller: controller.divisionController,
                      label: 'Division',
                      hint: 'Enter your division',
                      icon: Icons.location_city,
                      enabled: controller.isEditing.value,
                    ),
                    SizedBox(height: 16.h),

                    // District Field
                    _buildTextField(
                      controller: controller.districtController,
                      label: 'District',
                      hint: 'Enter your district',
                      icon: Icons.location_on_outlined,
                      enabled: controller.isEditing.value,
                    ),
                    SizedBox(height: 16.h),

                    // Gender Selection
                    _buildGenderSelector(),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Save Button (visible when editing)
              Obx(
                () => controller.isEditing.value
                    ? CustomButton(
                        text: 'Save Changes',
                        onPressed: controller.saveProfile,
                        isLoading: controller.isSaving.value,
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileImageSection() {
    return Obx(() {
      final user = controller.currentUser.value;
      return Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundColor: AppColors.grey300,
                backgroundImage: user?.photoUrl.isNotEmpty == true
                    ? NetworkImage(user!.photoUrl)
                    : null,
                child: user?.photoUrl.isEmpty == true || user == null
                    ? Icon(Icons.person, size: 50.sp, color: AppColors.grey500)
                    : null,
              ),
              if (controller.isEditing.value)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: controller.pickProfileImage,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 16.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            user?.name ?? 'User',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blueGrey800,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            user?.email ?? '',
            style: TextStyle(fontSize: 14.sp, color: AppColors.grey600),
          ),
        ],
      );
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool enabled = true,
    TextInputType? keyboardType,
  }) {
    return CustomTextField(
      controller: controller,
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.grey600),
      enabled: enabled,
      keyboardType: keyboardType,
    );
  }

  Widget _buildGenderSelector() {
    return Obx(() {
      final isEditing = controller.isEditing.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.blueGrey700,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: controller.genderOptions.map((gender) {
              final isSelected = controller.selectedGender.value == gender;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: GestureDetector(
                    onTap: isEditing
                        ? () => controller.selectedGender.value = gender
                        : null,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.grey200,
                        borderRadius: BorderRadius.circular(12.r),
                        border: isSelected
                            ? Border.all(color: AppColors.primary, width: 1.5)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          gender,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.blueGrey600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
