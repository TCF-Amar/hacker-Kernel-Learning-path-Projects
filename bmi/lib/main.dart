import 'package:bmi/tabs/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor: const Color(0xff0A0E21),
        appBar: AppBar(
          backgroundColor: const Color(0xff0A0E21),
          elevation: 0,
          title: const Text(
            "BMI Calculator",
            style: TextStyle(color: Colors.white),
          ),
        ),

        body: Center(child: HomeScreen()),
      ),
    );
  }
}
