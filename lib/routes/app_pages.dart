import 'package:get/get.dart';
import '../modules/auth/auth.dart';
import '../modules/shared/shared.dart';
import '../modules/user/user.dart';
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
        Get.lazyPut(() => LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SignupController());
      }),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ForgotPasswordController());
      }),
    ),
    // GetPage(
    //   name: AppRoutes.otp,
    //   page: () => OtpView(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut(() => OtpController());
    //   }),
    // ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ChangePasswordController());
      }),
    ),

    // Main pages
    GetPage(
      name: AppRoutes.bottomNav,
      page: () => const BottomNavView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => BottomNavController());
        Get.lazyPut(() => FilterController());
        Get.lazyPut(() => ActivePeopleController());
        Get.lazyPut(() => MessageController());
        Get.lazyPut(() => RoomController());
        Get.lazyPut(() => ProfileController());
        Get.lazyPut(() => AccountViewController());
      }),
    ),

    // User pages
    GetPage(
      name: AppRoutes.home,
      page: () => const ActivePeopleView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => FilterController());
        Get.lazyPut(() => ActivePeopleController());
      }),
    ),
    GetPage(
      name: AppRoutes.messages,
      page: () => MessageListView(),
      binding: BindingsBuilder(() {
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
      page: () => const RoomListView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => RoomController());
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
      page: () => ProfileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProfileController());
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
