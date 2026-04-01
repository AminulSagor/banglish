import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/api_error_handler.dart';
import '../../../core/models/room_model.dart';
import '../../../routes/app_routes.dart';
import '../shared/services/user_module_service.dart';

class HomeController extends GetxController {
  final ApiErrorHandler _apiErrorHandler = Get.find<ApiErrorHandler>();
  final UserModuleService _userService = Get.find<UserModuleService>();
  final AuthService _authService = Get.find<AuthService>();
  static const String currentUserId = 'current_user';

  var rooms = <RoomModel>[].obs;
  var isLoading = false.obs;

  List<RoomModel> get myRooms {
    return rooms.where((room) => room.creatorUid == currentUserId).toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadRooms();
  }

  void loadRooms() {
    isLoading.value = true;
    _apiErrorHandler
        .call<List<RoomModel>>(
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
      creatorUid: currentUserId,
      isActive: true,
    );

    rooms.insert(0, newRoom);
  }

  void joinRoom(String roomId) {
    if (_authService.isSignedIn) {
      Get.toNamed(AppRoutes.insideRoom, arguments: roomId);
      return;
    }

    Get.bottomSheet<void>(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login Required',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please log in or sign up to join this room.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back<void>();
                        Get.toNamed(AppRoutes.signup);
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back<void>();
                        Get.toNamed(AppRoutes.login);
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      isDismissible: true,
    );
  }
}
