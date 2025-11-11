/// The max width the content can ever take up on the screen
const double kdDesktopMaxContentWidth = 1150;

// The max height the homeview will take up
const double kdDesktopMaxContentHeight = 750;

class AppConstants {
  AppConstants._();

  static const String appVersion = '0.0.1';

  // API Constants
  static const int receiveTimeout = 20000;
  static const int connectionTimeout = 30000;
  static const String baseUrl =
      'https://november7-730026606190.europe-west1.run.app';
  static const String getImageEndpoint = '/image';
}
