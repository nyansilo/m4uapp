import 'package:package_info_plus/package_info_plus.dart';

import '../models/model.dart';

class Application {
  static bool debug = false;
  //static String googleAPI = 'AIzaSyAGHlk0PoZ-BdSwUJh_HGSHXWKlARE4Pt8';
  static String domain = 'https://madalali4u.herokuapp.com';
  //static String domain = 'http://localhost:8000';

  static String defaultImage = '${domain}/img/default-placeholder.png';

  static DeviceModel? device;
  static PackageInfo? packageInfo;

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
