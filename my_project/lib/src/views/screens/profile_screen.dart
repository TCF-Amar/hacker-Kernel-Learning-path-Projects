import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/routes/app_routes.dart';
import 'package:my_project/src/controllers/firebase_auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _auth = Get.find<FirebaseAuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
    body: Center(
      child: Column(
        children: [
          Text("Profile"),
          Text(_auth.user.value?.email?.toString() ?? _auth.user.value!.phoneNumber.toString()),
          TextButton(onPressed: (){
          _auth.signOut();
          }, child: Text("Sing Out"))
        ],
      ),
    ),
    );
  }
}
