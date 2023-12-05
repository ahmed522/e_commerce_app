import 'package:e_commerce_app/features/start/controller/onboarding_states.dart';
import 'package:e_commerce_app/features/authentication/view/screens/signin_screen.dart';
import 'package:e_commerce_app/global/services/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingStates> {
  OnboardingCubit() : super(OnboardingInitState());
  static OnboardingCubit get(context) => BlocProvider.of(context);
  int currentPage = 0;
  void updatePageState(int index) {
    currentPage = index;
    switch (index) {
      case 0:
        emit(OnboardingInitState());
        return;
      case 1:
        emit(OnboardingSecondPageState());
        return;
      case 2:
        emit(OnboardingLastPageState());
        return;
    }
  }

  void startApp(BuildContext context) {
    CacheHelper.saveData(key: 'firstTime', value: false);
    Navigator.pushNamedAndRemoveUntil(
        context, SigninScreen.route, (route) => false);
  }
}
