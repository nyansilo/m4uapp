class ImageString {
  static String logo = "assets/images/logo.png";
  static String madalaliLogo = "assets/images/madalalilogo.jpg";
  static String mobileLogo = "assets/images/mobilelogo.png";
  static String placeholder = "assets/images/placeholder.jpg";
  static String defaultImage = "assets/images/default.jpg";

  static const String whatsapp = "assets/images/whatsapp.png";
  static const String telegram = "assets/images/telegram.png";
  static const String viber = "assets/images/viber.png";

  static String china = "assets/flags/cn.png";
  static String india = "assets/flags/in.png";
  static String saudi = "assets/flags/sa.png";
  static String tanzania = "assets/flags/tz.png";
  static String usa = "assets/flags/us.png";



  ///Singleton factory
  static final ImageString _instance = ImageString._internal();

  factory ImageString() {
    return _instance;
  }

  ImageString._internal();
}
