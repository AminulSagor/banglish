import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bottom_nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  final controller = Get.put(BottomNavController());

  final List<IconData> icons = [
    Icons.people,
    Icons.message,
    Icons.video_call,
    Icons.person,
  ];

  final List<String> labels = [
    "Active",
    "Message",
    "Rooms",
    "Profile",
  ];

  final Function(int) onTap;

  BottomNavBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      currentIndex: controller.selectedIndex.value,
      onTap: (index) {
        controller.changeTab(index);
        onTap(index);
      },
      selectedItemColor: const Color(0xFF1976D2), // Deep Blue
      unselectedItemColor: const Color(0xFF9E9E9E), // Neutral Gray
      backgroundColor: Colors.white,
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
            (i) => BottomNavigationBarItem(
          icon: Icon(icons[i]),
          label: labels[i],
        ),
      ),
    ));
  }
}
