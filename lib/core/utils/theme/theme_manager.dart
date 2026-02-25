import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/theme/app_colors.dart';

abstract class ThemeManager {
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkColor,
    primaryColor: AppColors.darkColor,
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w400,
        color: AppColors.whiteColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w400,
        color: AppColors.whiteColor,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w800,
        color: AppColors.whiteColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w700,
        color: AppColors.whiteColor,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.greyColor,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      hintStyle: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w400,
        color: AppColors.whiteColor,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w700,
        color: AppColors.whiteColor,
        fontSize: 20,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.primaryColor,
      thickness: 1,
    ),
  );
}