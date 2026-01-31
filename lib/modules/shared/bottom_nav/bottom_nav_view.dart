import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../user/home/active_people_view.dart';
import '../../user/messages/message_list_view.dart';
import '../../user/rooms/room_list_view.dart';
import '../../user/account/account_view.dart';
import 'bottom_nav_controller.dart';

class BottomNavView extends GetView<BottomNavController> {
  const BottomNavView({super.key});

  List<Widget> get pages => [
    const ActivePeopleView(),
    MessageListView(),
    const RoomListView(),
    const AccountView(),
  ];

  List<IconData> get icons => [
    Icons.people,
    Icons.message,
    Icons.video_call,
    Icons.person,
  ];

  List<String> get labels => ["Active", "Message", "Rooms", "Account"];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTab,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey500,
          backgroundColor: AppColors.white,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
          ),
          items: List.generate(
            icons.length,
            (i) =>
                BottomNavigationBarItem(icon: Icon(icons[i]), label: labels[i]),
          ),
        ),
      ),
    );
  }
}
