import 'package:flutter/material.dart';
import 'package:m4uapp/utils/utils.dart';
import 'package:material_color_generator/material_color_generator.dart';

class Themes {
//ColorScheme? colorScheme;

  //final indicatorColor = isDark ? colorScheme.onSurface : colorScheme.primary;

  static final lightTheme = ThemeData.light().copyWith(
    //primarySwatch: brandingColor,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: generateMaterialColor(color: AppColor.whiteColor),
    ),
    primaryColor: brandingColor,
    accentColor: Colors.red,
    brightness: Brightness.light,
    backgroundColor: AppColor.scaffoldBGColor,
    buttonColor: brandingColor,
    bottomAppBarColor: Colors.white,
    buttonTheme: const ButtonThemeData(
      buttonColor: brandingColor,
      textTheme: ButtonTextTheme.primary,
      disabledColor: Colors.grey,
    ),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: generateMaterialColor(color: Colors.black),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 67, 67, 68),
      foregroundColor: Colors.black,
      //shadowColor: Color.onSurface.withOpacity(0.2),
    ),
    primaryColor: brandingColor,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    buttonColor: Colors.deepPurple,
    bottomAppBarColor: Color.fromARGB(255, 67, 67, 68),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.deepPurple,
      textTheme: ButtonTextTheme.primary,
      disabledColor: Colors.grey,
    ),
  );
}
