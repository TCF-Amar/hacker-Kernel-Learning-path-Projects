import 'package:firebase_app/src/controllers/firebase_auth_controller.dart';
import 'package:firebase_app/src/views/widgets/app_text_field.dart';
import 'package:firebase_app/src/views/widgets/button_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuthController authController =
      Get.find<FirebaseAuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Sign Up"),

            AppTextField(
              controller: emailController,
              hint: "Email",
              label: "Email",
              icon: Icons.alternate_email_outlined,
            ),

            AppTextField(
              controller: passwordController,
              hint: "Password",
              label: "Password",
              icon: Icons.lock_outline,
              obscureText: true,
            ),

            ButtonText(
              loading: authController.loading,
              text: "Sign Up",
              action: () {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                authController.signUp(email, password);
              },
            ),

            Obx(() {
              if (authController.error.value.isEmpty) {
                return const SizedBox.shrink();
              }
              return Text(
                authController.error.value,
                style: const TextStyle(color: Colors.red),
              );
            }),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
