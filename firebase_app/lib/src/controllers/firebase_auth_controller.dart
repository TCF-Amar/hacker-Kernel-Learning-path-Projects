import 'package:firebase_app/services/firebase/firebase_auth_services.dart';
import 'package:firebase_app/src/views/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FirebaseAuthController extends GetxController {
  final FirebaseAuthServices _services = Get.find<FirebaseAuthServices>();
  RxBool loading = false.obs;
  RxString error = ''.obs;

  Future<void> signIn(String email, String password) async {
    loading.value = true;
    error.value = '';
    try {
      await _services.signIn(email, password);
      // After successful sign in, the auth state will change and main.dart will redirect
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          debugPrint('User is currently signed out!');
        } else {
          debugPrint('User is signed in!');
        }
      });
      } catch (e)
      {
        error.value = e.toString();
        debugPrint("Error$e");
      } finally {
      loading.value = false;
    }
  }

  Future<void> signUp(String email, String password) async {
    loading.value = true;
    error.value = '';
    try {
      await _services.signUp(email, password);
      // After successful sign up, the auth state will change and main.dart will redirect
      Get.off(() => const HomeScreen());
    } catch (e) {
      error.value = e.toString();
      debugPrint("Error$e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> signOut() async {
    await _services.signOut();
    // Get.off(() => const HomeScreen());
  }
} 
