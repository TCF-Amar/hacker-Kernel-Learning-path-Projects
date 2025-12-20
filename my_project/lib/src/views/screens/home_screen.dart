
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/src/controllers/blog_controller.dart';
import 'package:my_project/src/models/blog_model.dart';
import 'package:my_project/src/views/widgets/blog_card.dart';
import 'package:my_project/src/views/widgets/layout/global_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final blogController = Get.find<BlogController>();

    return  Obx(() {
        if (blogController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (blogController.blogs.isEmpty) {
          return const Center(child: Text("No blogs found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: blogController.blogs.length,
          itemBuilder: (context, index) {
            final blog = blogController.blogs[index];
            return BlogCard(blog: blog);
          },
        );
      },
    );
  }
}


