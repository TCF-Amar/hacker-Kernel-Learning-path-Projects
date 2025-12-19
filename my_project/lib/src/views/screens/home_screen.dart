import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:my_project/src/views/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Text("Home"),
            Text(dotenv.env["BACKEND_URI"]?.toString() ?? ""),
            TextButton(
              onPressed: () {
                Get.to(() => const ProfileScreen());
              },

              child: const Text("Go Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
