import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'message_service.dart';

class SingleMessageController extends GetxController {
  final MessageService _messageService = MessageService();

  final messages = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;

  final textEditingController = TextEditingController();
  late String currentUserId;

  DocumentSnapshot? _lastDocument;
  final int _pageSize = 20;
  final String receiverId;

  SingleMessageController({required this.receiverId});

  @override
  void onInit() {
    super.onInit();
    _initUserAndMessages();
  }

  Future<void> _initUserAndMessages() async {
    final prefs = await SharedPreferences.getInstance();
    currentUserId = prefs.getString('uid') ?? '';
    isLoading.value = true;

    _messageService
        .getMessages(userId: currentUserId, limit: _pageSize)
        .listen((list) {
      final filtered = list.where((msg) =>
      (msg['senderId'] == currentUserId && msg['receiverId'] == receiverId) ||
          (msg['senderId'] == receiverId && msg['receiverId'] == currentUserId)).toList();

      if (filtered.isNotEmpty) {
        _lastDocument = filtered.last['doc'];
        messages.value = filtered.reversed.toList(); // Show newest at bottom
        hasMore.value = filtered.length >= _pageSize;
      }

      isLoading.value = false;
    });
  }

  Future<void> loadMoreMessages() async {
    if (isLoadingMore.value || !hasMore.value || _lastDocument == null) return;

    isLoadingMore.value = true;

    final moreMessages = await _messageService.fetchMoreMessages(
      userId: currentUserId,
      lastDoc: _lastDocument!,
      limit: _pageSize,
    );

    final filtered = moreMessages.where((msg) =>
    (msg['senderId'] == currentUserId && msg['receiverId'] == receiverId) ||
        (msg['senderId'] == receiverId && msg['receiverId'] == currentUserId)).toList();

    if (filtered.isNotEmpty) {
      _lastDocument = filtered.last['doc'];
      messages.insertAll(0, filtered.reversed); // Insert at top
    } else {
      hasMore.value = false;
    }

    isLoadingMore.value = false;
  }

  void sendMessage() {
    final text = textEditingController.text.trim();
    if (text.isNotEmpty && receiverId.isNotEmpty && currentUserId.isNotEmpty) {
      _messageService.sendMessage(
        senderId: currentUserId,
        receiverId: receiverId,
        text: text,
      );
      textEditingController.clear();
    }
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
