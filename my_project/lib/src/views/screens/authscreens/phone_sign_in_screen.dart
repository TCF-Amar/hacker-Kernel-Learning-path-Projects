import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/src/controllers/firebase_auth_controller.dart';
import 'package:my_project/src/views/widgets/app_text_field.dart';
import 'package:my_project/src/views/widgets/button_text.dart';

class PhoneSignInScreen extends StatefulWidget {
  const PhoneSignInScreen({super.key});

  @override
  State<PhoneSignInScreen> createState() => _PhoneSignInScreenState();
}

class _PhoneSignInScreenState extends State<PhoneSignInScreen> {
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _auth = Get.find<FirebaseAuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in with phone number"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Text("Sign in with phone number"),
              const SizedBox(height: 10),
              AppTextField(
                controller: phoneController,
                label: "Phone Number",
                hint: "9876543210",
                keyboardType: TextInputType.phone,
                prefixText: "+91",
              ),
              SizedBox(height: 10),
              ButtonText(
                action: () {
                  String phoneNumber = "+91${phoneController.text}";
                  _auth.sendOtp(phoneNumber);
                },
                text: "Verify Number",
                loading: _auth.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
