import 'package:get/get.dart';

import '../config/config.dart';
import '../repositories/repository.dart';

class ThemeController extends GetxController {
  final LocalRespositoryInterface localRepositoryInterface;
  ThemeController({
    required this.localRepositoryInterface,
  });

  RxBool darkTheme = false.obs;

  @override
  void onInit() {
    loadCurrentTheme();
    //validateTheme();
    super.onInit();
  }

  void loadCurrentTheme() {
    localRepositoryInterface.isDarkMode().then(
      (value) {
        darkTheme(value);
      },
    );
  }

  bool updateTheme(bool isDark) {
    localRepositoryInterface.saveDarkMode(isDark);

    darkTheme(isDark);

    return isDark;
  }

  void validateTheme() async {
    final isDark = await localRepositoryInterface.isDarkMode();
    if (isDark != null) {
      Get.changeTheme(isDark ? Themes.darkTheme : Themes.lightTheme);
    } else {
      Get.changeTheme(Get.isDarkMode ? Themes.darkTheme : Themes.lightTheme);
    }
  }
}
