import 'package:e_commerce_app/global/themes/app_text_theme.dart';
import 'package:flutter/material.dart';

class AppbarTheme {
  static AppBarTheme getAppBarTheme(Brightness brightness) => AppBarTheme(
        titleTextStyle: AppTextTheme.appBarTitleTextStyle,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor:
            (brightness == Brightness.light) ? Colors.white : Colors.black,
      );
}
