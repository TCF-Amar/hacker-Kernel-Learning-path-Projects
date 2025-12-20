import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/product_model.dart';

class ProductController with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> _filteredProducts = [];

  List<ProductModel> get products => _products;

  List<ProductModel> get filteredProducts => _filteredProducts;

  ProductController() {
    _init();
  }

  void _init() async {
    await _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    final res = await rootBundle.loadString("assets/data.json");
    final data = await json.decode(res);
    _products = data
        .map<ProductModel>((e) => ProductModel.fromJson(e))
        .toList();
    _filteredProducts = _products;
    notifyListeners();
  }

  void searchProduct(String query) {
    query = query.toLowerCase().trim();
    if (query.isEmpty) {
      _filteredProducts = [];
    }

    _filteredProducts = products
        .where((p) => p.title.toLowerCase().trim().contains(query))
        .toList();

    notifyListeners();
  }

  List<ProductModel> get bestSellerProducts =>
      products.where((p) => p.bestSeller == true).toList();
}
