import 'package:e_commerce_app/features/home/controller/main_cubit.dart';
import 'package:e_commerce_app/features/home/controller/main_status.dart';
import 'package:e_commerce_app/features/home/view/widgets/product_card.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/constants/images_assets.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:e_commerce_app/global/widgets/app_circular_progress_indicator.dart';
import 'package:e_commerce_app/global/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const String route = 'mainScreen';
  @override
  Widget build(BuildContext context) {
    var cubit = MainCubit.get(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => cubit.fetchProducts(),
          color: (CommonFunctions.isLightMode(context))
              ? AppColors.primaryColor
              : Colors.white,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 25,
                      left: 25,
                    ),
                    child: Text(
                      'Products',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BlocBuilder<MainCubit, MainStates>(
                      builder: (context, state) {
                    if (state is ProductsLoadingState) {
                      return SizedBox(
                        width: size.width,
                        height: size.height - 150,
                        child: const Center(
                          child: AppCircularProgressIndicator(
                            height: 100,
                            width: 100,
                          ),
                        ),
                      );
                    } else if (state is ProductsErrorState) {
                      return CommonFunctions.internetError;
                    } else if (state is NoProductsState) {
                      return const ErrorPage(
                        imageAsset: AppImagesAssets.emptyImageAsset,
                        message: AppStrings.noNewProductsText,
                      );
                    }
                    return GridView.count(
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
