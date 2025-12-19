import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  // AppSnackBar._();

  static void success(String title, String message) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  static void error(String title, String message) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  static void info(String title, String message) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.black,
      backgroundColor: Colors.blue.shade100,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }
}