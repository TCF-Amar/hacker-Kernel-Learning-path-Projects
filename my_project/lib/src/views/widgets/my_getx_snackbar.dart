import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyGetxSnackbar {
  Future<void> mySnack({
    required String title,
    required String message,
    bool isError = false,
  }) async {
    Get.snackbar(
      title,
      !isError ? "Success" : message?.toString() ?? "Something went wrong",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.green,
    );
  }
}
