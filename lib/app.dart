import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_container.dart';
import 'config/config.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: brandingColor),
      onGenerateRoute: Routes.generateRoute,
      home: const Scaffold(
        body: AppContainer(),
      ),
    );
  }
}
