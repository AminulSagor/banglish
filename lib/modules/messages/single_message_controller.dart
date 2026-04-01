import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/message_model.dart';
import '../../../core/services/mock_data_service.dart';

class SingleMessageController extends GetxController {
  final messages = <MessageModel>[].obs;
  final isLoading = true.obs;
  final isLoadingMore = false.obs;
  final hasMore = false.obs;

  final textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final String currentUserId = 'current_user';
  final String receiverId;

  SingleMessageController({required this.receiverId});

  @override
  void onInit() {
    super.onInit();
    _loadMessages();
  }

  // void goBack() {
  //   Get.back();
  // }

  void _loadMessages() {
    isLoading.value = true;

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 300), () {
      // Filter mock messages for this conversation
      final conversationMessages = MockDataService.mockMessages
          .where(
            (msg) =>
                (msg.senderId == currentUserId &&
                    msg.receiverId == receiverId) ||
                (msg.senderId == receiverId && msg.receiverId == currentUserId),
          )
          .toList();

      messages.assignAll(conversationMessages);
      isLoading.value = false;
    });
  }

  void sendMessage() {
    final text = textEditingController.text.trim();
    if (text.isEmpty) return;

    final newMessage = MessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderId: currentUserId,
      receiverId: receiverId,
      text: text,
      timestamp: DateTime.now(),
      isRead: false,
    );

    messages.add(newMessage);
    textEditingController.clear();
  }

  @override
  void onClose() {
    scrollController.dispose();
    textEditingController.dispose();
    super.onClose();
  }
}
