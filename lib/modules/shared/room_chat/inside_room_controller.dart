import 'package:get/get.dart';

class InsideRoomController extends GetxController {
  final String roomId;
  
  final isAdmin = false.obs;
  final messages = <String>[].obs;
  final isVideoOn = true.obs;
  final isAudioOn = true.obs;
  final participants = <String>[].obs;

  InsideRoomController({required this.roomId});

  @override
  void onInit() {
    super.onInit();
    _loadRoomData();
  }

  void _loadRoomData() {
    // Mock participants
    participants.addAll(['U1', 'U2', 'U3', 'U4', 'U5', 'U6', 'U7', 'U8']);
    
    // Mock initial messages
    messages.addAll([
      'Hello everyone!',
      'Welcome to the room!',
      'Let\'s get started!',
    ]);
  }

  void toggleVideo() => isVideoOn.toggle();
  void toggleAudio() => isAudioOn.toggle();

  void sendMessage(String msg) {
    if (msg.trim().isNotEmpty) {
      messages.add(msg.trim());
    }
  }

  void leaveRoom() {
    Get.back();
    Get.snackbar('Left Room', 'You have left the room');
  }

  void banUser() {
    // TODO: Admin bans a user
    Get.snackbar('Ban User', 'Select a user to ban');
  }

  void shareRoomLink() {
    // TODO: Copy or share room link
    Get.snackbar('Link Copied', 'Room link copied to clipboard');
  }
}
