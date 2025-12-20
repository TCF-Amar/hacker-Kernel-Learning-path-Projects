import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_project/routes/app_routes.dart';
import 'package:my_project/services/firebase/firebase_auth_services.dart';
import 'package:my_project/services/firebase/firestore/firestore_auth_services.dart';
import 'package:my_project/src/views/widgets/app_snack_bar.dart';

class FirebaseAuthController extends GetxController {
  final FirebaseAuthServices _services = FirebaseAuthServices();
  final firestoreServices = FirestoreAuthServices();


  Rxn<User> firebaseUser = Rxn<User>();
  RxBool isLoading = false.obs;
  RxString verificationId = "".obs;


  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_services.authStateChanges);

    ever(firebaseUser, (user) {
      if (user != null) {
        firestoreServices.getUser(user.uid);
      }

      _handleAuthStateChange(user);
    });
    isLoading.value = false;
  }

  void _handleAuthStateChange(User? firebaseUser) {
    if (firebaseUser == null) {
      Get.offAllNamed(AppRoutes.signIn);
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  Future<void> saveUser() async {
    try {
      isLoading.value = true;
      await firestoreServices.saveUser(firebaseUser.value!);
    } on FirebaseAuthException catch (e) {
      // print(e.message);
      AppSnackBar.error(
          "Sign Up Failed", e.message?.toString() ?? "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      await _services.signIn(email, password);
      // await testController.saveData(name: 'amar', email: 'sdfds');
      AppSnackBar.success("Sign In Success", "You have successfully signed in");
    } on FirebaseAuthException catch (e) {
// print();

      AppSnackBar.error(
          "Sign In Failed", e.message?.toString() ?? "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      await _services.signUp(email, password);
      await saveUser();
      AppSnackBar.success("Sign Up Success", "You have successfully signed up");
    } on FirebaseAuthException catch (e) {
      // print(e.message);
      AppSnackBar.error(
          "Sign Up Failed", e.message?.toString() ?? "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendOtp(String phoneNumber) async {
    try {
      isLoading.value = true;

    await _services.verifyPhone(
        phoneNumber: phoneNumber,
        onCodeSend: (id) {
          verificationId.value = id;
          Get.toNamed(AppRoutes.otp);

          AppSnackBar.success("OTP Sent", "OTP has been sent to your phone");
        },
        onError: (String error) {
          AppSnackBar.error("OTP Failed", error);
        },
      );
    } on FirebaseAuthException catch (e) {
      AppSnackBar.error(
          "OTP Failed", e.message?.toString() ?? "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp({required String otp}) async {
    try {
      isLoading.value = true;
     await _services.verifyOtp(verificationId: verificationId.value, otp: otp);
      await saveUser();
      AppSnackBar.success("Sign Up Success", "You have successfully signed up");
    } on FirebaseAuthException catch (e) {
      AppSnackBar.error(
          "Sign Up Failed", e.message?.toString() ?? "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      await _services.signInWithGoogle();
      await saveUser();
      AppSnackBar.success("Sign In Success", "You have successfully signed in");
    } on FirebaseAuthException catch (e) {
      AppSnackBar.error(
          "Sign In Failed", e.message?.toString() ?? "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future signOut() async {
    await _services.signOut();
    AppSnackBar.success("Sign Out Success", "You have successfully signed out");
  }
}
