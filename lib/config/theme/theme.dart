import 'package:flutter/material.dart';

class LightTheme {
  static final lightTheme = ThemeData(
    backgroundColor: BackgroundColors.lightGrey,
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: TextColors.darkBlue,
        fontSize: 26,
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        color: TextColors.darkBlue,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      headline3: TextStyle(
        color: TextColors.darkBlue,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class BackgroundColors {
  static Color lightGrey = const Color.fromARGB(255, 245, 247, 250);
  static Color blackGrey = const Color(0xFF28272F);
}

class TextColors {
  static const darkBlue = Color(0xFF344767);
}
