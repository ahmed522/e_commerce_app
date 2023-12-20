import 'package:e_commerce_app/features/products/controller/all_products_cubit/all_products_cubit.dart';
import 'package:e_commerce_app/features/products/controller/all_products_cubit/all_products_states.dart';
import 'package:e_commerce_app/features/products/view/widgets/all_products_screen/product_card.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/constants/images_assets.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:e_commerce_app/global/widgets/app_circular_progress_indicator.dart';
import 'package:e_commerce_app/global/widgets/error_page.dart';
import 'package:e_commerce_app/global/widgets/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});
  static const String route = 'allProductsScreen';
  @override
  Widget build(BuildContext context) {
    var cubit = AllProductsCubit.get(context);
    var size = MediaQuery.of(context).size;
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
          onRefresh: () => cubit.fetchAllProducts(),
          color: (CommonFunctions.isLightMode(context))
              ? AppColors.primaryColor
              : Colors.white,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const ScreenTitle(title: 'Products'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BlocBuilder<AllProductsCubit, AllProductsStates>(
                      builder: (context, state) {
                    if (state is AllProductsLoadingState) {
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
                    } else if (state is AllProductsErrorState) {
                      return CommonFunctions.internetError;
                    } else if (state is NoProductsState) {
                      return const ErrorPage(
                        imageAsset: AppImagesAssets.emptyImageAsset,
                        message: AppStrings.noNewProductsText,
                      );
                    }
                    return GridView.count(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      childAspectRatio: 1 / 1.32,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 5.0,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List<ProductCard>.generate(
                        cubit.laptops.product.length,
                        (index) => ProductCard(
                          product: cubit.laptops.product[index],
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
