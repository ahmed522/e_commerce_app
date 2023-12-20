import 'package:e_commerce_app/features/favourites/controller/favourites_states.dart';
import 'package:e_commerce_app/features/favourites/model/favourites_model.dart';
import 'package:e_commerce_app/global/constants/api_constants.dart';
import 'package:e_commerce_app/global/services/cache_helper.dart';
import 'package:e_commerce_app/global/services/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesCubit extends Cubit<FavouritesStates> {
  FavouritesCubit() : super(FavouritesInitState());
  static FavouritesCubit get(context) => BlocProvider.of(context);
  FavouritesModel favouritesModel = FavouritesModel();

  Future<void> fetchFavourites() async {
    if (!isClosed) {
      emit(FavouritesLoadingState());
    }
    String? nationalId = await CacheHelper.getData(key: 'nationalId');

    DioHelper.getData(url: ApiConstants.favouritesApiUrl, data: {
      'nationalId': nationalId,
    }).then(
      (value) {
        if (value.data['status'] != 'success') {
          if (!isClosed) {
            emit(FavouritesErrorState());
          }
        } else {
          if (value.data['favoriteProducts'].isEmpty) {
            if (!isClosed) {
              emit(NoFavouritesState());
            }
          } else {
            favouritesModel = FavouritesModel.fromJson(value.data);
            if (!isClosed) {
              emit(FavouritesReadyState());
            }
          }
        }
      },
    ).catchError(
      (error) {
        if (!isClosed) {
          emit(FavouritesErrorState());
        }
      },
    );
  }

  Future<void> addToFavourites(String productId) async {
    if (!isClosed) {
      emit(FavouritesLoadingState());
    }
    String? nationalId = await CacheHelper.getData(key: 'nationalId');

    DioHelper.postData(url: ApiConstants.favouritesApiUrl, data: {
      'nationalId': nationalId,
      'productId': productId,
    }).then(
      (value) {
        if (value.data['status'] != 'success') {
          if (!isClosed) {
            emit(FavouritesErrorState());
          }
        } else {
          fetchFavourites();
          if (!isClosed) {
            emit(FavouritesReadyState());
          }
        }
      },
    ).catchError(
      (error) {
        if (!isClosed) {
          emit(FavouritesErrorState());
        }
      },
    );
  }

  Future<void> removeFromFavourites(String productId) async {
    if (!isClosed) {
      emit(FavouritesLoadingState());
    }
    String? nationalId = await CacheHelper.getData(key: 'nationalId');

    DioHelper.delData(url: ApiConstants.favouritesApiUrl, data: {
      'nationalId': nationalId,
      'productId': productId,
    }).then(
      (value) {
        if (value.data['status'] != 'success') {
          if (!isClosed) {
            emit(FavouritesErrorState());
          }
        } else {
          fetchFavourites();
        }
      },
    ).catchError(
      (error) {
        if (!isClosed) {
          emit(FavouritesErrorState());
        }
      },
    );
  }
}
