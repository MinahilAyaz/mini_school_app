import 'package:flutter/material.dart';

/// Loading indicator widget
///
/// Shows a centered loading spinner with optional message
///
/// Usage:
/// ```
/// if (isLoading) {
///   LoadingWidget(message: 'Loading students...');
/// }
/// ```
class LoadingWidget extends StatelessWidget {
  /// Optional message to display below spinner
  final String? message;

  /// Size of the spinner
  final double size;

  const LoadingWidget({Key? key, this.message, this.size = 50})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          if (message != null) ...[
            SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// Centered loading widget for full screen
///
/// Usage:
/// ```
/// if (isLoading && students.isEmpty) {
///   CenteredLoadingWidget();
/// }
/// ```
class CenteredLoadingWidget extends StatelessWidget {
  final String? message;

  const CenteredLoadingWidget({Key? key, this.message = 'Loading...'})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoadingWidget(message: message));
  }
}
