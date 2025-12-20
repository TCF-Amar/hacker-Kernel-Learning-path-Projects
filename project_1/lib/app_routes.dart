import 'package:flutter/material.dart';
import 'package:project_1/ui/widgets/layout.dart';

class AppRoutes {
  static const String splash = "/splash";
  static const String home = "/home";
  static const String productDetails = "/product-details";

  static const String cart = "/cart";

  static const String checkout = "/checkout";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => Scaffold(body: const Text("splash")),
        );
      case home:
        return MaterialPageRoute(builder: (context) => Layout());
      // case productDetails:
      //   return MaterialPageRoute(builder: (context) => Product());
      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text("Something went wrong"))),
        );
    }
  }
}
