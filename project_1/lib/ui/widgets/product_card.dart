import 'package:flutter/material.dart';
import 'package:project_1/models/product_model.dart';

import '../screens/product.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            InkWell(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Image.network(
                    product.image,
                    height: 250,
                    width: .infinity,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    product.title,
                    style: TextStyle(fontWeight: .w700, fontSize: 20),
                  ),
                  Row(
                    children: [
                      Text(
                        "₹${product.price}",
                        style: TextStyle(
                          fontWeight: .w700,
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "⭐ ${product.rating.rate ?? 0}(${product.rating.count})",
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Product(product: product),
                  ),
                );
              },
            ),
            // Text("sf"),
            Text(
              product?.bestSeller == true ? "BeastSeller" : "",
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
