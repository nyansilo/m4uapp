import '../models/model.dart';

abstract class LocalRespositoryInterface {
  Future<String?> getToken();
  Future<String?> saveToken(String token);
  Future<void> clearAllData();
  Future<UserModel?> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> saveDarkMode(bool darkMode);
  Future<bool?> isDarkMode();
}
