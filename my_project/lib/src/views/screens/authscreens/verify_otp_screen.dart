import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/src/controllers/firebase_auth_controller.dart';
import 'package:my_project/src/views/widgets/app_text_field.dart';
import 'package:my_project/src/views/widgets/button_text.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<FirebaseAuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP"), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Text("Verify Otp"),
            AppTextField(
              controller: _otpController,
              hint: "Enter Otp",
              label: "Otp",
              keyboardType: TextInputType.number,

            ),
            SizedBox(height: 20,),
            ButtonText(action: (){
              auth.verifyOtp(otp: _otpController.text);
            }, text: "Verify OTP", loading: auth.isLoading)
          ],
        ),
      ),
    );
  }
}
