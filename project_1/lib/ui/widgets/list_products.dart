import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_1/ui/widgets/product_card.dart';
import 'package:provider/provider.dart';

import '../../controllers/product_controller.dart';

class ListProducts extends StatelessWidget {
  const ListProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<ProductController>(context, listen: true);
    final _products = pc.filteredProducts;
    print(_products);

    return
      ListView.builder(
      // physics: NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      itemCount: _products.length,
      itemBuilder: (context, idx) {
        final product = _products[idx];
        return ProductCard(product: product);
      },
    );
  }
}
