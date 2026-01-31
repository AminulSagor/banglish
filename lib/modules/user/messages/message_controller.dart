import 'package:get/get.dart';

import '../../../core/models/chat_model.dart';
import '../../../core/services/mock_data_service.dart';

class MessageController extends GetxController {
  var chats = <ChatModel>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadChats();
  }

  void loadChats() {
    isLoading.value = true;

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 300), () {
      chats.assignAll(MockDataService.mockChats);
      isLoading.value = false;
    });
  }

  List<ChatModel> get filteredChats {
    if (searchQuery.value.isEmpty) return chats;
    return chats
        .where(
          (chat) =>
              chat.name.toLowerCase().contains(searchQuery.value.toLowerCase()),
        )
        .toList();
  }
}
