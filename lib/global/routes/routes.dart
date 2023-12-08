import 'package:e_commerce_app/features/authentication/controller/signin_cubit/signin_cubit.dart';
import 'package:e_commerce_app/features/authentication/controller/signup_cubit/signup_cubit.dart';
import 'package:e_commerce_app/features/authentication/view/screens/signin_screen.dart';
import 'package:e_commerce_app/features/authentication/view/screens/signup_screen.dart';
import 'package:e_commerce_app/features/start/controller/onboarding_cubit.dart';
import 'package:e_commerce_app/features/start/view/screens/onboarding_screen.dart';
import 'package:e_commerce_app/features/start/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    SplashScreen.route: (context) => const SplashScreen(),
    OnboardingScreen.route: (context) => BlocProvider<OnboardingCubit>(
          create: (context) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
    SigninScreen.route: (context) => BlocProvider<SigninCubit>(
        create: (context) => SigninCubit(), child: const SigninScreen()),
    SignupScreen.route: (context) => BlocProvider<SignupCubit>(
        create: (context) => SignupCubit(), child: const SignupScreen()),
  };
}
