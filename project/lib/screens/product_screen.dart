import 'package:flutter/material.dart';
import 'package:project/controller/product_controller.dart';
import 'package:project/widgets/parent_widget.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductModel get product => widget.product;
  int quantity = 1;

  void _increase() {
    setState(() {
      quantity++;
    });
  }

  void _decrease() {
    setState(() {
      if (quantity <= 1) return;
      quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<ProductController>(context, listen: true);

    final isFavorite = pc.favoriteProducts.any((p) => p.id == product.id);

    final imageUrl = product.image ?? "";
    final rating = product.rating?.rate ?? 0;
    final ratingCount = product.rating?.count ?? 0;
    final price = product.price ?? 0;
    final title = product.title ?? "No Title";

    return ParentWidget(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 10),
                    Text("Back"),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Stack(
                children: [
                  Image.network(
                    imageUrl.isNotEmpty
                        ? imageUrl
                        : "https://via.placeholder.com/200",
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 100),
                  ),

                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        pc.toggleFavorite(product);
                      },
                      icon: isFavorite
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 30,
                            ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "₹$price",
                style: const TextStyle(fontSize: 22, color: Colors.red),
              ),

              const SizedBox(height: 10),

              Text(
                "Rating $rating ($ratingCount Reviews)",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Container(
                // height: 100,
                // width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        _decrease();
                      },
                      icon: Icon(Icons.remove, color: Colors.white),
                    ),
                    Text("$quantity", style: TextStyle(color: Colors.white)),
                    IconButton(
                      onPressed: () {
                        _increase();
                      },
                      icon: Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 70,

                child: ElevatedButton(
                  onPressed: () {
                    pc.addToCart(product, quantity);
                    // Navigator.pop(context);
                  },

                  child: Text("Add to cart"),
                ),
              ),
              const SizedBox(height: 10),

              Text(
                product.description ?? "",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
