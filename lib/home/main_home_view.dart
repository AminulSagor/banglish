import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bottom_nav/bottom_nav_bar.dart';
import '../bottom_nav/bottom_nav_controller.dart';
import '../message/ message_view.dart';
import '../profile/profile_view.dart';
import '../room_list/room_list_view.dart';
import 'active_people_view.dart';


class MainHomeView extends StatelessWidget {
  final controller = Get.put(BottomNavController());

  final pages = [
    ActivePeopleView(),
    MessageView(),
    RoomListView(),
    ProfileView(),
  ];

  MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: pages[controller.selectedIndex.value],
      bottomNavigationBar: BottomNavBar(
        onTap: controller.changeTab,
      ),
    ));
  }
}
