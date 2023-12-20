import 'package:e_commerce_app/features/products/view/widgets/all_products_screen/product_state_widget.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:e_commerce_app/global/widgets/screen_title.dart';
import 'package:flutter/material.dart';

class ProductScreenAppBar extends StatelessWidget {
  const ProductScreenAppBar({
    Key? key,
    required this.productName,
    required this.productCompany,
    required this.productStatus,
  }) : super(key: key);

  final String productName;
  final String productCompany;
  final String productStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_circle_left_rounded,
            size: 30,
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenTitle(
                  title: productName,
                  leftPadding: 10,
                  bottomPadding: 0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    productCompany,
                    style: TextStyle(
                      fontSize: 15,
                      color: CommonFunctions.isLightMode(context)
                          ? Colors.black38
                          : Colors.white38,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 5.0),
            ProductStateWidget(
              status: productStatus,
              fontSize: 17,
              bottomLeftRadius: 0,
              topLeftRadius: 10,
              topRightRadius: 5,
              bottomRightRadius: 5,
              rightPadding: 4.0,
              topPadding: 2.0,
              bottomPadding: 1.0,
              leftPadding: 5.0,
            ),
          ],
        ),
      ],
    );
  }
}
