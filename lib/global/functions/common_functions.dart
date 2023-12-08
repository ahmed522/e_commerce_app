import 'package:e_commerce_app/features/authentication/model/user_model.dart';
import 'package:e_commerce_app/global/constants/images_assets.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:e_commerce_app/global/services/cache_helper.dart';
import 'package:flutter/material.dart';

import '../widgets/error_page.dart';

class CommonFunctions {
  static ErrorPage get internetError => const ErrorPage(
        imageAsset: AppImagesAssets.errorImageAsset,
        message: AppStrings.errorPageText,
      );

  static bool isLightMode(BuildContext context) =>
      (Theme.of(context).brightness == Brightness.light);

  static Future<UserData> loadUserData() async {
    Map<String, dynamic> json = {};
    json['name'] = await CacheHelper.getData(key: 'name');
    json['email'] = await CacheHelper.getData(key: 'email');
    json['phone'] = await CacheHelper.getData(key: 'phone');
    json['nationalId'] = await CacheHelper.getData(key: 'nationalId');
    json['gender'] = await CacheHelper.getData(key: 'gender');
    json['profileImage'] = await CacheHelper.getData(key: 'profileImage');
    json['token'] = await CacheHelper.getData(key: 'token');
    return UserData.fromJson(json);
  }
}
