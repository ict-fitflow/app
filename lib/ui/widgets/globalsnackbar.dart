import 'package:flutter/material.dart';

class GlobalSnackbar {
  static final key = GlobalKey<ScaffoldMessengerState>();

  static showSuccess(String text) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.green,
    );
    key.currentState?.showSnackBar(snackBar);
  }

  static showError(String text) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.red,
    );
    key.currentState?.showSnackBar(snackBar);
  }

}