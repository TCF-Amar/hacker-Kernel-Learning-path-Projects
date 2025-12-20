import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/cart_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context, listen: true);
    print(cart.cart);
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CustomScrollView(
              slivers: [

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: cart.cart!.length,
                    (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            cart.cart![index].product.image,
                          ),
                          title: Text(cart.cart![index].product.title),
                          subtitle: Text("${cart.cart![index].totalPrice}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.remove),
                              ),
                              Text(cart.cart![index].quantity.toString()),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
