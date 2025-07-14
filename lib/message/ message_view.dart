import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spoken/message/single_message_view.dart';
import 'message_controller.dart';

class MessageView extends StatelessWidget {
  final MessageController controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
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
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildChatList() {
    if (controller.chats.isEmpty) {
      return const Center(child: Text("No conversations yet."));
    }

    return ListView.separated(
      itemCount: controller.chats.length,
      separatorBuilder: (_, __) => Divider(color: Colors.grey.shade200),
      itemBuilder: (_, i) {
        final chat = controller.chats[i];
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
            style: TextStyle(color: Colors.grey.shade700),
          ),
          trailing: Text(
            chat.time,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          onTap: () => Get.to(() => SingleMessageView(
            name: chat.name,
            photo: chat.photo,
          )),
        );
      },
    );
  }
}
