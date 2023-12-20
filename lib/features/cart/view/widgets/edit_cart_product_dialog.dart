import 'package:e_commerce_app/features/cart/controller/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/controller/cart_status.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/constants/strings.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:e_commerce_app/global/widgets/alert_dialog.dart';
import 'package:e_commerce_app/global/widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCartProductDialog extends StatelessWidget {
  const EditCartProductDialog(
      {super.key, required this.productId, required this.countInStock});
  final String productId;
  final int countInStock;
  @override
  Widget build(BuildContext context) {
    final cubit = CartCubit.get(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      scrollable: true,
      title: Text(
        AppStrings.updateCartProductAlertDialogTitle,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: (CommonFunctions.isLightMode(context))
              ? AppColors.darkThemeBackgroundColor
              : Colors.white,
        ),
      ),
      content: BlocBuilder<CartCubit, CartStates>(builder: (context, state) {
        return CounterWidget(
          count: cubit.tempQuantity!,
          increase: () => cubit.increaseTempQuantity(countInStock),
          decrease: () => cubit.decreaseTempQuantity(),
        );
      }),
      actionsAlignment: MainAxisAlignment.end,
      actionsPadding: const EdgeInsets.only(right: 30, bottom: 30),
      actions: AppAlertDialog.getAlertDialogActions({
        'Update': () {
          Navigator.pop(context);
          cubit.updateCartProduct(productId);
        },
      }),
    );
  }
}
