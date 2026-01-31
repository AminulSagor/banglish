import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    // Splash delay
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Check actual login status from local storage/auth service
    // For now, always go to login
    Get.offAllNamed(AppRoutes.login);
  }
}
