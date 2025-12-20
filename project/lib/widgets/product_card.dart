import 'package:flutter/material.dart';
import 'package:project/controller/product_controller.dart';
import 'package:project/models/product_model.dart';
import 'package:provider/provider.dart';

import '../screens/product_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cardController = Provider.of<ProductController>(
      context,
      listen: true,
    );
    final imageUrl = product.image ?? "";
    final rating = product.rating?.rate ?? 0;
    final ratingCount = product.rating?.count ?? 0;
    final description = product.description ?? "";

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductScreen(product: product);
            },
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl.isNotEmpty
                    ? imageUrl
                    : "https://via.placeholder.com/200",
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.broken_image, size: 80),
              ),

              const SizedBox(height: 10),

              Text(
                product.title ?? "No Title",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "₹${product.price ?? 0}",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text("Rating $rating ($ratingCount)"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        cardController.addToCart(product, 1);
                      },
                      icon: Icon(Icons.add_shopping_cart, size: 25),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
