import 'package:e_commerce_app/features/authentication/model/user_model.dart';
import 'package:e_commerce_app/features/home/controller/main_status.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/global/constants/api_constants.dart';
import 'package:e_commerce_app/global/services/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit(this.user) : super(MainInitState());
  static MainCubit get(context) => BlocProvider.of(context);
  final UserData user;
  LaptopsModel laptops = LaptopsModel();
  Future<void> fetchProducts() async {
    emit(ProductsLoadingState());
    DioHelper.getData(url: ApiConstants.productsApiUrl).then((value) {
      if (value.data['status'] == 'error') {
        emit(ProductsErrorState());
      } else {
        if (value.data == null) {
          emit(NoProductsState());
        } else {
          laptops = LaptopsModel.fromJson(value.data);
          emit(ProductsReadyState());
        }
      }
    }).catchError(
      (error) {
        emit(ProductsErrorState());
      },
    );
  }
}
