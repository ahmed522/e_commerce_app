import 'package:e_commerce_app/features/start/controller/onboarding_cubit.dart';
import 'package:e_commerce_app/features/start/controller/onboarding_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/onboarding_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static const String route = 'onboardingScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingCubit, OnboardingStates>(
        builder: (context, state) {
          return OnboardingWidget(state: state);
        },
      ),
    );
  }
}
