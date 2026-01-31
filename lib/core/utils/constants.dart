/// App-wide constants
class Constants {
  Constants._();

  // App Info
  static const String appName = 'Spoken';
  static const String appVersion = '1.0.0';

  // Pagination
  static const int defaultPageSize = 10;
  static const int chatPageSize = 20;

  // Timeouts
  static const int splashDuration = 2; // seconds
  static const int otpResendTimeout = 30; // seconds
  static const int otpLength = 5;

  // Image Placeholders
  static const String defaultAvatar = 'assets/logo.png';
  static const String logoPath = 'assets/logo.png';

  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String messagesCollection = 'messages';
  static const String roomsCollection = 'rooms';
}
