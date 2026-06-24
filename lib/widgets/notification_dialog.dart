import 'package:flutter/material.dart';

/// A reusable dialog that displays a simple message.
class NotificationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onOk;

  const NotificationDialog({
    Key? key,
    required this.title,
    required this.message,
    this.onOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onOk != null) onOk!();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
