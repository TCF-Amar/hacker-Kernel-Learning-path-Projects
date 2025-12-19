import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/src/controllers/firebase_auth_controller.dart';
import 'package:my_project/src/views/screens/authscreens/phone_sign_in_screen.dart';

class SignInOptions extends StatefulWidget {
  const SignInOptions({super.key});

  @override
  State<SignInOptions> createState() => _SignInOptionsState();
}

class _SignInOptionsState extends State<SignInOptions> {
  final _auth = Get.find<FirebaseAuthController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black26),
              ),
            ),
            child: Row(
              mainAxisAlignment: .center,
              children: [
                // Icon(Icons),
                SizedBox(width: 10),
                const Text("Continue With Google"),
              ],
            ),
            onPressed: () {
              _auth.signInWithGoogle();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              // backgroundColor: Colors.blue,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black26),
              ),
            ),

            child: Row(
              mainAxisAlignment: .center,
              children: [
                // Icon(Icons.phone_android_outlined),
                // SizedBox(width: 10),
                const Text("Continue With Phone"),
              ],
            ),
            onPressed: () {
              Get.to(() => PhoneSignInScreen());
            },
          ),
        ],
      ),
    );
  }
}
