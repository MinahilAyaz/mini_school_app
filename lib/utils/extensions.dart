import 'package:intl/intl.dart';

// ============ String Extensions ============

/// String extension methods
extension StringExtension on String {
  /// Capitalize first letter of string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Check if string is a valid email
  bool isValidEmail() {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Check if string contains only digits
  bool isNumeric() {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  /// Truncate string to max length with ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// Remove all whitespace from string
  String removeWhitespace() {
    return replaceAll(' ', '');
  }

  /// Check if string is URL
  bool isUrl() {
    final urlRegex = RegExp(
      r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&/=]*)$',
    );
    return urlRegex.hasMatch(this);
  }

  /// Add http:// to URL if not present
  String toUrl() {
    if (startsWith('http://') || startsWith('https://')) {
      return this;
    }
    return 'http://$this';
  }
}

// ============ DateTime Extensions ============

/// DateTime extension methods
extension DateTimeExtension on DateTime {
  /// Format DateTime as readable date

  String formattedDate() {
    return DateFormat('MMM dd, yyyy').format(this);
  }

  /// Format DateTime as readable date and time
  String formattedDateTime() {
    return DateFormat('MMM dd, yyyy h:mm a').format(this);
  }

  /// Format DateTime as time only
  String formattedTime() {
    return DateFormat('h:mm a').format(this);
  }

  /// Check if date is today
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool isYesterday() {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool isTomorrow() {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Get days difference from now
  int daysAgo() {
    final now = DateTime.now();
    final difference = now.difference(this).inDays;
    return difference;
  }
}

// ============ List Extensions ============

/// List extension methods
extension ListExtension<T> on List<T> {
  /// Check if list is empty

  bool get isNotEmpty => length > 0;

  /// Get first element or null

  T? firstOrNull() {
    return isEmpty ? null : first;
  }

  /// Get last element or null
  T? lastOrNull() {
    return isEmpty ? null : last;
  }

  /// Duplicate each element
  List<T> duplicate() {
    return [...this, ...this];
  }

  /// Get unique elements
  List<T> unique() {
    return toSet().toList();
  }
}

// ============ Nullable Extensions ============

/// Nullable extension methods
extension NullableExtension<T> on T? {
  /// Execute function if not null
  R? let<R>(R Function(T value) fn) {
    return this == null ? null : fn(this as T);
  }

  /// Execute function if null
  void ifNull(void Function() fn) {
    if (this == null) fn();
  }
}
