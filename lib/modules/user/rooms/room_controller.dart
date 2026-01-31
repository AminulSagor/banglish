import 'package:get/get.dart';

import '../../../core/models/room_model.dart';
import '../../../core/services/mock_data_service.dart';

class RoomController extends GetxController {
  var rooms = <RoomModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadRooms();
  }

  void loadRooms() {
    isLoading.value = true;

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 300), () {
      rooms.assignAll(MockDataService.mockRooms);
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
