import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import 'inside_room_controller.dart';

class InsideRoomView extends GetView<InsideRoomController> {
  final String roomId;
  final TextEditingController messageController = TextEditingController();

  InsideRoomView({super.key, required this.roomId}) {
    Get.put(InsideRoomController(roomId: roomId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        title: const Text("Room", style: TextStyle(color: AppColors.black)),
        iconTheme: const IconThemeData(color: AppColors.black),
        actions: [
          TextButton(
            onPressed: controller.leaveRoom,
            child: Text(
              "Leave",
              style: TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // TOP: 40% video + controls
          Expanded(
            flex: 40,
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  // Participant Avatars
                  Expanded(
                    child: Obx(
                      () => GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8.w,
                        mainAxisSpacing: 8.h,
                        children: controller.participants.map((participant) {
                          return CircleAvatar(
                            radius: 28.r,
                            backgroundColor: AppColors.primaryLight.withOpacity(
                              0.3,
                            ),
                            child: Text(
                              participant,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // Controls
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            controller.isVideoOn.value
                                ? Icons.videocam
                                : Icons.videocam_off,
                            color: controller.isVideoOn.value
                                ? AppColors.secondary
                                : AppColors.error,
                          ),
                          tooltip: "Toggle Video",
                          onPressed: controller.toggleVideo,
                        ),
                        IconButton(
                          icon: Icon(
                            controller.isAudioOn.value
                                ? Icons.mic
                                : Icons.mic_off,
                            color: controller.isAudioOn.value
                                ? AppColors.secondary
                                : AppColors.error,
                          ),
                          tooltip: "Toggle Audio",
                          onPressed: controller.toggleAudio,
                        ),
                        if (controller.isAdmin.value)
                          IconButton(
                            icon: Icon(Icons.block, color: AppColors.error),
                            tooltip: "Ban user",
                            onPressed: controller.banUser,
                          ),
                        IconButton(
                          icon: Icon(Icons.link, color: AppColors.primary),
                          tooltip: "Copy room link",
                          onPressed: controller.shareRoomLink,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Divider(height: 1, color: AppColors.grey300),

          // BOTTOM: 60% chat section
          Expanded(
            flex: 60,
            child: Column(
              children: [
                // Chat messages
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      itemCount: controller.messages.length,
                      itemBuilder: (_, i) => Align(
                        alignment: i.isEven
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: i.isEven
                                ? AppColors.grey200
                                : AppColors.primaryLight.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            controller.messages[i],
                            style: TextStyle(color: AppColors.blueGrey800),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Input area
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey300,
                        blurRadius: 4,
                        offset: const Offset(0, -1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.attach_file, color: AppColors.grey700),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            filled: true,
                            fillColor: AppColors.grey100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.r),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: AppColors.white,
                            size: 18.sp,
                          ),
                          onPressed: () {
                            controller.sendMessage(messageController.text);
                            messageController.clear();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
