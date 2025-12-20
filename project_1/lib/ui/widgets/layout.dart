import 'package:flutter/material.dart';
import 'package:project_1/controllers/cart_controller.dart';
import 'package:project_1/ui/screens/cart_screen.dart';
import 'package:project_1/ui/tabs/collections_tab.dart';
import 'package:provider/provider.dart';

import '../tabs/home_tab.dart';

class Layout extends StatefulWidget {
  final int initialIndex;

  const Layout({super.key, this.initialIndex = 0});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentPageIndex = 1;

  final tabs = const [
    HomeTab(),
    CollectionsTab(),
    CollectionsTab(),
    Text("Profile"),
  ];

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Ecommerce App"),
        centerTitle: true,
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
                icon: Icon(Icons.shopping_cart_outlined),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IndexedStack(index: currentPageIndex, children: tabs),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (i) {
          setState(() => currentPageIndex = i);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(icon: Icon(Icons.apps), label: "Collections"),
          NavigationDestination(icon: Icon(Icons.search), label: "Search"),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
