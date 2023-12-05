import 'dart:io';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/widgets/app_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class PersonalImageSetter extends StatelessWidget {
  final String? imagePath;
  final void Function() onAddImagePressed;
  final bool loading;
  const PersonalImageSetter({
    Key? key,
    required this.imagePath,
    required this.onAddImagePressed,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
            width: 3,
          ),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          backgroundColor: AppColors.secondryColor,
          backgroundImage:
              (imagePath != null) ? FileImage(File(imagePath!)) : null,
          radius: 60,
        ),
      ),
      if (loading) const AppCircularProgressIndicator(width: 128, height: 128),
      Positioned(
        right: 0,
        bottom: 0,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: IconButton(
              padding: const EdgeInsets.all(0),
              iconSize: 25,
              onPressed: loading ? null : () => onAddImagePressed(),
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ),
    ]);
  }
}
