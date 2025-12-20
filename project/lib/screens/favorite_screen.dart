import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/widgets/parent_widget.dart';
import 'package:project/widgets/product_card.dart';
import 'package:provider/provider.dart';

import '../controller/product_controller.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<ProductController>(context, listen: true);
    return ParentWidget(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/home");
            },
            child: Row(
              children: [
                Icon(Icons.arrow_back),
                SizedBox(width: 10),
                Text("Back"),
              ],
            ),
          ),
          SizedBox(height: 20),
          if (pc.favoriteProducts.isEmpty)
            Expanded(child: Center(child: Text("No Favorite Products")))
          else
            Expanded(
              child: ListView.builder(
                itemCount: pc.favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = pc.favoriteProducts[index];
                  return Stack(
                    children: [
                      ProductCard(product: product),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: IconButton(
                          onPressed: () {
                            pc.toggleFavorite(product);
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
