import 'package:e_commerce_app/features/authentication/controller/signin_cubit/signin_states.dart';
import 'package:e_commerce_app/features/authentication/model/user_model.dart';
import 'package:e_commerce_app/features/home/controller/main_cubit.dart';
import 'package:e_commerce_app/features/home/view/screens/main_screen.dart';
import 'package:e_commerce_app/global/constants/api_constants.dart';
import 'package:e_commerce_app/global/constants/numbers.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:e_commerce_app/global/services/cache_helper.dart';
import 'package:e_commerce_app/global/services/dio_helper.dart';
import 'package:e_commerce_app/global/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninCubit extends Cubit<SigninStates> {
  SigninCubit() : super(SigninInitState());
  static SigninCubit get(context) => BlocProvider.of(context);
  String? userEmail;
  String? userPassword;
  UserModel? userModel;
  updateUserEmail(String email) {
    userEmail = email.trim();
  }

  updateUserPassword(String password) {
    userPassword = password.trim();
  }

  signinUser(BuildContext context) {
    if (_validateData) {
      emit(SigninLoadingState());
      Map<String, dynamic> data = {
        'email': userEmail,
        'password': userPassword,
      };
      DioHelper.postData(url: ApiConstants.signinApiUrl, data: data).then(
        (value) {
          Map<String, dynamic> userData = value.data;

          if (userData['status'] == 'error') {
            AppSnackBar.showSnackBar(
              context,
              AppStrings.errorWidgetText,
              Colors.red,
            );
            emit(SigninErrorState());
          } else {
            userModel = UserModel.fromJson(userData);
            userData.forEach(
              (key, value) async {
                if (key == 'user') {
                  value.forEach(
                    (key1, value1) async {
                      await CacheHelper.saveData(key: key1, value: value1);
                    },
                  );
                } else {
                  await CacheHelper.saveData(key: key, value: value);
                }
              },
            );
            emit(SigninDoneState());
            AppSnackBar.showSnackBar(
              context,
              AppStrings.successfullySigninPrompt,
              Colors.green,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<MainCubit>(
                  create: (context) =>
                      MainCubit(userModel!.user)..fetchProducts(),
                  child: const MainScreen(),
                ),
              ),
              (route) => false,
            );
          }
        },
      ).catchError(
        (error) {
          AppSnackBar.showSnackBar(
            context,
            AppStrings.errorWidgetText,
            Colors.red,
          );
          emit(SigninErrorState());
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

  bool get _validateData {
    bool isEmailValid = userEmail != null &&
        userEmail!.trim() != '' &&
        RegExp(AppStrings.emailValidationRegExp).hasMatch(userEmail!);
    bool isPasswordValid = userPassword != null &&
        userPassword!.trim().length >= AppNumbers.passwordMinimumLength;
    return (isEmailValid && isPasswordValid);
  }
}
