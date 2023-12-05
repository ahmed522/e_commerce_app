import 'package:e_commerce_app/features/main/controller/main_cubit.dart';
import 'package:e_commerce_app/global/constants/images_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const String route = 'mainScreen';
  @override
  Widget build(BuildContext context) {
    var cubit = MainCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 25,
                ),
                child: Text(
                  'Welcome ${cubit.user.name}',
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(height: 100),
            SvgPicture.asset(
              AppImagesAssets.signinScreenImageAsset,
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
