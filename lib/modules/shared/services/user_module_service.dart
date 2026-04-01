import '../../../core/services/mock_data_service.dart';
import '../models/user_module_models.dart';

/// Baseline user module service that returns UI models.
class UserModuleService {
  Future<UserListUiModel> getActivePeople() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return MockDataService.mockUsers;
  }

  Future<ChatListUiModel> getChats() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return MockDataService.mockChats;
  }

  Future<RoomListUiModel> getRooms() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return MockDataService.mockRooms;
  }

  Future<MessageListUiModel> getMessages() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return MockDataService.mockMessages;
  }
}
