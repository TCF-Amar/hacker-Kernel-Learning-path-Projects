import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> pageTimer() async {
    var time = Duration(seconds: 2);
    return await Future.delayed(time, () {
      Navigator.pushReplacementNamed(context, "/home");
    });
  }
  @override
  void initState() {
    super.initState();
    pageTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Image.asset('assets/images/ic_launcher.png'
        ),
      ),
    );

  }
}