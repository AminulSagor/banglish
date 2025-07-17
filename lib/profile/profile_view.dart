import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileView extends StatelessWidget {
  final controller = Get.put(ProfileController());

  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.5,
        actions: [
          Obx(() => controller.isSelf.value
              ? PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') controller.logout();
              if (value == 'delete') controller.deleteProfile();
              if (value == 'change_password') controller.changePassword();
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => const [

              PopupMenuItem(value: 'delete', child: Text("Delete Profile")),
              PopupMenuItem(value: 'change_password', child: Text("Change Password")),
              PopupMenuItem(value: 'logout', child: Text("Logout")),
            ],
          )
              : const SizedBox()),
        ],

      ),
      body: Obx(
            () => SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    controller.name.value.isNotEmpty
                        ? controller.name.value[0].toUpperCase()
                        : '',
                    style: TextStyle(fontSize: 32.sp, color: Colors.blueGrey),
                  ),
                ),
                SizedBox(height: 20.h),

                // Profile Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.r,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildTextField(
                        label: "Name",
                        value: controller.name.value,
                        isEditable: controller.isEditable.value,
                        onChanged: (v) => controller.name.value = v,
                      ),
                      if (controller.isSelf.value)
                        _buildTextField(
                          label: "Email",
                          value: controller.email.value,
                          isEditable: false,
                        ),
                      _buildTextField(
                        label: "Gender",
                        value: controller.gender.value,
                        isEditable: controller.isEditable.value,
                        onChanged: (v) => controller.gender.value = v,
                      ),
                      _buildTextField(
                        label: "Country",
                        value: controller.country.value,
                        isEditable: controller.isEditable.value,
                        onChanged: (v) => controller.country.value = v,
                      ),
                      if (controller.country.value.toLowerCase() == 'bangladesh') ...[
                        _buildTextField(
                          label: "Division",
                          value: controller.division.value,
                          isEditable: controller.isEditable.value,
                          onChanged: (v) => controller.division.value = v,
                        ),
                        _buildTextField(
                          label: "District",
                          value: controller.district.value,
                          isEditable: controller.isEditable.value,
                          onChanged: (v) => controller.district.value = v,
                        ),
                      ],
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                if (controller.isSelf.value && !controller.isEditable.value)
                  _buildButton("Update", controller.toggleEdit),

                if (controller.isSelf.value && controller.isEditable.value)
                  _buildButton("Save", controller.saveProfile),

                if (!controller.isSelf.value)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconButton("Message", Icons.message, controller.messageUser),
                      _buildIconButton("Call", Icons.call, controller.callUser),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required bool isEditable,
    Function(String)? onChanged,
  }) {
    final controller = TextEditingController(text: value);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextField(
        enabled: isEditable,
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: Colors.black), // Keeps text same for disabled
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black87),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12.r),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 16.sp)),
      ),
    );
  }

  Widget _buildIconButton(String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
      icon: Icon(icon),
      label: Text(text),
      onPressed: onPressed,
    );
  }
}
