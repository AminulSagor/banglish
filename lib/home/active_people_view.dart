import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widget/active_person_card.dart';
import '../widget/filter_box_widget.dart';
import 'active_people_controller.dart';

class ActivePeopleView extends StatelessWidget {
  final ActivePeopleController controller = Get.put(ActivePeopleController());

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
            const FilterBoxWidget(),
            SizedBox(height: 12.h),

            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                      controller.isMoreDataAvailable.value) {
                    controller.loadMore();
                  }
                  return true;
                },
                child: Obx(() {
                  if (controller.isLoading.value && controller.people.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: controller.people.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.people.length) {
                        final user = controller.people[index];
                        return ActivePersonCard(data: {
                          'name': user.name,
                          'country': user.country,
                          'division': user.division,
                          'district': user.district,
                          'gender': user.gender,
                          'image': user.image,
                        });
                      } else {
                        return controller.isMoreDataAvailable.value
                            ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(child: CircularProgressIndicator()),
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
