import 'package:flutter/material.dart';

class GlobalLayout extends StatelessWidget {
  final Widget child;

  const GlobalLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(10.0), child: child),
      ),
    );
  }
}
