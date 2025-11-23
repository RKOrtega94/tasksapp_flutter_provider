import 'package:flutter/material.dart';

enum SnackbarType { success, error, warning }

void showSnackbar(
  BuildContext context,
  String message, {
  SnackbarType type = SnackbarType.success,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: type == SnackbarType.success
          ? Colors.green
          : type == SnackbarType.error
          ? Colors.red
          : Colors.orange,
    ),
  );
}
