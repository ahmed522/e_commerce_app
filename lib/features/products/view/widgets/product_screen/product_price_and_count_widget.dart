import 'package:e_commerce_app/features/products/controller/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/features/products/controller/product_cubit/product_status.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:e_commerce_app/global/widgets/app_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPriceAndCountWidget extends StatelessWidget {
  const ProductPriceAndCountWidget({
    Key? key,
    required this.price,
    required this.count,
  }) : super(key: key);

  final double price;
  final int count;

  @override
  Widget build(BuildContext context) {
    final cubit = ProductCubit.get(context);
    return Row(
      mainAxisAlignment: (count > 0)
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$price \$',
              style: const TextStyle(fontSize: 25),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 0.3,
                    blurRadius: 1,
                    offset: Offset(0, 0.3),
                  ),
                ],
                color: (count == 0) ? Colors.red : AppColors.mediumColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  'Available $count',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (count > 0)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 5,
                ),
                decoration: BoxDecoration(
                  color: (CommonFunctions.isLightMode(context))
                      ? Colors.white
                      : AppColors.darkThemeBottomNavBarColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 0.2,
                      blurRadius: 0.7,
                      offset: Offset(0, 0.2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: BlocBuilder<ProductCubit, ProductStates>(
                      builder: (context, state) {
                    return AppDropdownButton(
                      items: List.generate(
                        count,
                        (index) => (index + 1).toString(),
                      ),
                      onChanged: (item) =>
                          cubit.updateOrderQuantity(int.parse(item!)),
                      value: cubit.quantity.toString(),
                    );
                  }),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
