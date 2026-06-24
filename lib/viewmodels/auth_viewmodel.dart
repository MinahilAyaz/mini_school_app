import 'package:flutter/foundation.dart';
import 'package:student_hub/models/user_model.dart';
import 'package:student_hub/services/auth_service.dart';
import 'package:student_hub/utils/exceptions.dart';

/// Authentication ViewModel using Provider for state management
///
/// Responsibilities:
/// - Manage login/logout state
/// - Handle authentication errors
/// - Persist session
/// - Show loading indicators
/// - Validate form inputs
///
/// State properties:
/// - isLoading: Show loading indicator
/// - isLoggedIn: User is authenticated
/// - currentUser: Currently logged-in user
/// - errorMessage: Error to display in UI
class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  // ============ State Properties ============

  /// Loading state - true while API call is in progress
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Authentication state - true if user is logged in
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  /// Currently logged-in user
  User? _currentUser;
  User? get currentUser => _currentUser;

  /// Error message to display in UI (null if no error)
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // ============ Constructor ============

  /// Constructor - check if user was previously logged in
  AuthViewModel({required AuthService authService})
    : _authService = authService {
    _initializeSession();
  }

  // ============ Public Methods ============

  /// Login with email and password
  /// Steps:
  /// 1. Set isLoading = true (show loading indicator)
  /// 2. Call authService.login()
  /// 3. If success: save user, set isLoggedIn = true
  /// 4. If error: set appropriate error message
  /// 5. Always: set isLoading = false at the end
  Future<void> login({required String email, required String password}) async {
    try {
      // Clear previous error
      _errorMessage = null;
      _isLoading = true;
      notifyListeners();

      // Call service
      final user = await _authService.login(email: email, password: password);

      // Success
      _currentUser = user;
      _isLoggedIn = true;
      _errorMessage = null;
    } on ValidationException catch (e) {
      // Form validation error
      _errorMessage = e.message;
      _isLoggedIn = false;
    } on AuthException catch (e) {
      // Invalid credentials
      _errorMessage = e.message;
      _isLoggedIn = false;
    } on NetworkException catch (e) {
      // No internet
      _errorMessage = e.message;
      _isLoggedIn = false;
    } on ServerException catch (e) {
      // Server error
      _errorMessage = e.message;
      _isLoggedIn = false;
    } catch (e) {
      // Unknown error
      _errorMessage = 'An unexpected error occurred. Please try again.';
      _isLoggedIn = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Logout and clear session
  /// Steps:
  /// 1. Set isLoading = true
  /// 2. Call authService.logout()
  /// 3. Clear user data
  /// 4. Set isLoggedIn = false
  Future<void> logout() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authService.logout();

      _currentUser = null;
      _isLoggedIn = false;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Logout failed. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear error message (called when user dismisses error)
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // ============ Private Methods ============

  /// Initialize session on app startup
  /// Check if user was previously logged in (session persistence)
  void _initializeSession() {
    if (_authService.isLoggedIn) {
      _currentUser = _authService.currentUser;
      _isLoggedIn = true;
    }
  }
}
