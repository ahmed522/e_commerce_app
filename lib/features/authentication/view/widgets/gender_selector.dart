import 'package:e_commerce_app/features/authentication/model/gender.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/widgets/circular_icon_button.dart';
import 'package:flutter/material.dart';

class GenderSelectorWidget extends StatelessWidget {
  final void Function(Gender gender) selectGender;
  final Gender selectedGender;
  const GenderSelectorWidget({
    super.key,
    required this.selectedGender,
    required this.selectGender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 8.0, left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircularIconButton(
            onPressed: () => selectGender(Gender.male),
            activeColor: AppColors.primaryColor,
            selected: (selectedGender == Gender.male),
            child: const Icon(
              Icons.man,
            ),
          ),
          CircularIconButton(
            onPressed: () => selectGender(Gender.female),
            activeColor: AppColors.primaryColor,
            selected: (selectedGender == Gender.female),
            child: const Icon(
              Icons.woman,
            ),
          ),
        ],
      ),
    );
  }
}
