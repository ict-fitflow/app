import 'package:flutter/material.dart';

class GlobalSnackbar {
  static final key = GlobalKey<ScaffoldMessengerState>();

  static showMessage(String text) {
    final snackBar = SnackBar(
        content: Text(text)
    );
    key.currentState?.showSnackBar(snackBar);
  }

  static showSuccess(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.green,
    );
    key.currentState?.showSnackBar(snackBar);
  }

  static showError(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );
    key.currentState?.showSnackBar(snackBar);
  }

}