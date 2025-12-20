import 'package:flutter/material.dart';
import 'package:project/screens/admin.dart';
import 'package:project/screens/product_screen.dart';

import '../screens/favorite_screen.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';

class Routes {
  static const String splash = "/splash";
  static const String home = "/home";
  static const String admin = "/admin";
  static const String favorite = "/favorite";

  static Route<dynamic> myRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case admin:
        return MaterialPageRoute(builder: (context) => const Admin());
      case favorite:
        return MaterialPageRoute(builder: (context) => const FavoriteScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(body: Center(child: Text("Page not available"))),
        );
    }
  }
}
