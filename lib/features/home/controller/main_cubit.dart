import 'package:e_commerce_app/features/authentication/model/user_model.dart';
import 'package:e_commerce_app/features/home/controller/main_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit(this.user) : super(MainInitState());
  static MainCubit get(context) => BlocProvider.of(context);
  final UserData user;
  PageController pageController = PageController(initialPage: 0);
  int selectedPage = 0;

  getSelectedPage(int value) {
    selectedPage = value;
    emit(_getPageState(value));
  }

  onTapPage(int page, BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.unfocus();
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutExpo,
    );
    emit(_getPageState(page));
  }

  _getPageState(int page) {
    switch (page) {
      case 0:
        return AllProductsState();
      case 1:
        return CartState();
      case 2:
        return FavState();
      case 3:
        return ProfileState();
    }
  }
}
