import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/helpers_index.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: IURColors.lightBackgroundColor,
    primaryColor: IURColors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      backgroundColor: IURColors.white,
    ),
    cardColor: IURColors.white,
    textTheme: GoogleFonts.archivoTextTheme().copyWith(
      titleLarge: TextStyle(
        color: IURColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 11,
      ),
      titleMedium: TextStyle(
        color: IURColors.black,
        fontWeight: FontWeight.w300,
        fontSize: 13,
      ),
      headlineMedium: TextStyle(
        color: IURColors.black,
        fontWeight: FontWeight.w300,
        fontSize: 13,
      ),
      displayLarge: TextStyle(
        color: IURColors.black,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
      displaySmall: TextStyle(
        color: IURColors.black,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(),
    colorScheme: ColorScheme.dark(surface: IURColors.white),
  );
}
