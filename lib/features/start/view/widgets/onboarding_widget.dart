import 'package:e_commerce_app/features/start/controller/onboarding_cubit.dart';
import 'package:e_commerce_app/features/start/controller/onboarding_states.dart';
import 'package:e_commerce_app/features/start/model/onboarding_model.dart';
import 'package:e_commerce_app/features/start/view/widgets/onboarding_single_item.dart';
import 'package:e_commerce_app/global/widgets/choice_indicator.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/constants/images_assets.dart';
import 'package:e_commerce_app/global/constants/numbers.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  final OnboardingStates state;
  const OnboardingWidget({super.key, required this.state});
  @override
  Widget build(BuildContext context) {
    List<OnboardingSingleItem> onboardingItems = [
      OnboardingSingleItem(
        OnboardingModel(
          text: AppStrings.firstOnboardingItem,
          imageAsset: AppImagesAssets.firstOnboardingItemImageAsset,
        ),
      ),
      OnboardingSingleItem(
        OnboardingModel(
          text: AppStrings.secondOnboardingItem,
          imageAsset: AppImagesAssets.secondOnboardingItemImageAsset,
        ),
      ),
      OnboardingSingleItem(
        OnboardingModel(
          text: AppStrings.thirdOnboardingItem,
          imageAsset: AppImagesAssets.thirdOnboardingItemImageAsset,
        ),
      ),
    ];
    var cubit = OnboardingCubit.get(context);
    var pageController = PageController();
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemBuilder: (context, index) => onboardingItems[index],
            itemCount: onboardingItems.length,
            onPageChanged: (value) => cubit.updatePageState(value),
          ),
          if (state is OnboardingLastPageState)
            Positioned(
              right: 10,
              top: 40,
              child: TextButton(
                onPressed: () => cubit.startApp(context),
                child: Text(
                  'start shopping',
                  style: TextStyle(
                    color: CommonFunctions.isLightMode(context)
                        ? AppColors.primaryColor
                        : AppColors.lightColor1,
                  ),
                ),
              ),
            ),
          Positioned(
            right: -AppNumbers.onboardingOuterCircleDiameter / 4,
            bottom: -AppNumbers.onboardingOuterCircleDiameter / 4,
            child: Container(
              height: AppNumbers.onboardingOuterCircleDiameter,
              width: AppNumbers.onboardingOuterCircleDiameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor.withOpacity(0.6),
              ),
            ),
          ),
          Positioned(
            right: AppNumbers.onboardingOuterCircleDiameter -
                AppNumbers.onboardingOuterCircleDiameter / 2,
            bottom: -AppNumbers.onboardingInnerCircleDiameter / 2,
            child: Container(
              height: AppNumbers.onboardingInnerCircleDiameter,
              width: AppNumbers.onboardingInnerCircleDiameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mediumColor.withOpacity(0.7),
              ),
            ),
          ),
          /*------------page indicator---------------*/
          Positioned(
            left: 25,
            bottom: 15,
            child: ChoiceIndicator(
              items: onboardingItems.length,
              currentChoice: cubit.currentPage,
            ),
          )
          /*-----------------------------------------*/
        ],
      ),
    );
  }
}
