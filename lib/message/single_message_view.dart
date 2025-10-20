import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spoken/message/single_message_controller.dart';

class SingleMessageView extends StatefulWidget {
  final String name;
  final String photo;
  final String uid;

  const SingleMessageView({
    super.key,
    required this.name,
    required this.photo,
    required this.uid,
  });

  @override
  State<SingleMessageView> createState() => _SingleMessageViewState();
}

class _SingleMessageViewState extends State<SingleMessageView> {
  late final SingleMessageController controller;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(SingleMessageController(receiverId: widget.uid));

    scrollController.addListener(() {
      if (scrollController.offset <= 100 &&
          !controller.isLoadingMore.value &&
          controller.hasMore.value) {
        controller.loadMoreMessages();
      }
    });
  }

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 200), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CircleAvatar(
            backgroundImage:
            (widget.photo.isNotEmpty) ? NetworkImage(widget.photo) : null,
            backgroundColor: Colors.grey.shade300,
            child: widget.photo.isEmpty
                ? Text(
              widget.name[0],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: Colors.blueGrey,
              ),
            )
                : null,
          ),
        ),
        title: Text(widget.name, style: const TextStyle(color: Colors.black)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
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
                child: Column(
                  children: [
                    if (controller.isLoadingMore.value)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.all(12.w),
                        reverse: true,
                        keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) {
                          final message = controller.messages[
                          controller.messages.length - 1 - index];
                          final isMe =
                              message['senderId'] == controller.currentUserId;
                          return _buildMessageCard(message['text'] ?? '', isMe);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.attach_file),
                          onPressed: () {}),
                      Expanded(
                        child: TextField(
                          controller: controller.textEditingController,
                          onTap: scrollToBottom,
                          onChanged: (_) => scrollToBottom(),
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
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
                          controller.sendMessage();
                          scrollToBottom();
                        },
                      ),
                    ],
                  ),
                ),
              ),
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
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(text, style: TextStyle(fontSize: 14.sp)),
      ),
    );
  }
}
