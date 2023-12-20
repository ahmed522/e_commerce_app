import 'package:e_commerce_app/features/products/model/product_model.dart';

class CartProduct {
  ProductModel? product;
  dynamic quantity;
  dynamic totalPrice;

  CartProduct({this.product, this.quantity, this.totalPrice});

  CartProduct.fromJson(Map<String, dynamic> json) {
    product = ProductModel.fromJson(json);
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
  }
  toJson() {
    Map<String, dynamic> json = {};
    json.addAll(product!.toJson());
    json['quantity'] = quantity;
    json['totalPrice'] = totalPrice;
  }
}
