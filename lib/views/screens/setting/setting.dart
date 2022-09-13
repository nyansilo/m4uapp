import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m4uapp/classes/language_constant.dart';
import 'package:m4uapp/controller/theme_controller.dart';

import '../../../config/config.dart';
import '../../../controller/controller.dart';
import '../../../utils/utils.dart';
import '../../widgets/widget.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() {
    return _SettingState();
  }
}

class _SettingState extends State<Setting> {
  final controller = Get.find<ThemeController>();
  bool _receiveNotification = true;
  //DarkOption _darkOption = AppBloc.themeCubit.state.darkOption;
  String? _errorDomain;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On Change Dark Option
  void _onChangeDarkOption() {
    //AppBloc.themeCubit.onChangeTheme(darkOption: _darkOption);
  }

  ///On navigation
  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  ///Show dark theme setting
  void _onThemeUpdate(bool isDark) {
    controller.updateTheme(isDark);
    Get.changeTheme(isDark ? Themes.darkTheme : Themes.lightTheme);
  }

  @override
  Widget build(BuildContext context) {
    LanguageController langController = Get.put(LanguageController());
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        /*leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        */

        centerTitle: true,
        elevation: 0,
        title: Text(translation(context).setting,
            style: Theme.of(context).textTheme.headline6),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: <Widget>[
            AppListTitle(
              title: translation(context).language,
              onPressed: () {
                _onNavigate(Routes.changeLanguageRoute);
              },
              trailing: Row(
                children: <Widget>[
                  Obx(
                    () => Text(
                      langController.languageName,
                      //UtilLanguage.getGlobalLanguageName(
                      //AppBloc.languageCubit.state.languageCode,
                      //),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
            AppListTitle(
              title: translation(context).notification,
              trailing: CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: _receiveNotification,
                onChanged: (value) {
                  setState(() {
                    _receiveNotification = value;
                  });
                },
              ),
            ),
            AppListTitle(
              title: translation(context).theme,
              onPressed: () {
                //_onNavigate(Routes.themeSettingRote);
              },
              trailing: Container(
                margin: const EdgeInsets.only(right: 8),
                width: 16,
                height: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
            AppListTitle(
              title: controller.darkTheme.value
                  ? translation(context).dark_mode
                  : translation(context).light_mode,
              trailing: Obx(() {
                return CupertinoSwitch(
                  activeColor: Theme.of(context).primaryColor,
                  value: controller.darkTheme.value,
                  onChanged: (value) {
                    _onThemeUpdate(value);
                  },
                );
              }),
            ),
            AppListTitle(
              title: translation(context).font,
              onPressed: () {
                //_onNavigate(Routes.fontSettingRoute);
              },
              trailing: Row(
                children: <Widget>[
                  Text(
                    "Calibri",
                    //AppBloc.themeCubit.state.font,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
            AppListTitle(
              title: translation(context).app_version,
              onPressed: () {},
              trailing: Row(
                children: <Widget>[
                  Text(
                    Application.packageInfo?.version ?? '1.0',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
              border: false,
            ),
          ],
        ),
      ),
    );
  }
}
