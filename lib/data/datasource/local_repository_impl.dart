import 'package:m4uapp/models/user_model.dart';
import 'package:m4uapp/repositories/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefToken = 'TOKEN';
const _prefUserName = "USERNAME";
const _prefFirstName = 'FIRSTNAME';
const _prefLastName = 'LASTNAME';
const _prefImage = 'IMAGE';
const _prefDarkTheme = 'DARK_THEME';

class LocalRepositoryImpl extends LocalRespositoryInterface {
  @override
  Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_prefToken);
  }

  @override
  Future<String?> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_prefToken, token);

    return token;
  }

  @override
  Future<UserModel?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userName = sharedPreferences.getString(_prefUserName);
    final firstName = sharedPreferences.getString(_prefFirstName);
    final lastName = sharedPreferences.getString(_prefLastName);
    final profileImg = sharedPreferences.getString(_prefImage);

    final user = UserModel(
      userName: userName,
      firstName: firstName,
      lastName: lastName,
      profileImg: profileImg,
    );
    return user;
  }

  @override
  Future<UserModel?> saveUser(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_prefUserName, user.userName!);
    sharedPreferences.setString(_prefFirstName, user.firstName!);
    sharedPreferences.setString(_prefLastName, user.lastName!);
    sharedPreferences.setString(_prefImage, user.profileImg!);
    return user;
  }

  @override
  Future<bool?> isDarkMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    print('is Logged In : ${sharedPreferences.getBool(_prefDarkTheme)}');

    return sharedPreferences.getBool(_prefDarkTheme) ?? false;
  }

  @override
  Future<void> saveDarkMode(bool darkMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_prefDarkTheme, darkMode);
  }
}
