import 'package:flutter/material.dart';
import 'package:project/widgets/parent_widget.dart';
import 'package:project/widgets/product_card.dart';
import 'package:provider/provider.dart';

import '../controller/product_controller.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<ProductController>(context, listen: true);
    pc.getCatDetails();
    return ParentWidget(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            MySearchBar(),
            Expanded(
              child: ListView.builder(
                itemCount: pc.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = pc.filteredProducts[index];
                  return ProductCard(product: product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
