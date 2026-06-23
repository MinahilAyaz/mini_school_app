import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mini_school_app/config/app_constants.dart';
import 'package:mini_school_app/models/user_model.dart';
import 'package:mini_school_app/utils/exceptions.dart';
import 'api_service.dart';

/// Service for handling authentication (login/logout)
///
/// Responsibilities:
/// - Login with email and password
/// - Logout and clear session
/// - Persist authentication token
/// - Retrieve stored user data
class AuthService {
  final ApiService _apiService;
  final SharedPreferences _prefs;

  /// Constructor
  AuthService({
    required ApiService apiService,
    required SharedPreferences prefs,
  }) : _apiService = apiService,
       _prefs = prefs {
    // Try to restore session on initialization
    _restoreSession();
  }

  // ============ Public Methods ============

  /// Login with email and password
  ///
  /// Makes API call to reqres.in login endpoint
  /// On success:
  /// - Saves token to SharedPreferences
  /// - Saves email to SharedPreferences
  /// - Sets token in ApiService
  ///
  /// Throws:
  /// - ValidationException: If email/password empty
  /// - AuthException: If credentials invalid
  /// - NetworkException: If no internet
  /// - ServerException: If server error
  ///
  /// Example:
  /// ```
  /// final user = await authService.login('test@example.com', 'password');
  /// print(user.token); // Success!
  /// ```
  Future<User> login({required String email, required String password}) async {
    // Validate inputs
    if (email.isEmpty) {
      throw ValidationException(
        message: 'Email cannot be empty',
        code: 'EMPTY_EMAIL',
      );
    }

    if (password.isEmpty) {
      throw ValidationException(
        message: 'Password cannot be empty',
        code: 'EMPTY_PASSWORD',
      );
    }

    if (!_isValidEmail(email)) {
      throw ValidationException(
        message: 'Please enter a valid email',
        code: 'INVALID_EMAIL_FORMAT',
      );
    }

    try {
      // Make API call
      final response = await _apiService.post(
        AppConstants.loginEndpoint,
        body: {'email': email, 'password': password},
      );

      // Create user from response
      final user = User.fromJson({
        'id': email.hashCode.toString(),
        'email': email,
        'token': response['token'] ?? '',
      });

      // Save to local storage
      await _saveUserSession(user);

      // Set token in API service
      _apiService.setAuthToken(user.token);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Logout and clear session
  ///
  /// - Clears stored token
  /// - Clears stored user data
  /// - Clears token from ApiService
  ///
  /// Example:
  /// ```
  /// await authService.logout();
  /// ```
  Future<void> logout() async {
    try {
      await _prefs.remove(AppConstants.tokenKey);
      await _prefs.remove(AppConstants.userKey);
      await _prefs.remove(AppConstants.userEmailKey);

      _apiService.clearAuthToken();
    } catch (e) {
      throw UnknownException(message: 'Failed to logout', originalException: e);
    }
  }

  /// Check if user is currently logged in
  bool get isLoggedIn => _apiService.isAuthenticated;

  /// Get stored user data (if available)
  User? get currentUser => _currentUser;
  User? _currentUser;

  /// Get stored auth token
  String? get authToken => _apiService.authToken;

  // ============ Private Helper Methods ============

  /// Restore session from local storage
  /// Called on initialization to check if user was previously logged in
  void _restoreSession() {
    try {
      final userJson = _prefs.getString(AppConstants.userKey);
      final token = _prefs.getString(AppConstants.tokenKey);

      if (userJson != null && token != null) {
        // Restore user
        final user = User.fromJson(jsonDecode(userJson));
        _currentUser = user;

        // Restore token in API service
        _apiService.setAuthToken(token);
      }
    } catch (e) {
      // Silently fail - user will need to login again
      logout();
    }
  }

  /// Save user session to local storage
  Future<void> _saveUserSession(User user) async {
    try {
      await _prefs.setString(AppConstants.userKey, jsonEncode(user.toJson()));
      await _prefs.setString(AppConstants.tokenKey, user.token);
      await _prefs.setString(AppConstants.userEmailKey, user.email);

      _currentUser = user;
    } catch (e) {
      throw UnknownException(
        message: 'Failed to save session',
        originalException: e,
      );
    }
  }

  /// Validate email format
  ///
  /// Simple regex validation
  /// Real validation would use email_validator package
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
