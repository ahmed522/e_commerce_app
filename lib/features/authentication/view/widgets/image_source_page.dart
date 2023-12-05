import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourcePage extends StatelessWidget {
  const ImageSourcePage({super.key, this.onPressed});
  final void Function(XFile? image)? onPressed;
  @override
  Widget build(BuildContext context) {
    XFile? userImage;
    return Padding(
      padding: const EdgeInsets.only(
        top: 40,
        bottom: 50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(
                Icons.camera_alt_rounded,
                size: 50,
                color: (CommonFunctions.isLightMode(context))
                    ? AppColors.primaryColor
                    : Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  userImage = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                    imageQuality: 50,
                    preferredCameraDevice: CameraDevice.rear,
                  );
                  onPressed!(userImage);
                },
                child: const Text(
                  'camera',
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.image,
                size: 50,
                color: (CommonFunctions.isLightMode(context))
                    ? AppColors.primaryColor
                    : Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  userImage = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                  );
                  onPressed!(userImage);
                },
                child: const Text(
                  'gallary',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
