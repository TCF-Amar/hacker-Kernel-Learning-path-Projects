import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/routes/app_routes.dart';
import 'package:my_project/services/firebase/firebase_auth_services.dart';

class FirebaseAuthController extends GetxController {
  final FirebaseAuthServices _services = FirebaseAuthServices();

  Rxn<User> user = Rxn<User>();
  RxBool isLoading = false.obs;
  RxString verificationId = "".obs;


  @override
  void onInit() {
    super.onInit();
    user.bindStream(_services.authStateChanges);
    ever(user, _handleAuthStateChange);
  }

  void _handleAuthStateChange(User? firebaseUser) {
    if (firebaseUser == null) {
      Get.offAllNamed(AppRoutes.signIn);
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  Future<void> signIn(String email, String password) async {
    // isLoading.value = true;
    try {
      isLoading.value = true;
      await _services.signIn(email, password);
      Get.snackbar(
        "Sign In Success",
        "You have successfully signed in",
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      // print(e.message);
      Get.snackbar(
        "Sign In Failed",
        e.message?.toString() ?? "Something went wrong",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      await _services.signUp(email, password);
      Get.snackbar(
        "Sign Up Success",
        "You have successfully signed up",
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      // print(e.message);
      Get.snackbar(
        "Sign Up Failed",
        e.message?.toString() ?? "Something went wrong",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendOtp(String phoneNumber) async {
    try {    isLoading.value = true;

    await _services.verifyPhone(
        phoneNumber: phoneNumber,
        onCodeSend: (id) {
          verificationId.value = id;
          Get.toNamed(AppRoutes.otp);
        },
        onError: (String error) {
          Get.snackbar(
            "Error",
            error,
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Sign Up Failed",
        e.message?.toString() ?? "Something went wrong",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp({required String otp}) async {
    try {
      isLoading.value = true;
     await _services.verifyOtp(verificationId: verificationId.value, otp: otp);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Sign Up Failed",
        e.message?.toString() ?? "Something went wrong",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      await _services.signInWithGoogle();
      Get.snackbar(
        "Sign In Success",
        "You have successfully signed in",
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Sign In Failed",
        e.message?.toString() ?? "Something went wrong",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future signOut() async {
    await _services.signOut();
  }
}
