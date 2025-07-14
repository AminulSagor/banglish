import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/active_person_card.dart';
import '../widget/filter_box_widget.dart';

class ActivePeopleView extends StatelessWidget {
  final List<Map<String, String>> people = [
    {
      'name': 'Aminul Islam',
      'country': 'Bangladesh',
      'division': 'Dhaka',
      'district': 'Gazipur',
      'gender': 'Male',
      'image': '',
    },
    {
      'name': 'Emily Watson',
      'country': 'USA',
      'gender': 'Female',
      'image': '',
    },
  ];

  ActivePeopleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Active People'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.blueGrey.shade800,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: Colors.blueGrey.shade700),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Search box
            TextField(
              decoration: InputDecoration(
                hintText: 'Search people...',
                hintStyle: TextStyle(color: Colors.blueGrey.shade400),
                prefixIcon: Icon(Icons.search, color: Colors.blueGrey.shade600),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.blueGrey.shade800, fontSize: 14.sp),
            ),

            SizedBox(height: 12.h),

            // Filter box
            const FilterBoxWidget(),

            SizedBox(height: 12.h),

            // People list
            Expanded(
              child: ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  return ActivePersonCard(data: people[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
