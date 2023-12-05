import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:flutter/material.dart';

class OnboardingSinglePageIndicator extends StatelessWidget {
  const OnboardingSinglePageIndicator({
    Key? key,
    required this.index,
    required this.currentPage,
  }) : super(key: key);

  final int index;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          border: Border.all(
            color: CommonFunctions.isLightMode(context)
                ? AppColors.primaryColor
                : AppColors.lightColor1,
          ),
          shape: BoxShape.circle,
          color: currentPage == index
              ? CommonFunctions.isLightMode(context)
                  ? AppColors.primaryColor
                  : AppColors.lightColor1
              : Colors.transparent,
        ),
      ),
    );
  }
}
