import 'package:e_commerce_app/features/authentication/controller/signin_cubit/signin_cubit.dart';
import 'package:e_commerce_app/features/authentication/controller/signin_cubit/signin_states.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/email_text_field.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/password_text_field.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/register_button.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/sign_button.dart';
import 'package:e_commerce_app/global/constants/images_assets.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});
  static const String route = 'signinScreen';
  @override
  Widget build(BuildContext context) {
    var cubit = SigninCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    left: 20,
                  ),
                  child: Text(
                    AppStrings.signinScreenTitleText,
                    style: TextStyle(fontSize: 35),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              SvgPicture.asset(
                AppImagesAssets.signinScreenImageAsset,
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 60),
              EmailTextField(
                onChanged: (value) => cubit.updateUserEmail(value),
              ),
              const SizedBox(height: 20),
              PasswordTextField(
                onChanged: (value) => cubit.updateUserPassword(value),
              ),
              const SizedBox(height: 10),
              BlocBuilder<SigninCubit, SigninStates>(builder: (context, state) {
                return SignButton(
                  loading: (state is SigninLoadingState),
                  onPressed: () => cubit.signinUser(context),
                  text: 'Sign in',
                );
              }),
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Row(
                  children: [
                    Text(
                      AppStrings.registerIfDontHaveAccount,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const RegisterButton()
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
