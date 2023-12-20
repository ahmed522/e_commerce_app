import 'package:e_commerce_app/features/profile/controller/profile_cubit.dart';
import 'package:e_commerce_app/features/profile/controller/profile_states.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/constants/numbers.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:e_commerce_app/global/widgets/alert_dialog.dart';
import 'package:e_commerce_app/global/widgets/card_text_field.dart';
import 'package:e_commerce_app/global/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDataDialog extends StatelessWidget {
  const EditDataDialog({
    super.key,
    this.name,
    this.phone,
    this.email,
  });
  final String? name;
  final String? phone;
  final String? email;
  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      scrollable: true,
      title: Text(
        (name != null)
            ? AppStrings.updateUserNameAlertDialogTitle
            : (phone != null)
                ? AppStrings.updateUserPhoneAlertDialogTitle
                : AppStrings.updateUserEmailAlertDialogTitle,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: (CommonFunctions.isLightMode(context))
              ? AppColors.darkThemeBackgroundColor
              : Colors.white,
        ),
      ),
      content: BlocBuilder<ProfileCubit, ProfileStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CardTextField(
              keyboardType: (name != null)
                  ? TextInputType.name
                  : (phone != null)
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
              hintText: name ?? phone ?? email,
              maxLength: (phone != null) ? AppNumbers.phoneNumberLength : null,
              onChanged: (value) {
                if (name != null) {
                  cubit.tempName = value;
                  cubit.tempPhone = null;
                  cubit.tempEmail = null;
                } else if (phone != null) {
                  cubit.tempPhone = value;
                  cubit.tempName = null;
                  cubit.tempEmail = null;
                } else {
                  cubit.tempEmail = value;
                  cubit.tempName = null;
                  cubit.tempPhone = null;
                }
              },
            ),
          );
        },
      ),
      actionsAlignment: MainAxisAlignment.end,
      actionsPadding: const EdgeInsets.only(right: 30, bottom: 30),
      actions: AppAlertDialog.getAlertDialogActions({
        'Update': () {
          bool isDataValid;
          if (name != null) {
            isDataValid =
                cubit.tempName != null && cubit.tempName!.trim() != '';
          } else if (phone != null) {
            isDataValid = cubit.tempPhone != null &&
                RegExp(AppStrings.numberValidationRegExp)
                    .hasMatch(cubit.tempPhone!) &&
                cubit.tempPhone!.trim().length == AppNumbers.phoneNumberLength;
          } else {
            isDataValid = cubit.tempEmail != null &&
                cubit.tempEmail!.trim() != '' &&
                RegExp(AppStrings.emailValidationRegExp)
                    .hasMatch(cubit.tempEmail!);
          }
          Navigator.pop(context);
          if (isDataValid) {
            cubit.updateUserData();
          } else {
            AppSnackBar.showSnackBar(
              context,
              AppStrings.wrongDataPrompt,
              Colors.red,
            );
          }
        },
        'back': () {
          Navigator.pop(context);
        },
      }),
    );
  }
}
