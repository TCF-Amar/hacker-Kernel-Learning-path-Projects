import 'package:flutter/material.dart';
import 'package:project/controller/product_controller.dart';
import 'package:project/screens/product_screen.dart';
import 'package:project/widgets/add_product_form.dart';
import 'package:project/widgets/parent_widget.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<ProductController>(context, listen: true);

    return ParentWidget(
      floatingButton: FloatingActionButton(
        onPressed: () async {
          final ProductModel? res = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,

            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => const AddProductForm(),
          );

          if (res != null) {
            pc.addProduct(res);
          }
        },
        child: const Icon(Icons.add),
      ),

      child: ListView.builder(
        itemCount: pc.myProducts.length,
        itemBuilder: (context, index) {
          final product = pc.myProducts[index];

          return Column(
            children: [
              Text(
                "My Products",
                style: TextStyle(fontSize: 20, fontWeight: .w600),
              ),
              Divider(),
              Card(
                child: ListTile(
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
                  leading: SizedBox(
                    width: 50,
                    child: Image.network(
                      product.image
                    ),
                  ),
                  title: Text(product.title ?? ""),
                  subtitle: Text(product.description ?? ""),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          pc.removeProduct(product);
                        },
                        icon: const Icon(Icons.delete),
                      ),

                      IconButton(
                        onPressed: () async {
                          final ProductModel? updatedProduct =
                              await showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (_) => AddProductForm(
                                  id: product.id,
                                  title: product.title,
                                  description: product.description,
                                  price: product.price,
                                  category: product.category,
                                  image: product.image,
                                ),
                              );

                          if (updatedProduct != null) {
                            pc.updateProduct(product, updatedProduct);
                          }
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
