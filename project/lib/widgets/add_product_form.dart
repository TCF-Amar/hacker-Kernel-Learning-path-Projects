import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/controller/product_controller.dart';
import 'package:project/models/product_model.dart';
import 'package:project/widgets/input_field.dart';
import 'package:provider/provider.dart';

class AddProductForm extends StatefulWidget {
  final int? id;
  final String? title;
  final String? description;
  final double? price;
  final String? category;
  final String? image;

  const AddProductForm({
    super.key,
    this.id,
    this.title,
    this.description,
    this.price,
    this.category,
    this.image,
  });

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  late TextEditingController idController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController categoryController;
  late TextEditingController imageController;

  @override
  void initState() {
    super.initState();

    idController = TextEditingController(text: widget.id?.toString() ?? "");
    titleController = TextEditingController(text: widget.title ?? "");
    descriptionController = TextEditingController(
      text: widget.description ?? "",
    );
    priceController = TextEditingController(
      text: widget.price?.toString() ?? "",
    );
    categoryController = TextEditingController(text: widget.category ?? "");
    imageController = TextEditingController(text: widget.image ?? "");
  }

  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<ProductController>(context, listen: false);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.id == null ? "Add Product" : "Edit Product",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),
              InputField(
                label: "ID",
                text: "id",
                controller: idController,
                isNumber: true,
              ),
              SizedBox(height: 10),
              InputField(
                label: "Title",
                text: "title",
                controller: titleController,
              ),
              SizedBox(height: 10),
              InputField(
                label: "Description",
                text: "description",
                controller: descriptionController,
              ),
              SizedBox(height: 10),
              InputField(
                label: "Price",
                text: "price",
                controller: priceController,
                isNumber: true,
              ),
              SizedBox(height: 10),
              InputField(
                label: "Category",
                text: "category",
                controller: categoryController,
              ),
              SizedBox(height: 10),
              InputField(
                label: "Image URL",
                text: "image",
                controller: imageController,
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  ProductModel newProduct = ProductModel(
                    id: int.parse(idController.text),
                    title: titleController.text,
                    description: descriptionController.text,
                    price: double.parse(priceController.text),
                    category: categoryController.text,
                    image: imageController.text,
                  );
                  if (newProduct.id.toString().isEmpty ||
                      newProduct.title.isEmpty ||
                      newProduct.description.isEmpty ||
                      newProduct.price.toString().isEmpty ||
                      newProduct.category.isEmpty ||
                      newProduct.image.isEmpty) {
                    return;
                  }
                  bool exist = pc.myProducts.any(
                    (p) => p.title.toString().trim().contains(
                      newProduct.title.toString().toLowerCase(),
                    ),
                  );

                  if(exist){
                    // Navigator.

                  }
                  Navigator.pop(context, newProduct);
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
