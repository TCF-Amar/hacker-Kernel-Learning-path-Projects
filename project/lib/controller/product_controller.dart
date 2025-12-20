import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

class ProductController extends ChangeNotifier {
  late SharedPreferences pref;
  final String productKey = "my-product";
  final String favoriteKey = "my-favorite";

  List<ProductModel> _products = [];
  List<ProductModel> _myProducts = [];
  List<ProductModel> _favoriteProducts = [];
  List<ProductModel> _filteredProducts = [];
  List<CartModel> _cart = [];

  String? _query = "";

  void setQuery(String query) {
    _query = query;
  }

  String? get query => _query;

  List<ProductModel> get products => _products;

  List<ProductModel> get myProducts => _myProducts;

  List<ProductModel> get favoriteProducts => _favoriteProducts;

  List<ProductModel> get filteredProducts => _filteredProducts;

  List<CartModel> get cart => _cart;

  ProductController() {
    start();
  }

  void start() async {
    pref = await SharedPreferences.getInstance();
    await _loadJsonData();
    _loadSavedProducts();
    _loadSavedFavorite();
    _filteredProducts = allProducts;
    notifyListeners();
  }

  Future<void> _loadJsonData() async {
    final res = await rootBundle.loadString('assets/data.json');
    final List data = jsonDecode(res);
    _products = data.map((e) => ProductModel.fromMap(e)).toList();
  }

  List<ProductModel> get allProducts {
    return [..._products, ..._myProducts];
  }

  Timer? _debouncing;

  void filterProduct(String query) {
    if (query.isEmpty) {
      _filteredProducts = allProducts;
    } else {
      query = query.toLowerCase();
      _filteredProducts = allProducts
          .where((p) => p.title.toLowerCase().contains(query))
          .toList();
    }
    notifyListeners();
  }

  void sortingProducts(String value) {
    value = value.trim();
    switch (value) {
      case "lowToHigh":
        _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case "highToLow":
        _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case "5 Star":
        _filteredProducts = _filteredProducts
            .where((p) => (p.rating?.rate ?? 0) >= 5)
            .toList();
        break;
      case "4 Star":
        _filteredProducts = allProducts
            .where(
              (p) => (p.rating?.rate ?? 0) >= 4 && (p.rating?.rate ?? 0) < 5,
            )
            .toList();
        break;
      case "3 Star":
        _filteredProducts = allProducts
            .where(
              (p) => (p.rating?.rate ?? 0) >= 3 && (p.rating?.rate ?? 0) < 4,
            )
            .toList();
        break;
      case "2 Star":
        _filteredProducts = allProducts
            .where(
              (p) => (p.rating?.rate ?? 0) >= 2 && (p.rating?.rate ?? 0) < 3,
            )
            .toList();
        break;
      case "1 Star":
        _filteredProducts = allProducts
            .where((p) => (p.rating?.rate ?? 0) < 2)
            .toList();
        break;
      default:
        _filteredProducts = allProducts;
        break;
    }

    notifyListeners();
  }

  Future<void> _saveFavorite() async {
    List<String> data = _favoriteProducts
        .map((e) => jsonEncode(e.toMap()))
        .toList();
    await pref.setStringList(favoriteKey, data);
    notifyListeners();
  }

  void _loadSavedFavorite() {
    List<String>? data = pref.getStringList(favoriteKey);
    if (data != null) {
      _favoriteProducts = data
          .map((e) => ProductModel.fromMap(jsonDecode(e)))
          .toList();
    }
  }

  Future<void> toggleFavorite(ProductModel product) async {
    bool isFav = _favoriteProducts.any((p) => p.id == product.id);
    if (isFav) {
      _favoriteProducts.removeWhere((p) => p.id == product.id);
    } else {
      _favoriteProducts.add(product);
    }
    await _saveFavorite();
    notifyListeners();
  }

  Future<void> _saveProducts() async {
    List<String> data = _myProducts.map((e) => jsonEncode(e.toMap())).toList();
    await pref.setStringList(productKey, data);
  }

  void _loadSavedProducts() {
    List<String>? data = pref.getStringList(productKey);
    if (data != null) {
      _myProducts = data
          .map((e) => ProductModel.fromMap(jsonDecode(e)))
          .toList();
    }
  }

  bool addProduct(ProductModel product) {
    bool res = myProducts.any((p) => p.title.contains(product.title));
    if (res) {
      return false;
    }
    _myProducts.add(product);
    _saveProducts();
    _filteredProducts = allProducts;
    notifyListeners();
    return true;
  }

  void removeProduct(ProductModel product) {
    _myProducts.removeWhere((p) => p.id == product.id);
    _saveProducts();
    _filteredProducts = allProducts;
    notifyListeners();
  }

  void updateProduct(ProductModel prev, ProductModel newP) {
    final index = _myProducts.indexWhere((p) => p.id == prev.id);
    if (index != -1) {
      _myProducts[index] = newP;
      _saveProducts();
      _filteredProducts = allProducts;
      notifyListeners();
    }
  }

  void getCatDetails() {
    Map<String, dynamic> categoryCount = {};
    for (var i in allProducts) {}
  }

  void addToCart(ProductModel product, int quantity) {
    bool isExist = _cart.any((c) => c.product.id == product.id);
    if (isExist) {
      int newQuantity =
          _cart.firstWhere((c) => c.product.id == product.id).quantity +
          quantity;

      _cart.firstWhere((c) => c.product.id == product.id).quantity =
          newQuantity;
      notifyListeners();
      return;
    }
    ;

    _cart.add(CartModel(product: product, quantity: quantity));
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cart.removeWhere((c) => c.product.id == product.id);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void increase(ProductModel product) {
    int index = _cart.indexWhere((c) => c.product.id == product.id);
    if (index != -1) {
      _cart[index].quantity += 1;
      notifyListeners();
    }
  }

  void decrease(ProductModel product) {
    int index = _cart.indexWhere((c) => c.product.id == product.id);
    if (index != -1 && _cart[index].quantity > 1) {
      _cart[index].quantity -= 1;
      notifyListeners();
    }
  }

  double getTotalPrice() {
    double totalPrice = 0;
    for (var item in _cart) {
      totalPrice += item.totalPrice;
    }
    return totalPrice;
  }

  // double get totalPrice => _cart.fold(0, (sum, item) => sum + item.totalPrice);

  int getTotleQty(){
    int totalQty = 0;
    for(var item in _cart){
      totalQty += item.quantity;
    }
    return totalQty;
  }
}
