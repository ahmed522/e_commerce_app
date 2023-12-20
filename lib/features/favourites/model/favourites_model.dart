import 'package:e_commerce_app/features/products/model/product_model.dart';

class FavouritesModel {
  FavouritesModel();
  List<ProductModel> products = [];
  FavouritesModel.fromJson(Map<String, dynamic> json) {
    if (json['favoriteProducts'] != null) {
      json['favoriteProducts'].forEach((value) {
        products.add(ProductModel.fromJson(value));
      });
    }
  }
}
