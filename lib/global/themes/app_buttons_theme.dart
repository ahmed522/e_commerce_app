import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class AppButtonsTheme {
  static ElevatedButtonThemeData getAppElevatedButtonTheme(
          Brightness brightness) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
  static TextButtonThemeData getAppTextButtonTheme(Brightness brightness) =>
      TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: (brightness == Brightness.light)
              ? AppColors.primaryColor
              : AppColors.lightColor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(
            color: (brightness == Brightness.light)
                ? AppColors.primaryColor
                : AppColors.lightColor1,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
