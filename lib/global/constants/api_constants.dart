class ApiConstants {
  /*----------------------------------------------------------------------------
   *                                 Authentication                            -
   *----------------------------------------------------------------------------*/

  /*---------------------- signin -----------------------*/

  static const String signinApiUrl = 'https://elwekala.onrender.com/user/login';

  /*---------------------- signup -----------------------*/

  static const String signupApiUrl =
      'https://elwekala.onrender.com/user/register';

  /*----------------------------------------------------------------------------
   *                                 Products                                  -
   *----------------------------------------------------------------------------*/

  static const String productsApiUrl =
      'https://elwekala.onrender.com/product/Laptops';

  /*----------------------------------------------------------------------------
   *                                   Cart                                    -
   *----------------------------------------------------------------------------*/

  static const String addToCartApiUrl =
      'https://elwekala.onrender.com/cart/add';
  static const String getCartProductsApiUrl =
      'https://elwekala.onrender.com/cart/allProducts';
  static const String deleteCartProductsApiUrl =
      'https://elwekala.onrender.com/cart/delete';
  static const String updateCartApiUrl = 'https://elwekala.onrender.com/cart';

  /*----------------------------------------------------------------------------
   *                                   Favourites                              -
   *----------------------------------------------------------------------------*/

  static const String favouritesApiUrl =
      'https://elwekala.onrender.com/favorite';

  /*----------------------------------------------------------------------------
   *                                   Profile                                 -
   *---------------------------------------------------------------------------*/

  static const String profileApiUrl =
      'https://elwekala.onrender.com/user/profile';
  static const String profileUpdateApiUrl =
      'https://elwekala.onrender.com/user/update';
}
