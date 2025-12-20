import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/routes/app_routes.dart';
import 'package:my_project/src/controllers/firebase_auth_controller.dart';
import 'package:my_project/src/views/screens/authscreens/sign_up_screen.dart';
import 'package:my_project/src/views/widgets/app_text_field.dart';
import 'package:my_project/src/views/widgets/button_text.dart';
import 'package:my_project/src/views/widgets/sign_in_options.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign In",
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
                text: "Sign In",
                loading: _auth.isLoading,
                action: () {

                  _auth.signIn(emailController.text, passwordController.text);
                  print("Sign In ${_auth.isLoading}");
                },
              ),
              Row(
                mainAxisAlignment: .center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.signUp);
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
              Divider(),
              SignInOptions()
            ],
          ),
        ),
      ),
    );
  }
}
