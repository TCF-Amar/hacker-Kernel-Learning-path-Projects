import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/routes/app_routes.dart';
import 'package:my_project/src/controllers/blog_controller.dart';
import 'package:my_project/src/controllers/firebase_auth_controller.dart';
import 'package:my_project/src/models/blog_model.dart';
import 'package:my_project/src/views/widgets/app_text_field.dart';
import 'package:my_project/src/views/widgets/layout/global_layout.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({super.key});

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  late String selectedCategory;

  final BlogController blog = Get.find<BlogController>();
  final FirebaseAuthController auth = Get.find<FirebaseAuthController>();

  @override
  void initState() {
    super.initState();
    selectedCategory = blog.blogCategories.first;
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _submitBlog() {
    final user = auth.firebaseUser.value;

    if (user == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    if (titleController.text.trim().isEmpty ||
        contentController.text.trim().isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    blog.createBlog(
      BlogModel(
        title: titleController.text.trim(),
        description: contentController.text.trim(),
        category: selectedCategory,
        authorId: user.uid,
        createdAt: Timestamp.now(),
      ),
      user.uid,
    );

    Get.offAllNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLayout(
      title: "Create Blog",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Create New Blog",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            AppTextField(
              controller: titleController,
              label: "Title",
              hint: "Enter blog title",
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: blog.blogCategories
                  .map(
                    (cat) => DropdownMenuItem(
                  value: cat,
                  child: Text(cat),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: contentController,
              minLines: 4,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: "Content",
                hintText: "Write your blog content here",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(16),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _submitBlog,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Post Blog"),
            ),
          ],
        ),
      ),
    );
  }
}
