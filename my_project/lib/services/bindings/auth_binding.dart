import 'package:get/get.dart';
import 'package:my_project/src/controllers/firebase_auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseAuthController(),  permanent: true);
  }

}