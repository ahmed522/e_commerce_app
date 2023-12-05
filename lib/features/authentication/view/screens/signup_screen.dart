import 'package:e_commerce_app/features/authentication/controller/signup_cubit/signup_cubit.dart';
import 'package:e_commerce_app/features/authentication/controller/signup_cubit/signup_states.dart';
import 'package:e_commerce_app/features/authentication/model/gender.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/email_text_field.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/gender_selector.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/national_id_text_field.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/password_text_field.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/personal_image_setter.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/phone_number_text_field.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/sign_button.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/name_text_field.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:e_commerce_app/global/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  static const String route = 'signupScreen';
  @override
  Widget build(BuildContext context) {
    var cubit = SignupCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 20,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_circle_left_rounded,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      AppStrings.signupScreenTitleText,
                      style: TextStyle(fontSize: 35),
                    ),
                    AppAlertDialog.getInfoAlertDialog(
                      context,
                      AppStrings.userDataInfoDialogTitle,
                      AppStrings.userDataInfoDialogContent,
                      {
                        'understood': () => Navigator.pop(context),
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              BlocBuilder<SignupCubit, SignupStates>(
                builder: (context, state) {
                  return PersonalImageSetter(
                    loading: (state is SignupLoadingState),
                    onAddImagePressed: () => cubit.uploadImage(context),
                    imagePath: (cubit.userImageFile != null)
                        ? cubit.userImageFile!.path
                        : null,
                  );
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<SignupCubit, SignupStates>(
                builder: (context, state) {
                  return GenderSelectorWidget(
                    selectedGender: parseGender(cubit.userModel.user.gender),
                    selectGender: (state is SignupLoadingState)
                        ? (gender) {}
                        : ((gender) => cubit.updateUserGender(gender)),
                  );
                },
              ),
              const SizedBox(height: 30),
              NameTextField(
                onChanged: (value) => cubit.updateUserName(value),
              ),
              const SizedBox(height: 20),
              PhoneNumberTextField(
                onChanged: (value) => cubit.updateUserPhoneNumber(value),
              ),
              const SizedBox(height: 20),
              NationalIdTextField(
                onChanged: (value) => cubit.updateUserNationalId(value),
              ),
              const SizedBox(height: 20),
              EmailTextField(
                onChanged: (value) => cubit.updateUserEmail(value),
              ),
              const SizedBox(height: 20),
              PasswordTextField(
                onChanged: (value) => cubit.updateUserPassword(value),
              ),
              const SizedBox(height: 10),
              BlocBuilder<SignupCubit, SignupStates>(
                builder: (context, state) {
                  return SignButton(
                    loading: (state is SignupLoadingState),
                    onPressed: () => cubit.signUpUser(context),
                    text: 'Sign up',
                  );
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Gender parseGender(String name) {
    if (name == 'male') {
      return Gender.male;
    } else {
      return Gender.female;
    }
  }
}
