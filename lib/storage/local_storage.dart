import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _sharedPreferences;

  static LocalStorage _singleton =  LocalStorage._internal();

  factory LocalStorage() {
    return _singleton;
  }

  LocalStorage._internal() {
    // Init your variables
    initializeSharedPreferences();
  }

  static Future<SharedPreferences> initializeSharedPreferences() async {
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<Future<bool>> clearSharedPreferences() async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    return  _sharedPreferences.clear();
  }

  static Future<bool> setStringItem(dynamic key, dynamic value) async {
    return await _sharedPreferences!.setString(key, value);
  }

  static Future<bool> setIntItem(dynamic key, dynamic value) async {
    return await _sharedPreferences!.setInt(key, value);
  }

  static String? getStringItem(dynamic key) {
    return  _sharedPreferences!.getString(key);
  }

  static int? getIntItem(dynamic key) {
    return _sharedPreferences!.getInt(key);
  }
}
