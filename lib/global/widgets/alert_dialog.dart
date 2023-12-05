import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../functions/common_functions.dart';

class AppAlertDialog {
  static void showAlertDialog(BuildContext context, String title,
          String? content, List<Widget> actions) =>
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            scrollable: true,
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: (CommonFunctions.isLightMode(context))
                    ? AppColors.darkThemeBackgroundColor
                    : Colors.white,
              ),
            ),
            content: (content != null)
                ? Center(
                    child: Text(
                      content,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
                : const SizedBox(),
            actionsAlignment: MainAxisAlignment.end,
            actionsPadding: const EdgeInsets.only(right: 30, bottom: 30),
            actions: actions,
          );
        },
      );
  static List<Widget> getAlertDialogActions(
      Map<String, void Function()?> textsAndOnPressed) {
    final List<Widget> actions = [];
    textsAndOnPressed.forEach((text, onPressed) {
      actions.add(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      );
    });
    return actions;
  }

  static IconButton getInfoAlertDialog(BuildContext context, String title,
          String content, Map<String, void Function()?> textsAndOnPressed) =>
      IconButton(
        onPressed: () {
          showAlertDialog(
            context,
            title,
            content,
            getAlertDialogActions(textsAndOnPressed),
          );
        },
        iconSize: 20,
        icon: const Icon(
          Icons.info_outlined,
        ),
      );
}
