import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../home/home_controller.dart';
import '../shared/widgets/room_card_widget.dart';

class MyRoomsView extends GetView<HomeController> {
  const MyRoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'My Rooms',
          style: TextStyle(color: AppColors.primary, fontSize: 15),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0.5,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final myRooms = controller.myRooms;
        if (myRooms.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.video_call_outlined,
                    size: 64.sp,
                    color: AppColors.grey400,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'You have not created any rooms yet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp, color: AppColors.grey600),
                  ),
                ],
              ),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.all(16.w),
          child: ListView.builder(
            itemCount: myRooms.length,
            itemBuilder: (context, index) {
              final room = myRooms[index];
              return RoomCardWidget(
                room: room,
                onJoin: () => controller.joinRoom(room.id),
              );
            },
          ),
        );
      }),
    );
  }
}
