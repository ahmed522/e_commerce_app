import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/features/cart/controller/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/model/cart_product.dart';
import 'package:e_commerce_app/features/cart/view/widgets/edit_cart_product_dialog.dart';
import 'package:e_commerce_app/features/products/model/product_model.dart';
import 'package:e_commerce_app/features/products/view/screens/product_screen.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:e_commerce_app/global/widgets/alert_dialog.dart';
import 'package:e_commerce_app/global/widgets/app_circular_progress_indicator.dart';
import 'package:e_commerce_app/global/widgets/circle_button.dart';
import 'package:e_commerce_app/global/widgets/containered_text.dart';
import 'package:e_commerce_app/global/widgets/cropped_card_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({super.key, required this.cartProduct});
  final CartProduct cartProduct;
  @override
  Widget build(BuildContext context) {
    ProductModel product = cartProduct.product!;
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            ProductScreen.route,
            arguments: product,
          ),
          child: Card(
            margin: const EdgeInsets.all(2),
            color: CommonFunctions.isLightMode(context)
                ? Colors.white
                : AppColors.darkThemeBottomNavBarColor,
            elevation: 2.5,
            shape: CroppedCardBorder(
              borderRadius: const Radius.circular(10.0),
              holeSize1: 30.0,
              holeSize2: 17.0,
              offset1: Offset(size.width - 70, -20),
              offset2: Offset(size.width - 130, -14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CachedNetworkImage(
                          height: 100,
                          width: 100,
                          imageUrl: product.image!,
                          imageBuilder: (context, imageProvider) => Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Image(image: imageProvider),
                          ),
                          placeholder: (context, url) => const Center(
                            child: AppCircularProgressIndicator(
                              width: 30,
                              height: 30,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width - 230,
                              child: Text(
                                product.name!,
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                            Text(
                              product.company!,
                              style: TextStyle(
                                fontSize: 14,
                                color: CommonFunctions.isLightMode(context)
                                    ? Colors.black38
                                    : Colors.white38,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${(product.price!).toStringAsFixed(2)} \$',
                          style: const TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                    ContaineredText(
                      text: 'Ordered ${cartProduct.quantity}',
                      color: AppColors.mediumColor,
                      fontSize: 15,
                    ),
                    const SizedBox(height: 3.0),
                    ContaineredText(
                      text:
                          'Total = ${cartProduct.totalPrice.toStringAsFixed(2)} \$',
                      color: AppColors.secondryColor,
                      fontSize: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: size.width - 100,
          child: CircleButton(
            backgroundColor: Colors.red,
            onPressed: () => _deleteProduct(context),
            child: const Icon(Icons.delete_outline_rounded),
          ),
        ),
        Positioned(
          bottom: 4,
          left: size.width - 140,
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircleButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () => _editProduct(context),
              child: const Icon(Icons.edit_rounded, size: 16),
            ),
          ),
        )
      ],
    );
  }

  _editProduct(BuildContext currentContext) {
    final cubit = CartCubit.get(currentContext);
    cubit.updateTempQuantity(cartProduct.quantity);
    showDialog(
      context: currentContext,
      builder: (context) => BlocProvider<CartCubit>.value(
        value: BlocProvider.of<CartCubit>(currentContext),
        child: EditCartProductDialog(
          productId: cartProduct.product!.sId!,
          countInStock: cartProduct.product!.countInStock,
        ),
      ),
    );
  }

  _deleteProduct(BuildContext currentContext) {
    final cubit = CartCubit.get(currentContext);
    AppAlertDialog.showAlertDialog(
      currentContext,
      AppStrings.deleteCartProductAlertDialogTitle,
      AppStrings.deleteCartProductAlertDialogContent,
      AppAlertDialog.getAlertDialogActions(
        {
          'Remove': () {
            cubit.deleteCartProduct(cartProduct.product!.sId!);
            Navigator.pop(currentContext);
          },
          'Back': () => Navigator.pop(currentContext),
        },
      ),
    );
  }
}
