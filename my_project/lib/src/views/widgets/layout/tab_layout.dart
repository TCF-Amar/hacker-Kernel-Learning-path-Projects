import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/src/views/screens/create_blog_screen.dart';
import 'package:my_project/src/views/screens/home_screen.dart';
import 'package:my_project/src/views/screens/profile_screen.dart';

class TabLayout extends StatefulWidget {
  const TabLayout({super.key});

  @override
  State<TabLayout> createState() => _TabLayoutState();
}

class _TabLayoutState extends State<TabLayout> {
  int currentIndex = 0;
  var tabs = [HomeScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(child: tabs[currentIndex]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(CreateBlogScreen());
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
