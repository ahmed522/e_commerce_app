import 'package:e_commerce_app/features/main/controller/main_cubit.dart';
import 'package:e_commerce_app/features/main/view/screens/main_screen.dart';
import 'package:e_commerce_app/features/start/view/screens/onboarding_screen.dart';
import 'package:e_commerce_app/features/authentication/view/screens/signin_screen.dart';
import 'package:e_commerce_app/global/constants/images_assets.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:e_commerce_app/global/fonts/app_fonts.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:e_commerce_app/global/services/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const String route = 'splashScreen';
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animateLogo = false;
  bool animateName = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 20)).then((_) {
      setState(
        () {
          animateLogo = true;
        },
      );
      Future.delayed(const Duration(milliseconds: 600)).then(
        (_) {
          setState(
            () {
              animateName = true;
            },
          );
        },
      );

      bool? isFirstTime = CacheHelper.getData(key: 'firstTime');
      if (isFirstTime == null || isFirstTime) {
        Navigator.pushNamedAndRemoveUntil(
            context, OnboardingScreen.route, (route) => false);
      } else {
        String? signedIn = CacheHelper.getData(key: 'token');
        if (signedIn != null) {
          CommonFunctions.loadUserData().then(
            (value) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<MainCubit>(
                    create: (context) => MainCubit(value),
                    child: const MainScreen(),
                  ),
                ),
                (route) => false,
              );
            },
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, SigninScreen.route, (route) => false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 550),
            top: 200,
            left: animateLogo ? size.width / 2 - 75 : -200,
            child: Column(
              children: [
                Image.asset(
                  AppImagesAssets.logoImageAsset,
                  width: 150,
                  height: 150,
                ),
                AnimatedOpacity(
                  opacity: animateName ? 0.8 : 0,
                  duration: const Duration(milliseconds: 1200),
                  child: const Text(
                    AppStrings.appName,
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: AppFonts.englishFont1,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
