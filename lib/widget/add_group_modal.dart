import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddGroupModal extends StatelessWidget {
  const AddGroupModal({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final topicController = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Create New Group', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 16.h),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Group Name',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
            ),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: topicController,
            decoration: InputDecoration(
              labelText: 'Topic',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Handle open group logic
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text('Open Group', style: TextStyle(fontSize: 16.sp)),
            ),
          )
        ],
      ),
    );
  }
}
