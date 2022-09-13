import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../classes/language.dart';

class LanguageController extends GetxController {
 final List<Language> allLanguages = Language.languageList();

  Rx<List<Language>> foundlanguage = Rx<List<Language>>([]);

  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    foundlanguage.value = allLanguages;
    _languageName.value = box.read('_languageName') ?? "English";
    ever(
      _languageName,
      (value) {
        box.write('_languageName', value);
      },
    );
  }

  final _languageName = 'English'.obs;

  String get languageName => _languageName.value;

  void updateLanguageName(String value) {
    _languageName.value = value;
  }

  void filterLangauge(String langName) {
    List<Language> results = [];
    if (langName.isEmpty) {
      results = allLanguages;
    } else {
      results = allLanguages
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(langName.toLowerCase()))
          .toList();
    }
    foundlanguage.value = results;
  }
}
