import 'package:firebase_app/src/controllers/firebase_auth_controller.dart';
import 'package:firebase_app/src/views/screens/sign_up_screen.dart';
import 'package:firebase_app/src/views/widgets/app_text_field.dart';
import 'package:firebase_app/src/views/widgets/button_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
            const Text("Login"),

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
              text: "Login",

              action: () {
                String email = emailController.text;
                String password = passwordController.text;
                authController.signIn(email, password);
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have account?"),
                TextButton(
                  onPressed: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: const Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
