import 'package:flutter/material.dart';
import 'package:mini_school_app/config/app_theme.dart';

class EmptyStateWidget extends StatelessWidget {
  /// Icon to display
  final IconData icon;

  /// Title text
  final String title;

  /// Subtitle/message text
  final String message;

  /// Optional action button callback
  final VoidCallback? onAction;

  /// Optional action button text
  final String actionText;

  const EmptyStateWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.message,
    this.onAction,
    this.actionText = 'Retry',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Icon(icon, size: 80, color: AppColors.primaryBlue.withOpacity(0.3)),

          SizedBox(height: 24),

          // Title
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8),

          // Message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ),

          if (onAction != null) ...[
            SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: onAction,
              icon: Icon(Icons.refresh),
              label: Text(actionText),
            ),
          ],
        ],
      ),
    );
  }
}

/// Empty state for search results
/// Used when search returns no results
class SearchEmptyStateWidget extends StatelessWidget {
  final String query;
  final VoidCallback onClear;

  const SearchEmptyStateWidget({
    Key? key,
    required this.query,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: AppColors.primaryBlue.withOpacity(0.3),
          ),
          SizedBox(height: 24),
          Text(
            'No Results Found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Text(
            'No students match "$query"',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: onClear,
            icon: Icon(Icons.clear),
            label: Text('Clear Search'),
          ),
        ],
      ),
    );
  }
}
