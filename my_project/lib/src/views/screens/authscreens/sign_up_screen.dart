import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/src/controllers/firebase_auth_controller.dart';
import 'package:my_project/src/views/widgets/app_text_field.dart';
import 'package:my_project/src/views/widgets/button_text.dart';
import 'package:my_project/src/views/widgets/sign_in_options.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Get.find<FirebaseAuthController>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            AppTextField(
              controller: emailController,
              hint: "Enter Email",
              icon: Icons.alternate_email_outlined,
              label: "Email",
              keyboardType: TextInputType.emailAddress,
            ),
            AppTextField(
              controller: passwordController,
              hint: "Enter Password",
              icon: Icons.lock_outline,
              label: "Password",
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),

            ButtonText(
              text: "Sign Up",
              loading: _auth.isLoading,
              action: () {
                _auth.signUp(emailController.text, passwordController.text);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Sign In"),
                ),
              ],
            ),
            Divider(),
            SignInOptions()
          ],
        ),
      ),
    );
  }
}
