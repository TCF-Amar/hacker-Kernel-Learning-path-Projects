import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_project/routes/app_routes.dart';
import 'package:my_project/src/controllers/firebase_auth_controller.dart';

class AuthGuardMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<FirebaseAuthController>();
    if (auth.firebaseUser.value == null) {
      return const RouteSettings(name: AppRoutes.signIn);
    }
    return null;
  }
}
