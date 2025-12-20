import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/src/controllers/blog_controller.dart';
import 'package:my_project/src/controllers/firebase_auth_controller.dart';
import 'package:my_project/src/views/widgets/blog_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Get.find<FirebaseAuthController>();
    final blogController = Get.find<BlogController>();

    return Obx(() {
      final user = auth.firebaseUser.value;

      if (user == null) {
        return const Center(
          child: Text("No user found"),
        );
      }

      if (blogController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundImage: user.photoURL != null
                  ? NetworkImage(user.photoURL!)
                  : null,
              child: user.photoURL == null
                  ? const Icon(Icons.person, size: 40)
                  : null,
            ),

            const SizedBox(height: 16),

            Text(
              user.displayName ?? "No Name",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 6),

            Text(
              user.email ?? user.phoneNumber ?? "No contact information",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Sign Out"),
                onPressed: auth.signOut,
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "My Blogs",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            const SizedBox(height: 10),

            if (blogController.myBlogs.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "You haven’t created any blogs yet.",
                  style: TextStyle(color: Colors.grey),
                ),
              )

            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: blogController.myBlogs.length,
                itemBuilder: (context, index) {
                  final blog = blogController.myBlogs[index];
                  return BlogCard(blog: blog);
                },
              ),
          ],
        ),
      );
    });
  }
}
