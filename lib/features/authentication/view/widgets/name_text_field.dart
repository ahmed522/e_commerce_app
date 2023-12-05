import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:e_commerce_app/global/widgets/card_text_field.dart';
import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  final void Function(String value) onChanged;

  const NameTextField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: CardTextField(
        keyboardType: TextInputType.name,
        hintText: 'Enter your name',
        icon: Icons.person,
        iconColor: CommonFunctions.isLightMode(context)
            ? AppColors.primaryColor
            : AppColors.lightColor1,
        onChanged: ((value) => onChanged(value)),
      ),
    );
  }
}
