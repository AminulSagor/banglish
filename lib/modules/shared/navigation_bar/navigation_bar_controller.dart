import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationBarController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxSet<int> visitedTabs = <int>{0}.obs;
  final List<GlobalKey<NavigatorState>> navigatorKeys = List.generate(
    5,
    (index) => GlobalKey<NavigatorState>(debugLabel: 'tabNavigator$index'),
  );
  DateTime? _lastBackPressTime;

  void changeTab(int index) {
    if (currentIndex.value == index) {
      navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
      return;
    }

    currentIndex.value = index;
    visitedTabs.add(index);
  }

  void resetToHome() {
    currentIndex.value = 0;
    visitedTabs.add(0);
  }

  Future<bool> onWillPop() async {
    final int tabIndex = currentIndex.value;
    final NavigatorState? currentTabNavigator =
        navigatorKeys[tabIndex].currentState;
    final bool canPopCurrentTab =
        currentTabNavigator != null && currentTabNavigator.canPop();

    if (canPopCurrentTab) {
      currentTabNavigator.pop();
      return false;
    }

    if (tabIndex != 0) {
      resetToHome();
      return false;
    }

    final now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;
      Get.snackbar(
        'Exit App',
        'Press back again to close the app',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }
}
