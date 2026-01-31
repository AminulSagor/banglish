import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import 'single_message_controller.dart';

class SingleMessageView extends GetView<SingleMessageController> {
  final String name;
  final String photo;
  final String uid;

  SingleMessageView({
    super.key,
    required this.name,
    required this.photo,
    required this.uid,
  }) {
    Get.put(SingleMessageController(receiverId: uid));
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (controller.scrollController.hasClients) {
        controller.scrollController.animateTo(
          controller.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          }, //() => Get.back(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundImage: photo.isNotEmpty ? NetworkImage(photo) : null,
              backgroundColor: AppColors.grey300,
              child: photo.isEmpty
                  ? Text(
                      name[0],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: AppColors.blueGrey800,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12.w),
            Text(name, style: const TextStyle(color: AppColors.black)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
        ],
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.black),
        elevation: 0.5,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Expanded(
                child: controller.messages.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 64.sp,
                              color: AppColors.grey400,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "No messages yet.\nStart a conversation!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.grey600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: controller.scrollController,
                        padding: EdgeInsets.all(12.w),
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) {
                          final message = controller.messages[index];
                          final isMe =
                              message.senderId == controller.currentUserId;
                          return _buildMessageCard(message.text, isMe);
                        },
                      ),
              ),
              _buildInputArea(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMessageCard(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.all(12.w),
        constraints: BoxConstraints(maxWidth: 0.75.sw),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : AppColors.grey200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
            bottomLeft: isMe ? Radius.circular(12.r) : Radius.zero,
            bottomRight: isMe ? Radius.zero : Radius.circular(12.r),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isMe ? AppColors.white : AppColors.blueGrey800,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return SafeArea(
      child: Container(
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
              icon: const Icon(Icons.attach_file),
              onPressed: () {},
              color: AppColors.grey600,
            ),
            Expanded(
              child: TextField(
                controller: controller.textEditingController,
                onTap: scrollToBottom,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
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
                icon: const Icon(Icons.send, color: AppColors.white),
                onPressed: () {
                  controller.sendMessage();
                  scrollToBottom();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
