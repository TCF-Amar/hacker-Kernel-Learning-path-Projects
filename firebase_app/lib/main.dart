import 'package:firebase_app/RootPage.dart';
import 'package:firebase_app/firebase_options.dart';
import 'package:firebase_app/services/firebase/firebase_auth_services.dart';
import 'package:firebase_app/src/controllers/firebase_auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(FirebaseAuthServices(), permanent: true);
  Get.put(FirebaseAuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthServices auth = Get.find<FirebaseAuthServices>();

    return GetMaterialApp(debugShowCheckedModeBanner: false, home: RootPage());
  }
}
