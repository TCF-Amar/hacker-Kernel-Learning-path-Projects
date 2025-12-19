import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  void toastMessage(String msg, bool? err) {
    Fluttertoast.showToast(
      msg: msg,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: err! ? Colors.redAccent : Colors.black26,
      fontSize: 18
    );
  }
}
