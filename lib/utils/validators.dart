/// Email validator
/// Validates email format using regex pattern
/// Returns error message if invalid, null if valid

class Validators {
  Validators._(); // Private constructor

  // ============ Email Validation ============

  /// Validate email format
  /// Returns null if valid, error message if invalid
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // ============ Password Validation ============

  /// Validate password strength

  /// Requirements:
  /// - At least 4 characters
  /// - At least one number (optional for simplicity)
  /// Returns null if valid, error message if invalid
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }

  // ============ Name Validation ============

  /// Validate name/full name

  /// Requirements:
  /// - Not empty
  /// - At least 2 characters
  /// - Only letters, spaces, and hyphens
  /// Returns null if valid, error message if invalid
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required';
    }

    if (name.length < 2) {
      return 'Name must be at least 2 characters';
    }

    final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegex.hasMatch(name)) {
      return 'Name can only contain letters, spaces, and hyphens';
    }

    return null;
  }

  // ============ Phone Validation ============

  /// Validate phone number format

  /// Accepts various formats:
  /// - 123-456-7890
  /// - (123) 456-7890
  /// - 1234567890
  /// - +1 123 456 7890

  /// Returns null if valid, error message if invalid
  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digits
    final digitsOnly = phone.replaceAll(RegExp(r'[^\d]'), '');

    // Check if at least 10 digits
    if (digitsOnly.length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    return null;
  }

  // ============ URL Validation ============

  /// Validate URL format
  /// Returns null if valid, error message if invalid
  static String? validateUrl(String? url) {
    if (url == null || url.isEmpty) {
      return 'URL is required';
    }

    final urlRegex = RegExp(
      r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&/=]*)$',
    );

    if (!urlRegex.hasMatch(url)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  // ============ Generic Field Validation ============

  /// Validate required field (not empty)
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate minimum length
  static String? validateMinLength(String? value, int minLength) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < minLength) {
      return 'Must be at least $minLength characters';
    }
    return null;
  }

  /// Validate maximum length
  static String? validateMaxLength(String? value, int maxLength) {
    if (value != null && value.length > maxLength) {
      return 'Must not exceed $maxLength characters';
    }
    return null;
  }
}
