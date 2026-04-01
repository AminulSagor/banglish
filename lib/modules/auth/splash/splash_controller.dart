import 'package:get/get.dart';

import '../../../core/services/auth_service.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    // Splash delay
    await Future.delayed(const Duration(seconds: 1));

    if (_authService.isSignedIn) {
      Get.offAllNamed(AppRoutes.mainNavigation);
      return;
    }

    // Guest users land on Home without bottom navigation.
    Get.offAllNamed(AppRoutes.home);
  }
}
