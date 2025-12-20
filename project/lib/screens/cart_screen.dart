import 'package:flutter/material.dart';
import 'package:project/controller/product_controller.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/widgets/cart_card.dart';
import 'package:project/widgets/empty_cart.dart';
import 'package:project/widgets/parent_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      child: Consumer<ProductController>(
        builder: (context, controller, _) {
          final cart = controller.cart;

          if (cart.isEmpty) {
            return EmptyCart();
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "My Cart",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: cart.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      return CartCard(cart: cart[index]);
                    },
                  ),
                ),
                const Divider(),
                TextButton(

                  onPressed: () {
                    controller.clearCart();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.delete_forever_outlined, color: Colors.red),
                      Text("Clear cart", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Price: ", style: TextStyle(fontSize: 20)),
                      Text(
                        "₹${controller.getTotalPrice().toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: .w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
