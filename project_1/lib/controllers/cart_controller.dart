import 'package:flutter/material.dart';
import 'package:project_1/models/cart_model.dart';
import 'package:project_1/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends ChangeNotifier {
  late SharedPreferences _prefs;

  final List<CartModel>? _cart = [];

  int totelItem = 0;
  double totalPrice = 0;


  List<CartModel>? get cart => _cart;
  double get total => totalPrice;
  int get item => totelItem;


  CartController() {
    _init();
  }

  void _init() async {
    _prefs = await SharedPreferences.getInstance();
    print(_prefs);
  }

  void addToCart(ProductModel product, int quantity, double totalPrice) {
    bool exist = _cart!.any((element) => element.product.id == product.id);

    if (exist) {
      print("Product already exist");
      for (var element in _cart) {
        if (element.product.id == product.id) {
          element.quantity += quantity;
          element.totalPrice = totalPrice;
        }
      }
    } else {
      _cart.add(
        CartModel(product: product, quantity: quantity, totalPrice: totalPrice),
      );
    }
  }



}
