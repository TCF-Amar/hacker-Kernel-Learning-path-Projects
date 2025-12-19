import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/firebase/firebase_auth_services.dart';
import 'src/views/screens/home_screen.dart';
import 'src/views/screens/login_screen.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<FirebaseAuthServices>();

    return Obx(() {
      if (!auth.isAuthInitialized.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      return auth.isLoggedIn
          ? const HomeScreen()
          : LoginScreen();
    });
  }
}
