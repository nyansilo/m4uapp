import 'package:flutter/material.dart';

import 'app.dart';
import 'config/dependency.dart' as dep;


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const App());
}



