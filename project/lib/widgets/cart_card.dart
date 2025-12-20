import 'package:flutter/material.dart';
import 'package:project/controller/product_controller.dart';
import 'package:project/models/cart_model.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  final CartModel cart;

  const CartCard({super.key, required this.cart});

  // print(cart);
  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<ProductController>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ListTile(
              leading: SizedBox(
                width: 50,
                child: Image.network(cart.product.image),
              ),
              title: Text(
                cart.product.title.toString(),
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
              subtitle: Text(
                "Price: ₹${cart.totalPrice.toStringAsFixed(2).toString()}",
                style: TextStyle(color: Colors.green),
              ),
              trailing: Text(
                "Qty: ${cart.quantity.toString()}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onHover: (v){
                    print(v);
                  },
                  onPressed: () {
                    cartController.decrease(cart.product);
                  },
                  icon: Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: () {
                    cartController.increase(cart.product);
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    cartController.removeFromCart(cart.product);
                    // Navigator.pop(context);
                  },
                  icon: Icon(Icons.delete_forever),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
