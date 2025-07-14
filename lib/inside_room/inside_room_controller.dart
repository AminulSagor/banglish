import 'package:get/get.dart';

class InsideRoomController extends GetxController {
  final isAdmin = true.obs; // Set based on current user's role
  final messages = <String>[].obs;

  final isVideoOn = true.obs;
  final isAudioOn = true.obs;

  void toggleVideo() => isVideoOn.toggle();
  void toggleAudio() => isAudioOn.toggle();

  void sendMessage(String msg) {
    if (msg.trim().isNotEmpty) {
      messages.add(msg.trim());
    }
  }

  void leaveRoom() {
    // TODO: Implement leave room logic
  }

  void banUser() {
    // TODO: Admin bans a user
  }

  void shareRoomLink() {
    // TODO: Copy or share room link
  }
}
