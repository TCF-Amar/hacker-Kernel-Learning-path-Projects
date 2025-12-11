import 'package:flutter/material.dart';

// ignore: camel_case_types
class App_Bar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const App_Bar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Center(
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
