import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'inside_room_controller.dart';

class InsideRoomView extends StatelessWidget {
  final controller = Get.put(InsideRoomController());
  final TextEditingController messageController = TextEditingController();

  InsideRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text("Room Name", style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: controller.leaveRoom,
            child: Text(
              "Leave",
              style: TextStyle(
                color: Colors.red.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // TOP: 35% video + controls
          Expanded(
            flex: 40,
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  // Avatars
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                      children: List.generate(
                        8,
                            (index) => CircleAvatar(
                          radius: 28.r,
                          backgroundColor: Colors.indigo.shade50,
                          child: Text(
                            "U$index",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // Controls
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          controller.isVideoOn.value
                              ? Icons.videocam
                              : Icons.videocam_off,
                          color: Colors.teal,
                        ),
                        tooltip: "Toggle Video",
                        onPressed: controller.toggleVideo,
                      ),
                      IconButton(
                        icon: Icon(
                          controller.isAudioOn.value
                              ? Icons.mic
                              : Icons.mic_off,
                          color: Colors.teal,
                        ),
                        tooltip: "Toggle Audio",
                        onPressed: controller.toggleAudio,
                      ),
                      if (controller.isAdmin.value)
                        IconButton(
                          icon: Icon(Icons.block, color: Colors.red),
                          tooltip: "Ban user",
                          onPressed: controller.banUser,
                        ),
                      if (controller.isAdmin.value)
                        IconButton(
                          icon: Icon(Icons.link, color: Colors.indigo),
                          tooltip: "Copy room link",
                          onPressed: controller.shareRoomLink,
                        ),
                    ],
                  )),
                ],
              ),
            ),
          ),

          Divider(height: 1, color: Colors.grey.shade300),

          // BOTTOM: 65% chat section
          Expanded(
            flex: 60,
            child: Column(
              children: [
                // Chat messages
                Expanded(
                  child: Obx(() => ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
                              ? Colors.grey.shade200
                              : Colors.lightBlue.shade100,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          controller.messages[i],
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ),
                    ),
                  )),
                ),

                // Input area
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.attach_file, color: Colors.grey.shade700),
                        onPressed: () {}, // Optional file/image picker
                      ),
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue),
                        onPressed: () {
                          controller.sendMessage(messageController.text);
                          messageController.clear();
                        },
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
