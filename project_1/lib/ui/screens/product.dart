import 'package:flutter/material.dart';
import 'package:project_1/models/product_model.dart';
import 'package:provider/provider.dart';

import '../../controllers/cart_controller.dart';

class Product extends StatefulWidget {
  final ProductModel product;

  const Product({super.key, required this.product});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  int qty = 1;

  void _inc() {
    setState(() {
      qty++;
    });
  }

  double calculateTotalPrice() {
    double finalPrice = widget.product.price * qty;
    return finalPrice;
  }

  void _dec() {
    setState(() {
      if (qty > 1) {
        qty--;
      } else {
        qty = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context, listen: true);
    print(cart.cart);
    return Scaffold(
      appBar: AppBar(title: const Text("Back")),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  widget.product.image,
                  height: 400,
                  width: double.infinity,
                ),
                Divider(),
                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: Row(
                    children: [
                      Image.network(widget.product.image, width: 100),
                      SizedBox(width: 20),
                      Image.network(widget.product.image, width: 100),
                      SizedBox(width: 20),
                      Image.network(widget.product.image, width: 100),
                      SizedBox(width: 20),
                      Image.network(widget.product.image, width: 100),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
                Text(
                  widget.product.title,
                  style: TextStyle(fontSize: 20, fontWeight: .w600),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "₹${widget.product.price.toString()}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: .w600,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "⭐ ${widget.product.rating.rate}(${widget.product.rating.count})",
                    ),
                  ],
                ),
                Container(
                  width: .infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: .max,

                    children: [
                      Text("QTY:"),
                      IconButton(onPressed: _dec, icon: Icon(Icons.remove)),
                      Text(qty.toString()),
                      IconButton(onPressed: _inc, icon: Icon(Icons.add)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      cart.addToCart(
                        widget.product,
                        qty,
                        calculateTotalPrice(),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(width: 10),
                        Text("Add to cart"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
