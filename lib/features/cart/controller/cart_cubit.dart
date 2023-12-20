import 'package:e_commerce_app/features/cart/controller/cart_status.dart';
import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:e_commerce_app/global/constants/api_constants.dart';
import 'package:e_commerce_app/global/services/cache_helper.dart';
import 'package:e_commerce_app/global/services/dio_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitState());
  static CartCubit get(context) => BlocProvider.of(context);
  CartModel cart = CartModel();
  int? tempQuantity;
  Future<void> fetchCartProducts() async {
    if (!isClosed) {
      emit(CartLoadingState());
    }
    String? nationalId = await CacheHelper.getData(key: 'nationalId');
    DioHelper.getData(
      url: ApiConstants.getCartProductsApiUrl,
      data: {
        'nationalId': nationalId,
      },
    ).then((value) {
      if (value.data['status'] == 'error') {
        if (!isClosed) {
          emit(CartErrorState());
        }
      } else {
        if (value.data['products'] == null || value.data['products'].isEmpty) {
          if (!isClosed) {
            emit(CartNoProductsState());
          }
        } else {
          if (!isClosed) {
            cart = CartModel.fromJson(value.data);
            emit(CartInitState());
          }
        }
      }
    }).catchError(
      (error) {
        if (!isClosed) {
          emit(CartErrorState());
        }
      },
    );
  }

  Future<void> updateCartProduct(String productId) async {
    if (!isClosed) {
      emit(CartLoadingState());
    }
    String? nationalId = await CacheHelper.getData(key: 'nationalId');
    DioHelper.putData(
      url: ApiConstants.updateCartApiUrl,
      data: {
        'nationalId': nationalId,
        'productId': productId,
        'quantity': tempQuantity,
      },
    ).then((value) {
      if (value.data['status'] == 'error') {
        if (!isClosed) {
          emit(CartErrorState());
        }
      } else {
        if (!isClosed) {
          emit(CartInitState());
        }
        fetchCartProducts();
      }
    }).catchError(
      (error) {
        if (!isClosed) {
          emit(CartErrorState());
        }
      },
    );
  }

  Future<void> deleteCartProduct(String productId) async {
    if (!isClosed) {
      emit(CartLoadingState());
    }
    String? nationalId = await CacheHelper.getData(key: 'nationalId');
    DioHelper.delData(
      url: ApiConstants.deleteCartProductsApiUrl,
      data: {
        'nationalId': nationalId,
        'productId': productId,
      },
    ).then((value) {
      if (value.data['status'] == 'error') {
        if (!isClosed) {
          emit(CartErrorState());
        }
      } else {
        if (!isClosed) {
          emit(CartInitState());
        }
        fetchCartProducts();
      }
    }).catchError(
      (error) {
        if (!isClosed) {
          emit(CartErrorState());
        }
      },
    );
  }

  updateTempQuantity(int quan) {
    tempQuantity = quan;
    if (!isClosed) {
      emit(CartInitState());
    }
  }

  increaseTempQuantity(int max) {
    if (tempQuantity! < max) {
      tempQuantity = tempQuantity! + 1;
    }
    if (!isClosed) {
      emit(CartInitState());
    }
  }

  decreaseTempQuantity() {
    if (tempQuantity! > 1) {
      tempQuantity = tempQuantity! - 1;
    }
    if (!isClosed) {
      emit(CartInitState());
    }
  }
}
