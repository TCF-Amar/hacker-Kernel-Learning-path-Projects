import 'package:flutter/material.dart';
import 'package:project/controller/product_controller.dart';
import 'package:project/screens/cart_screen.dart';
import 'package:project/widgets/drawers.dart';
import 'package:provider/provider.dart';

class ParentWidget extends StatelessWidget {
  final Widget child;
  final Widget? floatingButton;

  const ParentWidget({super.key, required this.child, this.floatingButton});

  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<ProductController>(context, listen: true);
    return Scaffold(
      drawer: Drawers(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartScreen()),
                  );
                },
                icon: Icon(Icons.shopping_cart),
              ),
              Positioned(
                right: 10,
                bottom: 0,
                child: pc.cart.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Text("${pc.getTotleQty()>9 ? "9+": pc.getTotleQty()}",style: TextStyle(
                          fontSize: 8
                        ),)),
                      ): Text("")

              ),
            ],
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("MyShop", style: TextStyle(fontWeight: .w700))],
        ),
      ),
      body: SafeArea(child: child),
      floatingActionButton: floatingButton,
    );
  }
}
