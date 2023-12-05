import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/themes/app_text_theme.dart';
import 'package:flutter/material.dart';

class AppbarTheme {
  static AppBarTheme getAppBarTheme(Brightness brightness) => AppBarTheme(
        backgroundColor: brightness == Brightness.light
            ? AppColors.primaryColor
            : AppColors.darkThemeBottomNavBarColor,
        titleTextStyle: AppTextTheme.appBarTitleTextStyle,
        iconTheme: const IconThemeData(color: Colors.white),
      );
}
