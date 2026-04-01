import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../shared/widgets/active_person_card.dart';
import '../shared/widgets/filter_box_widget.dart';
import 'active_controller.dart';

class ActiveView extends GetView<ActiveController> {
  const ActiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Active'),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.blueGrey800,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: AppColors.blueGrey700),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Search Field
            TextField(
              onChanged: (value) {
                controller.searchQuery.value = value.trim();
              },
              decoration: InputDecoration(
                hintText: 'Search people...',
                hintStyle: TextStyle(color: AppColors.blueGrey400),
                prefixIcon: Icon(Icons.search, color: AppColors.blueGrey600),
                filled: true,
                fillColor: AppColors.grey100,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: AppColors.blueGrey800, fontSize: 14.sp),
            ),
            SizedBox(height: 12.h),

            // Filter Box
            const FilterBoxWidget(),
            SizedBox(height: 12.h),

            // People List
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      controller.isMoreDataAvailable.value) {
                    controller.loadMore();
                  }
                  return false;
                },
                child: Obx(() {
                  if (controller.isLoading.value && controller.people.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!controller.isLoading.value &&
                      controller.people.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64.sp,
                            color: AppColors.grey400,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Search or filter to find people",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.blueGrey600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.people.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.people.length) {
                        final user = controller.people[index];
                        return ActivePersonCard(user: user);
                      } else {
                        return controller.isMoreDataAvailable.value
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox();
                      }
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
