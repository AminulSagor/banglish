import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class AddGroupModal extends StatelessWidget {
  final VoidCallback? onCreateGroup;

  const AddGroupModal({super.key, this.onCreateGroup});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final topicController = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Create New Group',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blueGrey900,
            ),
          ),
          SizedBox(height: 16.h),

          CustomTextField(
            controller: nameController,
            labelText: 'Group Name',
            hintText: 'Enter group name',
          ),
          SizedBox(height: 12.h),

          CustomTextField(
            controller: topicController,
            labelText: 'Topic',
            hintText: 'Enter discussion topic',
          ),
          SizedBox(height: 20.h),

          CustomButton(
            text: 'Open Group',
            onPressed: () {
              if (onCreateGroup != null) {
                onCreateGroup!();
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
