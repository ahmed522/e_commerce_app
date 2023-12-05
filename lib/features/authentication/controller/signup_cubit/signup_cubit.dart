import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/features/authentication/controller/signup_cubit/signup_states.dart';
import 'package:e_commerce_app/features/authentication/model/gender.dart';
import 'package:e_commerce_app/features/authentication/model/user_model.dart';
import 'package:e_commerce_app/features/authentication/view/widgets/image_source_page.dart';
import 'package:e_commerce_app/global/constants/numbers.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:e_commerce_app/global/services/dio_helper.dart';
import 'package:e_commerce_app/global/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitState());
  static SignupCubit get(context) => BlocProvider.of(context);
  XFile? userImageFile;
  UserModel userModel = UserModel();
  String? userPassword;

  uploadImage(BuildContext context) {
    showModalBottomSheet<dynamic>(
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(35))),
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Wrap(
          children: [
            ImageSourcePage(
              onPressed: (image) {
                if (image != null) {
                  _updateUserImage(image);
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  _updateUserImage(XFile imageFile) {
    userImageFile = imageFile;
    userModel.user.profileImage =
        base64Encode(File(userImageFile!.path).readAsBytesSync());
    emit(SignupInitState());
  }

  updateUserGender(Gender gender) {
    userModel.user.gender = gender.name;
    emit(SignupInitState());
  }

  updateUserName(String name) {
    userModel.user.name = name.trim();
  }

  updateUserPhoneNumber(String phoneNumber) {
    userModel.user.phone = phoneNumber.trim();
  }

  updateUserNationalId(String nationalId) {
    userModel.user.nationalId = nationalId.trim();
  }

  updateUserEmail(String email) {
    userModel.user.email = email.trim();
  }

  updateUserPassword(String password) {
    userPassword = password.trim();
  }

  signUpUser(BuildContext context) {
    if (_validateUserData) {
      emit(SignupLoadingState());
      Map<String, dynamic> data = userModel.user.toJson();
      data['password'] = userPassword;
      DioHelper.postData(url: AppStrings.signupApiUrl, data: data).then(
        (value) {
          emit(SignupDoneState());
          Navigator.pop(context);
          AppSnackBar.showSnackBar(
            context,
            AppStrings.successfullySignupPrompt,
            Colors.green,
          );
        },
      ).catchError(
        (error) {
          AppSnackBar.showSnackBar(
            context,
            AppStrings.errorWidgetText,
            Colors.red,
          );
          emit(SignupErrorState());
        },
      );
    } else {
      AppSnackBar.showSnackBar(
        context,
        AppStrings.wrongDataPrompt,
        Colors.red,
      );
    }
  }

  bool get _validateUserData {
    bool isNameValid =
        userModel.user.name != null && userModel.user.name!.trim() != '';
    bool isPhoneNumberValid = userModel.user.phone != null &&
        RegExp(AppStrings.numberValidationRegExp)
            .hasMatch(userModel.user.phone!) &&
        userModel.user.phone!.trim().length == AppNumbers.phoneNumberLength;
    bool isNationalIdValid = userModel.user.nationalId != null &&
        RegExp(AppStrings.numberValidationRegExp)
            .hasMatch(userModel.user.nationalId!) &&
        userModel.user.nationalId!.trim().length == AppNumbers.nationalIdLength;
    bool isEmailValid = userModel.user.email != null &&
        userModel.user.email!.trim() != '' &&
        RegExp(AppStrings.emailValidationRegExp)
            .hasMatch(userModel.user.email!);
    bool isPasswordValid = userPassword != null &&
        userPassword!.trim().length >= AppNumbers.passwordMinimumLength;
    bool isImageValid = userModel.user.profileImage != null;

    return (isNameValid &&
        isPhoneNumberValid &&
        isNationalIdValid &&
        isEmailValid &&
        isPasswordValid &&
        isImageValid);
  }
}
