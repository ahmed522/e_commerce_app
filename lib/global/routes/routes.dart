import 'package:e_commerce_app/features/authentication/controller/signin_cubit/signin_cubit.dart';
import 'package:e_commerce_app/features/authentication/controller/signup_cubit/signup_cubit.dart';
import 'package:e_commerce_app/features/authentication/model/user_model.dart';
import 'package:e_commerce_app/features/authentication/view/screens/signin_screen.dart';
import 'package:e_commerce_app/features/authentication/view/screens/signup_screen.dart';
import 'package:e_commerce_app/features/cart/controller/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/view/screens/cart_screen.dart';
import 'package:e_commerce_app/features/favourites/controller/favourites_cubit.dart';
import 'package:e_commerce_app/features/favourites/view/screens/favourites_screen.dart';
import 'package:e_commerce_app/features/home/controller/main_cubit.dart';
import 'package:e_commerce_app/features/home/view/screens/main_screen.dart';
import 'package:e_commerce_app/features/products/controller/all_products_cubit/all_products_cubit.dart';
import 'package:e_commerce_app/features/products/controller/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/features/products/model/product_model.dart';
import 'package:e_commerce_app/features/products/view/screens/all_products_screen.dart';
import 'package:e_commerce_app/features/products/view/screens/product_screen.dart';
import 'package:e_commerce_app/features/profile/controller/profile_cubit.dart';
import 'package:e_commerce_app/features/profile/view/screens/profile_screen.dart';
import 'package:e_commerce_app/features/start/controller/onboarding_cubit.dart';
import 'package:e_commerce_app/features/start/view/screens/onboarding_screen.dart';
import 'package:e_commerce_app/features/start/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    SplashScreen.route: (context) => const SplashScreen(),
    OnboardingScreen.route: (context) => BlocProvider<OnboardingCubit>(
          create: (context) => OnboardingCubit(),
          child: const OnboardingScreen(),
        ),
    SigninScreen.route: (context) => BlocProvider<SigninCubit>(
        create: (context) => SigninCubit(), child: const SigninScreen()),
    SignupScreen.route: (context) => BlocProvider<SignupCubit>(
        create: (context) => SignupCubit(), child: const SignupScreen()),
    AllProductsScreen.route: (context) => BlocProvider<AllProductsCubit>(
        create: (context) => AllProductsCubit()..fetchAllProducts(),
        child: const AllProductsScreen()),
    CartScreen.route: (context) => BlocProvider<CartCubit>(
        create: (context) => CartCubit()..fetchCartProducts(),
        child: const CartScreen()),
    FavouritesScreen.route: (context) => BlocProvider<FavouritesCubit>(
        create: (context) => FavouritesCubit()..fetchFavourites(),
        child: const FavouritesScreen()),
    ProfileScreen.route: (context) => BlocProvider<ProfileCubit>(
        create: (context) => ProfileCubit()..fetchUserData(),
        child: const ProfileScreen()),
  };

  static onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case ProductScreen.route:
        ProductModel product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ProductCubit>(
            create: (context) => ProductCubit(product)..isFavourite(),
            child: const ProductScreen(),
          ),
        );
      case MainScreen.route:
        UserData user = settings.arguments as UserData;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MainCubit>(
            create: (context) => MainCubit(user),
            child: const MainScreen(),
          ),
        );
    }
  }
}
