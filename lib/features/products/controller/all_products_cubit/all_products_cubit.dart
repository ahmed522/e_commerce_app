import 'package:e_commerce_app/features/home/controller/main_cubit.dart';
import 'package:e_commerce_app/features/products/controller/all_products_cubit/all_products_states.dart';
import 'package:e_commerce_app/global/constants/api_constants.dart';
import 'package:e_commerce_app/global/services/dio_helper.dart';
import 'package:e_commerce_app/global/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/features/products/model/product_model.dart';

class AllProductsCubit extends Cubit<AllProductsStates> {
  AllProductsCubit() : super(AllProductsInitState());
  static AllProductsCubit get(context) => BlocProvider.of(context);
  LaptopsModel laptops = LaptopsModel();

  Future<void> fetchAllProducts() async {
    if (!isClosed) {
      emit(AllProductsLoadingState());
    }
    DioHelper.getData(url: ApiConstants.productsApiUrl).then((value) {
      if (value.data['status'] == 'error') {
        if (!isClosed) {
          emit(AllProductsErrorState());
        }
      } else {
        if (value.data == null) {
          if (!isClosed) {
            emit(NoProductsState());
          }
        } else {
          if (!isClosed) {
            laptops = LaptopsModel.fromJson(value.data);
            emit(AllProductsReadyState());
          }
        }
      }
    }).catchError(
      (error) {
        if (!isClosed) {
          emit(AllProductsErrorState());
        }
      },
    );
  }

  Future addToCart(BuildContext context, String productId,
      [int quantity = 1]) async {
    if (!isClosed) {
      emit(LoadingAddingToCartState());
    }
    String? nationalId = MainCubit.get(context).user.nationalId;
    DioHelper.postData(
      url: ApiConstants.addToCartApiUrl,
      data: {
        'nationalId': nationalId,
        'productId': productId,
        'quantity': quantity,
      },
    ).then((value) {
      if (value.data['status'] == 'error') {
        if (!isClosed) {
          emit(ErrorAddingToCartState());
        }
        AppSnackBar.showSnackBar(
            context, 'Error happened while adding to cart', Colors.red);
      } else {
        if (!isClosed) {
          emit(AllProductsReadyState());
        }
        AppSnackBar.showSnackBar(context,
            'Product has been added to cart successfully', Colors.green);
      }
    }).catchError(
      (error) {
        if (!isClosed) {
          emit(ErrorAddingToCartState());
        }
        AppSnackBar.showSnackBar(
            context, 'Error happened while adding to cart', Colors.red);
      },
    );
  }
}
