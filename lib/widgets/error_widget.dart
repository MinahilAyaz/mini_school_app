import 'package:flutter/material.dart';
import 'package:mini_school_app/config/app_theme.dart';

/// Error display widget
///
/// Shows error message with icon and optional retry button
///
/// Usage:
/// ```
/// if (errorMessage != null) {
///   ErrorDisplayWidget(
///     message: errorMessage,
///     onRetry: () => viewModel.retryLoad(),
///   );
/// }
/// ```
class ErrorDisplayWidget extends StatelessWidget {
  /// Error message to display
  final String message;

  /// Callback when retry button is pressed
  final VoidCallback? onRetry;

  /// Show as inline error (not full screen)
  final bool isInline;

  const ErrorDisplayWidget({
    Key? key,
    required this.message,
    this.onRetry,
    this.isInline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isInline) {
      return _buildInlineError(context);
    }
    return _buildFullScreenError(context);
  }

  /// Inline error (for showing in scrollable list)
  Widget _buildInlineError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: AppColors.error, size: 48),
          SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh),
              label: Text('Try Again'),
            ),
          ],
        ],
      ),
    );
  }

  /// Full screen error
  Widget _buildFullScreenError(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildInlineError(context)));
  }
}

/// Error banner widget for top of screen
///
/// Dismissible error message shown at top
///
/// Usage:
/// ```
/// if (errorMessage != null) {
///   ErrorBannerWidget(
///     message: errorMessage,
///     onDismiss: () => viewModel.clearError(),
///   );
/// }
/// ```
class ErrorBannerWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onDismiss;

  const ErrorBannerWidget({Key? key, required this.message, this.onDismiss})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.error, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppColors.error),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: AppColors.error, fontSize: 14),
            ),
          ),
          if (onDismiss != null)
            IconButton(
              icon: Icon(Icons.close, color: AppColors.error),
              onPressed: onDismiss,
              constraints: BoxConstraints(minWidth: 30, minHeight: 30),
              padding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }
}
