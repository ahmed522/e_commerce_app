import 'package:e_commerce_app/features/start/model/onboarding_model.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingSingleItem extends StatelessWidget {
  final OnboardingModel model;
  const OnboardingSingleItem(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(model.imageAsset, height: 200, width: 200),
          const SizedBox(height: 35),
          Text(
            model.text,
            style: TextStyle(
              fontSize: 35.0,
              color: CommonFunctions.isLightMode(context)
                  ? AppColors.mediumColor.withOpacity(0.6)
                  : AppColors.lightColor2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
