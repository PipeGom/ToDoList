import 'package:flutter/material.dart';

class MySnackbar {
  static void show(BuildContext? context, String text) {
    if (context == null) return;

    FocusScope.of(context).requestFocus(new FocusNode());

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromARGB(255, 255, 123, 0),
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      backgroundColor: Color.fromARGB(255, 253, 228, 199),
      duration: Duration(seconds: 3),
    ));
  }
}
