import 'package:get/get.dart';
import '../../../core/services/api_error_handler.dart';
import '../../../core/models/room_model.dart';
import '../services/user_module_service.dart';

class RoomController extends GetxController {
  final ApiErrorHandler _apiErrorHandler = Get.find<ApiErrorHandler>();
  final UserModuleService _userService = Get.find<UserModuleService>();

  var rooms = <RoomModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadRooms();
  }

  void loadRooms() {
    isLoading.value = true;
    _apiErrorHandler
        .handle<List<RoomModel>>(
          () => _userService.getRooms(),
          defaultErrorCode: 'ROOM_LOAD_FAILED',
        )
        .then((ApiResponse<List<RoomModel>> response) {
          rooms.assignAll(response.data ?? <RoomModel>[]);
          isLoading.value = false;
        });
  }

  void createRoom(String name, String topic) {
    final newRoom = RoomModel(
      id: 'room_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      topic: topic,
      participants: ['current_user'],
      createdAt: 'Just now',
      creatorUid: 'current_user',
      isActive: true,
    );

    rooms.insert(0, newRoom);
  }

  void joinRoom(String roomId) {
    // TODO: Implement join room logic
    Get.snackbar('Joining Room', 'Connecting to room...');
  }
}
