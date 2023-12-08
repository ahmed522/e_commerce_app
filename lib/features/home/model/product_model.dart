class LaptopsModel {
  String? status;
  String? message;
  List<ProductModel> product = [];

  LaptopsModel({this.status, this.message});

  LaptopsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['product'] != null) {
      product = <ProductModel>[];
      json['product'].forEach((v) {
        product.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  String? sId;
  String? status;
  String? category;
  String? name;
  dynamic price;
  String? description;
  String? image;
  String? company;
  dynamic countInStock;
  List<String>? images;
  dynamic iV;

  ProductModel({
    this.sId,
    this.status,
    this.category,
    this.name,
    this.price,
    this.description,
    this.image,
    this.company,
    this.countInStock,
    this.iV,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    company = json['company'];
    images = json['images'].cast<String>();
    countInStock = json['countInStock'];
    iV = json['__v'];
  }

  toJson() {
    Map<String, dynamic> json = {};
    json['_id'] = sId;
    json['status'] = status;
    json['category'] = category;
    json['name'] = name;
    json['price'] = price;
    json['description'] = description;
    json['image'] = image;
    json['company'] = company;
    json['images'] = images;
    json['countInStock'] = countInStock;
    json['__v'] = iV;
    return json;
  }
}
