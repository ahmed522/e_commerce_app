import 'package:e_commerce_app/features/cart/controller/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/controller/cart_status.dart';
import 'package:e_commerce_app/features/cart/view/widgets/cart_product_card.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/constants/images_assets.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:e_commerce_app/global/widgets/app_circular_progress_indicator.dart';
import 'package:e_commerce_app/global/widgets/app_outlined_button.dart';
import 'package:e_commerce_app/global/widgets/error_page.dart';
import 'package:e_commerce_app/global/widgets/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const String route = 'cartScreen';

  @override
  Widget build(BuildContext context) {
    final cubit = CartCubit.get(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (CommonFunctions.isLightMode(context))
            ? Colors.white
            : AppColors.darkThemeBackgroundColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => cubit.fetchCartProducts(),
          color: (CommonFunctions.isLightMode(context))
              ? AppColors.primaryColor
              : Colors.white,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const ScreenTitle(title: 'Cart'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BlocBuilder<CartCubit, CartStates>(
                    builder: (context, state) {
                      if (state is CartLoadingState) {
                        return SizedBox(
                          width: size.width,
                          height: size.height - 120,
                          child: const Center(
                            child: AppCircularProgressIndicator(
                              height: 100,
                              width: 100,
                            ),
                          ),
                        );
                      } else if (state is CartErrorState) {
                        return CommonFunctions.internetError;
                      } else if (state is CartNoProductsState) {
                        return const ErrorPage(
                          imageAsset: AppImagesAssets.emptyCartImageAsset,
                          message: AppStrings.cartIsEmptyText,
                        );
                      }
                      return Column(
                        children: [
                          ...List<CartProductCard>.generate(
                            cubit.cart.products.length,
                            (index) => CartProductCard(
                              cartProduct: cubit.cart.products[index],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Total = ${cubit.cart.totalCost.toStringAsFixed(2)} \$',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColors.secondryColor,
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black38,
                                        spreadRadius: 0.1,
                                        blurRadius: 0.7,
                                        offset: Offset(0, 0.1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AppOutlinedButton(
                                onPressed: () {},
                                text: 'Purchase',
                                fontSize: 15,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
