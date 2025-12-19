import 'package:firebase_app/services/firebase/firebase_auth_services.dart';
import 'package:firebase_app/src/controllers/firebase_auth_controller.dart';
import 'package:firebase_app/src/views/widgets/layout/global_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthServices _services = Get.find();
    final FirebaseAuthController _controller = Get.find();
    return GlobalLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Text("Home Screen"),
            Text(_services.user!.displayName.toString()),
            Text(_services.user!.email.toString()),
            TextButton(
              onPressed: () {
                _controller.signOut();
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
