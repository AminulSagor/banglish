import 'package:get/get.dart';
import '../../../core/services/api_error_handler.dart';
import '../../../core/models/chat_model.dart';
import '../services/user_module_service.dart';

class MessageController extends GetxController {
  final ApiErrorHandler _apiErrorHandler = Get.find<ApiErrorHandler>();
  final UserModuleService _userService = Get.find<UserModuleService>();

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
    _apiErrorHandler
        .handle<List<ChatModel>>(
          () => _userService.getChats(),
          defaultErrorCode: 'CHAT_LOAD_FAILED',
        )
        .then((ApiResponse<List<ChatModel>> response) {
          chats.assignAll(response.data ?? <ChatModel>[]);
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
