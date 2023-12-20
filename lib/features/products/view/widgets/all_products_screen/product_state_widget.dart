import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:flutter/material.dart';

class ProductStateWidget extends StatelessWidget {
  const ProductStateWidget({
    Key? key,
    required this.fontSize,
    required this.status,
    required this.topRightRadius,
    required this.topLeftRadius,
    required this.bottomRightRadius,
    required this.bottomLeftRadius,
    required this.topPadding,
    required this.leftPadding,
    required this.bottomPadding,
    required this.rightPadding,
  }) : super(key: key);

  final double fontSize;
  final String status;
  final double topRightRadius;
  final double topLeftRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;
  final double topPadding;
  final double leftPadding;
  final double bottomPadding;
  final double rightPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius),
          topRight: Radius.circular(topRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
          bottomRight: Radius.circular(bottomRightRadius),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.secondryColor,
            spreadRadius: 0.3,
            blurRadius: 1,
            offset: Offset(0, 0.3),
          ),
        ],
        color: AppColors.secondryColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: rightPadding,
          top: topPadding,
          bottom: bottomPadding,
          left: leftPadding,
        ),
        child: Text(
          status,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
