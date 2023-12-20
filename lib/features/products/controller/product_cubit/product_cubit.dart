import 'package:e_commerce_app/global/constants/api_constants.dart';
import 'package:e_commerce_app/global/services/cache_helper.dart';
import 'package:e_commerce_app/global/services/dio_helper.dart';
import 'package:e_commerce_app/global/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/features/products/controller/product_cubit/product_status.dart';
import 'package:e_commerce_app/features/products/model/product_model.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit(this.product) : super(ProductInitState());
  static ProductCubit get(context) => BlocProvider.of(context);
  int currentImage = 0;
  final ProductModel product;
  bool isFav = false;
  int quantity = 1;
  void updateIsFav() {
    if (isFav) {
      isFav = false;
      _removeFromFavourites();
    } else {
      isFav = true;
      _addToFavourites();
    }
  }

  void updateOrderQuantity(int items) {
    quantity = items;
    emit(ProductInitState());
  }

  void updateImageState(int index) {
    currentImage = index;
    emit(ProductInitState());
  }

  Future isFavourite() async {
    if (!isClosed) {
      emit(ProductLoadingState());
    }
    String? nationalId = await CacheHelper.getData(key: 'nationalId');
    DioHelper.getData(
      url: ApiConstants.favouritesApiUrl,
      data: {
        'nationalId': nationalId,
      },
    ).then((value) {
      if (value.data['status'] != 'success') {
        if (!isClosed) {
          emit(ProductErrorState());
        }
      } else {
        dynamic result = value.data['favoriteProducts'].firstWhere(
            (element) => (element['_id'] == product.sId),
            orElse: () => -1);
        if (result == -1) {
          isFav = false;
        } else {
          isFav = true;
        }
        if (!isClosed) {
          emit(ProductInitState());
        }
      }
    }).catchError(
      (error) {
        if (!isClosed) {
          emit(ProductErrorState());
        }
      },
    );
  }

  Future<void> _addToFavourites() async {
    if (!isClosed) {
      emit(LoadingFavouritesState());
    }
    String? nationalId = await CacheHelper.getData(key: 'nationalId');

    DioHelper.postData(url: ApiConstants.favouritesApiUrl, data: {
      'nationalId': nationalId,
      'productId': product.sId,
    }).then(
      (value) {
        if (value.data['status'] != 'success') {
          if (!isClosed) {
            emit(ProductErrorState());
          }
        } else {
          isFav = true;
          if (!isClosed) {
            emit(ProductInitState());
          }
        }
      },
    ).catchError(
      (error) {
        if (!isClosed) {
          emit(ProductErrorState());
        }
      },
    );
  }

  Future<void> _removeFromFavourites() async {
    if (!isClosed) {
      emit(LoadingFavouritesState());
    }
    String? nationalId = await CacheHelper.getData(key: 'nationalId');

    DioHelper.delData(url: ApiConstants.favouritesApiUrl, data: {
      'nationalId': nationalId,
      'productId': product.sId,
    }).then(
      (value) {
        if (value.data['status'] != 'success') {
          if (!isClosed) {
            emit(ProductErrorState());
          }
        } else {
          isFav = false;
          if (!isClosed) {
            emit(ProductInitState());
          }
        }
      },
    ).catchError(
      (error) {
        if (!isClosed) {
          emit(ProductErrorState());
        }
      },
    );
  }

  Future addToCart(BuildContext context) async {
    if (!isClosed) {
      emit(ProductLoadingState());
    }
    String? nationalId = await CacheHelper.getData(key: 'nationalId');
    DioHelper.postData(
      url: ApiConstants.addToCartApiUrl,
      data: {
        'nationalId': nationalId,
        'productId': product.sId,
        'quantity': quantity,
      },
    ).then((value) {
      if (value.data['status'] == 'error') {
        if (!isClosed) {
          emit(ProductErrorState());
        }
        AppSnackBar.showSnackBar(
            context, 'Error happened while adding to cart', Colors.red);
      } else {
        if (!isClosed) {
          emit(ProductInitState());
        }
        AppSnackBar.showSnackBar(context,
            'Product has been added to cart successfully', Colors.green);
      }
    }).catchError(
      (error) {
        if (!isClosed) {
          emit(ProductErrorState());
        }
        AppSnackBar.showSnackBar(
            context, 'Error happened while adding to cart', Colors.red);
      },
    );
  }
}
