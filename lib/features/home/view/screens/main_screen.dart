import 'package:e_commerce_app/features/cart/controller/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/view/screens/cart_screen.dart';
import 'package:e_commerce_app/features/favourites/controller/favourites_cubit.dart';
import 'package:e_commerce_app/features/favourites/view/screens/favourites_screen.dart';
import 'package:e_commerce_app/features/home/controller/main_cubit.dart';
import 'package:e_commerce_app/features/home/controller/main_status.dart';
import 'package:e_commerce_app/features/products/controller/all_products_cubit/all_products_cubit.dart';
import 'package:e_commerce_app/features/products/view/screens/all_products_screen.dart';
import 'package:e_commerce_app/features/profile/controller/profile_cubit.dart';
import 'package:e_commerce_app/features/profile/view/screens/profile_screen.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const String route = 'mainScreen';
  @override
  Widget build(BuildContext context) {
    final cubit = MainCubit.get(context);
    return Scaffold(
      body: PageView(
        controller: cubit.pageController,
        onPageChanged: (selectedPage) => cubit.getSelectedPage(selectedPage),
        children: [
          BlocProvider<AllProductsCubit>(
            create: (context) => AllProductsCubit()..fetchAllProducts(),
            child: const AllProductsScreen(),
          ),
          BlocProvider<CartCubit>(
            create: (context) => CartCubit()..fetchCartProducts(),
            child: const CartScreen(),
          ),
          BlocProvider<FavouritesCubit>(
            create: (context) => FavouritesCubit()..fetchFavourites(),
            child: const FavouritesScreen(),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit()..fetchUserData(),
            child: const ProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar:
          BlocBuilder<MainCubit, MainStates>(builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: cubit.selectedPage,
          elevation: 5.0,
          backgroundColor: CommonFunctions.isLightMode(context)
              ? Colors.white
              : Colors.black,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          onTap: (value) => cubit.onTapPage(value, context),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: CommonFunctions.isLightMode(context)
                    ? Colors.black54
                    : Colors.white54,
              ),
              activeIcon: const Icon(Icons.home_rounded),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: CommonFunctions.isLightMode(context)
                    ? Colors.black54
                    : Colors.white54,
              ),
              activeIcon: const Icon(Icons.shopping_cart_rounded),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline_rounded,
                color: CommonFunctions.isLightMode(context)
                    ? Colors.black54
                    : Colors.white54,
              ),
              activeIcon: const Icon(Icons.favorite_rounded),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_rounded,
                color: CommonFunctions.isLightMode(context)
                    ? Colors.black54
                    : Colors.white54,
              ),
              activeIcon: const Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
}
