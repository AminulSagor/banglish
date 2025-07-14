import 'package:get/get.dart';

class Chat {
  final String name;
  final String photo;
  final String lastMessage;
  final String time;

  Chat({
    required this.name,
    required this.photo,
    required this.lastMessage,
    required this.time,
  });
}

class MessageController extends GetxController {
  var chats = <Chat>[
    Chat(
      name: 'Alice',
      photo: 'https://i.pravatar.cc/150?img=1',
      lastMessage: 'Hey there!',
      time: '10:30 AM',
    ),
    Chat(
      name: 'Bob',
      photo: 'https://i.pravatar.cc/150?img=2',
      lastMessage: "Let's call later.",
      time: '9:15 AM',
    ),
  ].obs;
}
