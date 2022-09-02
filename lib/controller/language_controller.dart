import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    _languageName.value = box.read('_languageName') ?? "";
    ever(
      _languageName,
      (value) {
        box.write('_languageName', value);
      },
    );
  }

  final RxString _languageName = 'English'.obs;

  String get languageName => _languageName.value;

  void updateLanguageName(String value) {
    _languageName.value = value;
  }
}
