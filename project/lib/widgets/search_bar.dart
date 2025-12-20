import 'package:flutter/material.dart';
import 'package:project/controller/product_controller.dart';
import 'package:provider/provider.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final textController = TextEditingController();

  final List<String> sortItem = [
    "Relevance",
    "lowToHigh",
    "highToLow",
    "5 Star",
    "4 Star",
    "3 Star",
    "2 Star",
    "1 Star",
  ];

  String selectedSort = "Relevance";

  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<ProductController>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: "Search products...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (v) {
              pc.filterProduct(v);
              // pc.sortingProducts(selectedSort);
            },
          ),
        ),

        Container(
          padding: const EdgeInsets.all(10),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: "Sort"),
            initialValue: selectedSort,
            items: sortItem
                .map((item) =>
                DropdownMenuItem<String>(value: item, child: Text(item)))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() => selectedSort = value);
              pc.sortingProducts(value);
            },
          ),
        ),
      ],
    );
  }
}
