import 'package:e_commerce_app/features/authentication/view/screens/signup_screen.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, SignupScreen.route),
      child: Text(
        'Sign up',
        style: TextStyle(
          color: CommonFunctions.isLightMode(context)
              ? AppColors.secondryColor
              : AppColors.lightColor2,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
