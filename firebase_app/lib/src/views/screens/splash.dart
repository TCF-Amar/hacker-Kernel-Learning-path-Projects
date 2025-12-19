import 'package:firebase_app/services/firebase/firebase_auth_services.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Splash Screen")));
  }
}
