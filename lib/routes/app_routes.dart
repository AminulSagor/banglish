/// Route constants for the application
abstract class AppRoutes {
  // Auth routes
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String otp = '/otp';
  static const String changePassword = '/change-password';

  // Main routes
  static const String home = '/home';
  static const String mainNavigation = '/main-navigation';

  // User routes
  static const String profile = '/profile';
  static const String messages = '/messages';
  static const String singleMessage = '/single-message';
  static const String rooms = '/rooms';
  static const String myRooms = '/my-rooms';
  static const String insideRoom = '/inside-room';

  // Policy routes
  static const String privacyPolicy = '/privacy-policy';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String aboutApp = '/about-app';
  // Initial route
  static const String initial = splash;
}
