import 'package:e_commerce_app/global/widgets/app_outlined_button.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final void Function() onPressed;
  const AddToCartButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppOutlinedButton(
      text: 'Add to cart',
      icon: Icons.shopping_cart_checkout_sharp,
      onPressed: onPressed,
    );
  }
}
