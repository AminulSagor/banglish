import 'package:get/get.dart';
import '../services/services.dart';

/// Initial bindings for services that should be available app-wide
class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Services
    //Get.put<MockDataService>(MockDataService(), permanent: true); Note: MockDataService uses static members, no instance binding needed
    Get.put<AuthService>(AuthService(), permanent: true);
  }
}
