import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import 'message_controller.dart';
import 'single_message_view.dart';

class MessageListView extends GetView<MessageController> {
  MessageListView({super.key});

  //final MessageController controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Messages', style: TextStyle(color: AppColors.black)),
        backgroundColor: AppColors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: AppColors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildSearchBox(),
            SizedBox(height: 16.h),
            Expanded(child: Obx(_buildChatList)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return TextField(
      onChanged: (value) => controller.searchQuery.value = value,
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: AppColors.grey100,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildChatList() {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    final chats = controller.filteredChats;

    if (chats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message_outlined, size: 64.sp, color: AppColors.grey400),
            SizedBox(height: 16.h),
            Text(
              "No conversations yet.",
              style: TextStyle(fontSize: 16.sp, color: AppColors.grey600),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: chats.length,
      separatorBuilder: (_, __) => Divider(color: AppColors.grey200),
      itemBuilder: (_, i) {
        final chat = chats[i];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(chat.photo),
            radius: 24.r,
          ),
          title: Text(
            chat.name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
          subtitle: Text(
            chat.lastMessage,
            style: TextStyle(color: AppColors.grey700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                chat.time,
                style: TextStyle(fontSize: 12.sp, color: AppColors.grey500),
              ),
              if (chat.unreadCount > 0)
                Container(
                  margin: EdgeInsets.only(top: 4.h),
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    chat.unreadCount.toString(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          onTap: () => Get.to(
            () => SingleMessageView(
              name: chat.name,
              photo: chat.photo,
              uid: chat.recipientUid,
            ),
          ),
        );
      },
    );
  }
}
