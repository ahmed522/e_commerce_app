import 'package:e_commerce_app/features/products/controller/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/features/products/controller/product_cubit/product_status.dart';
import 'package:e_commerce_app/features/products/view/widgets/product_screen/add_to_cart_button.dart';
import 'package:e_commerce_app/features/products/view/widgets/product_screen/add_to_fav_button.dart';
import 'package:e_commerce_app/features/products/view/widgets/product_screen/discount_widget.dart';
import 'package:e_commerce_app/features/products/view/widgets/product_screen/product_price_and_count_widget.dart';
import 'package:e_commerce_app/features/products/view/widgets/product_screen/product_screen_app_bar.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:e_commerce_app/global/widgets/app_circular_progress_indicator.dart';
import 'package:e_commerce_app/global/widgets/choice_indicator.dart';
import 'package:e_commerce_app/global/widgets/default_cashed_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  static const String route = 'productScreen';
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = ProductCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (CommonFunctions.isLightMode(context))
            ? Colors.white
            : AppColors.darkThemeBackgroundColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProductScreenAppBar(
                productName: cubit.product.name!,
                productCompany: cubit.product.company!,
                productStatus: cubit.product.status!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: BlocBuilder<ProductCubit, ProductStates>(
                  builder: (context, state) {
                    if (state is ProductErrorState) {
                      return CommonFunctions.internetError;
                    } else if (state is ProductLoadingState) {
                      return SizedBox(
                        width: size.width,
                        height: size.height - 100,
                        child: const Center(
                          child: AppCircularProgressIndicator(
                            height: 100,
                            width: 100,
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        Stack(
                          children: [
                            SizedBox(
                              height: 150,
                              child: PageView.builder(
                                itemCount: cubit.product.images.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DefaultCashedImage(
                                    height: 150,
                                    width: size.width - 30,
                                    imageUrl: cubit.product.images[index],
                                    loadingIndicatorSize: 50,
                                  ),
                                ),
                                onPageChanged: (index) =>
                                    cubit.updateImageState(index),
                              ),
                            ),
                            if (cubit.product.status == 'New')
                              const Positioned(
                                right: 25,
                                top: 20,
                                child: DiscountWidget(
                                  discount: 10,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        ChoiceIndicator(
                          items: cubit.product.images.length,
                          currentChoice: cubit.currentImage,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ProductPriceAndCountWidget(
                            price: cubit.product.price / 1,
                            count: cubit.product.countInStock,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            cubit.product.description!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 100),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AddToFavButton(
                                isFav: cubit.isFav,
                                onPressed: (state is LoadingFavouritesState)
                                    ? () {}
                                    : () => cubit.updateIsFav(),
                              ),
                              if (cubit.product.countInStock > 0)
                                const SizedBox(width: 5.0),
                              if (cubit.product.countInStock > 0)
                                AddToCartButton(
                                  onPressed: () {
                                    if (state is! ProductLoadingState) {
                                      cubit.addToCart(context);
                                    }
                                  },
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
