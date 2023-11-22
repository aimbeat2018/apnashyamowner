// Ligth & Dark Themes
import 'package:flutter/material.dart';

import '../colors/color_palete.dart';
import '../colors/colors.dart';

class MyTheme {
  static ThemeData get lighttheme => ThemeData(
      primarySwatch: Palette.kToDark,
      splashColor: AppColors.btnColor,
      scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
      shadowColor: const Color.fromARGB(255, 230, 230, 230),
      disabledColor: const Color.fromARGB(255, 246, 239, 223),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      primaryColor: Colors.black,
      cardColor: Colors.white,
      canvasColor: Colors.white,
      hintColor: Colors.black,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        // centerTitle: true
      ));
  static ThemeData get darktheme => ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 55, 55, 55),
      shadowColor: Colors.transparent,
      disabledColor: const Color.fromARGB(255, 51, 51, 51),
      iconTheme: const IconThemeData(color: Colors.white),
      primaryColor: Colors.white,
      cardColor: Colors.black,
      canvasColor: const Color.fromARGB(255, 55, 55, 55),
      drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
      hintColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        // centerTitle: true
      ), colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors().mycolor).copyWith(background: Colors.white));
}
