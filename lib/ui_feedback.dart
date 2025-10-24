import 'package:flutter/material.dart';

void showSnack(BuildContext context, String message, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: color),
  );
}

Future<T> withLoading<T>(BuildContext context, Future<T> Function() task) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );
  try {
    return await task();
  } finally {
    Navigator.of(context, rootNavigator: true).pop();
  }
}


