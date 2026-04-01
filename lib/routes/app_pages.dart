import 'package:get/get.dart';
import '../core/services/services.dart';
import '../modules/auth/auth.dart';
import '../modules/shared/shared.dart';
import '../modules/modules.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    // Auth pages
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(
          () => AuthModuleService(
            authService: Get.find<AuthService>(),
            apiClient: Get.find<ApiClient>(),
            tokenService: Get.find<TokenService>(),
          ),
          fenix: true,
        );
        Get.lazyPut(() => LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(
          () => AuthModuleService(
            authService: Get.find<AuthService>(),
            apiClient: Get.find<ApiClient>(),
            tokenService: Get.find<TokenService>(),
          ),
          fenix: true,
        );
        Get.lazyPut(() => SignupController());
      }),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(
          () => AuthModuleService(
            authService: Get.find<AuthService>(),
            apiClient: Get.find<ApiClient>(),
            tokenService: Get.find<TokenService>(),
          ),
          fenix: true,
        );
        Get.lazyPut(() => ForgotPasswordController());
      }),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OTPView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OTPController());
      }),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ChangePasswordController());
      }),
    ),

    // Main pages
    GetPage(
      name: AppRoutes.mainNavigation,
      page: () => const NavigationBarView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UserModuleService(), fenix: true);
        Get.lazyPut(() => NavigationBarController());
        Get.lazyPut(() => FilterController());
        Get.lazyPut(() => ActiveController());
        Get.lazyPut(() => MessageController());
        Get.lazyPut(() => HomeController());
        Get.lazyPut(() => ProfileController());
        Get.lazyPut(() => EditProfileController());
      }),
    ),

    // User pages
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UserModuleService(), fenix: true);
        Get.lazyPut(() => HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.messages,
      page: () => MessagesView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UserModuleService(), fenix: true);
        Get.lazyPut(() => MessageController());
      }),
    ),
    GetPage(
      name: AppRoutes.singleMessage,
      page: () {
        final args = Get.arguments as Map<String, dynamic>? ?? {};
        return SingleMessageView(
          name: args['name'] ?? 'Unknown',
          photo: args['photo'] ?? '',
          uid: args['uid'] ?? '',
        );
      },
    ),
    GetPage(
      name: AppRoutes.rooms,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UserModuleService(), fenix: true);
        Get.lazyPut(() => HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.myRooms,
      page: () => const MyRoomsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UserModuleService(), fenix: true);
        Get.lazyPut(() => HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.insideRoom,
      page: () {
        final roomId = Get.arguments as String? ?? '';
        return InsideRoomView(roomId: roomId);
      },
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const EditProfileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => EditProfileController());
      }),
    ),

    // Policy pages
    GetPage(name: AppRoutes.aboutApp, page: () => const AboutAppPage()),
    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => const PrivacyPolicyPage(),
    ),
    GetPage(
      name: AppRoutes.termsAndConditions,
      page: () => const TermsConditionsPage(),
    ),
  ];
}
