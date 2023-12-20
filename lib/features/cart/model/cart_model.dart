import 'cart_product.dart';

class CartModel {
  List<CartProduct> products = [];

  CartModel();
  double totalCost = 0;
  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      json['products'].forEach((v) {
        totalCost += v['totalPrice'];
        products.add(CartProduct.fromJson(v));
      });
    }
  }
}
