import 'package:get/get.dart';
import '../auth/change_password/change_password_view.dart';
import '../auth/change_password_token/change_known_password_view.dart';
import '../auth/forget_password/forget_password_view.dart';
import '../auth/login/login_view.dart';
import '../auth/otp/otp_view.dart';
import '../auth/signup/signup_view.dart';
import '../home/main_home_view.dart';
import '../inside_room/inside_room_view.dart';
import '../message/ message_view.dart';
import '../message/message_controller.dart';
import '../message/single_message_view.dart';
import '../profile/profile_view.dart';
import '../room_list/room_list_view.dart';
import 'app_routes.dart';

final List<GetPage> appPages = [
  GetPage(name: AppRoutes.login, page: () => LoginView()),
  // Add the rest of the views like below:
  GetPage(name: AppRoutes.signUp, page: () => SignUpView()),
  GetPage(name: AppRoutes.forgetPassword, page: () => ForgetPasswordView()),
  GetPage(name: AppRoutes.otp, page: () => OTPView()),
  GetPage(name: AppRoutes.changePassword, page: () => ChangePasswordView()),
  GetPage(name: AppRoutes.home, page: () => MainHomeView()),
  GetPage(name: AppRoutes.roomList, page: () => RoomListView()),
  GetPage(name: AppRoutes.insideRoom, page: () => InsideRoomView()),
  GetPage(name: AppRoutes.profile, page: () => ProfileView()),

  GetPage(
    name: '/messages',
    page: () => MessageView(),
    binding: BindingsBuilder(() => Get.lazyPut(() => MessageController())),
  ),
  GetPage(
    name: '/single_message',
    page: () => SingleMessageView(
      name: Get.arguments['name'],
      photo: Get.arguments['photo'],
    ),
  ),

  GetPage(
    name: AppRoutes.changeKnownPassword,
    page: () => ChangeKnownPasswordView(),
  ),


];
