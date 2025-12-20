import 'package:project_1/models/product_model.dart';

class CartModel {
  final ProductModel product;
   int quantity;
   double totalPrice = 0;

  CartModel({
    required this.product,
    required this.quantity,
     double? totalPrice,
  }): totalPrice = totalPrice ?? product.price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      totalPrice: json['totalPrice'].toDouble(),
    );
  }
}
