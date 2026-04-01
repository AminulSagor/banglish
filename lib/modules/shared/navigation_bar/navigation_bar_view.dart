import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../active/active_view.dart';
import '../../home/home_view.dart';
import '../../messages/messages_view.dart';
import '../../my_rooms/my_rooms_view.dart';
import '../../profile/profile_view.dart';
import 'navigation_bar_controller.dart';

class NavigationBarView extends GetView<NavigationBarController> {
  const NavigationBarView({super.key});

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return MessagesView();
      case 2:
        return const MyRoomsView();
      case 3:
        return const ActiveView();
      case 4:
        return const ProfileView();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTab(int index) {
    return Navigator(
      key: controller.navigatorKeys[index],
      onGenerateRoute: (_) =>
          MaterialPageRoute<void>(builder: (_) => _buildTabContent(index)),
    );
  }

  Widget _buildBottomNavBar() {
    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.message_outlined),
        activeIcon: Icon(Icons.message_rounded),
        label: 'Messages',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.video_call_outlined),
        activeIcon: Icon(Icons.video_call),
        label: 'My Rooms',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.groups_outlined),
        activeIcon: Icon(Icons.groups),
        label: 'Active',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person_outline_rounded),
        activeIcon: Icon(Icons.person_rounded),
        label: 'Profile',
      ),
    ];

    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeTab,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey500,
        backgroundColor: AppColors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 11.sp,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11.sp,
        ),
        items: items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await controller.onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: Obx(
          () => Stack(
            children: List.generate(5, (index) {
              final isVisited = controller.visitedTabs.contains(index);

              if (!isVisited) {
                return const SizedBox.shrink();
              }

              return Offstage(
                offstage: controller.currentIndex.value != index,
                child: TickerMode(
                  enabled: controller.currentIndex.value == index,
                  child: _buildTab(index),
                ),
              );
            }),
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }
}
