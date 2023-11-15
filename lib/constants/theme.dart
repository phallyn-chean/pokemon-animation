import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/colors.dart';
import 'package:pokemon_animation/constants/fonts.dart';

class Themings {
  static const TextStyle darkText = TextStyle(
    color: AppColors.whiteGrey,
    fontFamily: AppFonts.circularStd,
  );

  static const TextStyle lightText = TextStyle(
    color: AppColors.black,
    fontFamily: AppFonts.circularStd,
  );

  static final ThemeData dartTheme = ThemeData(
    primaryColor: AppColors.blue,
    // ignore: deprecated_member_use
    backgroundColor: Colors.black,
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(toolbarTextStyle: darkText),
    textTheme: const TextTheme(
      bodyLarge: darkText,
      bodyMedium: darkText,
      labelMedium: darkText,
      bodySmall: darkText,
      labelLarge: darkText,
      labelSmall: darkText,
    ),
    scaffoldBackgroundColor: AppColors.black,
  );

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    // ignore: deprecated_member_use
    backgroundColor: AppColors.whiteGrey,
    brightness: Brightness.light,
    primaryColor: AppColors.blue,
    appBarTheme: const AppBarTheme(toolbarTextStyle: lightText),
    textTheme: const TextTheme(
      bodyLarge: lightText,
      bodyMedium: lightText,
      labelMedium: lightText,
      bodySmall: lightText,
      labelLarge: lightText,
      labelSmall: lightText,
    ),
    scaffoldBackgroundColor: AppColors.lightGrey,
  );
}
