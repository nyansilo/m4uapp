import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app_container.dart';
import 'classes/language_constant.dart';
import 'config/config.dart';
import 'utils/utils.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _AppState? state = context.findAncestorStateOfType<_AppState>();
    state?.setLocale(newLocale);
  }
}

class _AppState extends State<App> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    /// whenever your initialization is completed, remove the splash screen:
    Future.delayed(const Duration(seconds: 5))
        .then((value) => {FlutterNativeSplash.remove()});
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //themeMode: ThemeMode.system,
      //themeMode: ThemeMode.light,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      /*theme: ThemeData(
        textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 14.5,
              letterSpacing: 0.15,
              color: AppColor.headline6,
            ),
            bodyText1: TextStyle(
              fontSize: 14,
              color: AppColor.bodyColor1,
            ),
            caption: TextStyle(
              fontSize: 11,
              letterSpacing: 0.15,
              color: AppColor.captionColor,
            ),
          ),
          
        primarySwatch: brandingColor,
      ),
      */
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      onGenerateRoute: Routes.generateRoute,
      home: const Scaffold(
        body: AppContainer(),
      ),
    );
  }
}
