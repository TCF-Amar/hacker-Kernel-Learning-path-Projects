import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/product_controller.dart';

class MySearchBar extends StatefulWidget {
  final bool focus;

  const MySearchBar({super.key, this.focus = false});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  Timer? _debounce;

  void _searchProduct(String text, ProductController pc) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      final query = text.trim().toLowerCase();

      pc.searchProduct(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<ProductController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 250,
            child: TextField(
              autofocus: widget.focus,
              decoration: const InputDecoration(
                labelText: "Search",
                hintText: "Search products...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => _searchProduct(value, pc),
            ),
          ),
          IconButton(
            onPressed: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                context: context,
                builder: (_) => FilterSheet(),
              );
            },
            icon: Icon(Icons.filter_list, size: 30),
          ),
        ],
      ),
    );
  }
}

class FilterSheet extends StatefulWidget {
  FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: .infinity,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: .min,
            children: [





              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(onPressed: () {}, child: Text("Close")),
                  TextButton(onPressed: () {}, child: Text("Reset")),
                  TextButton(onPressed: () {}, child: Text("Apply filter")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
