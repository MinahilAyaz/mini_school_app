import 'package:flutter/foundation.dart';
import 'package:mini_school_app/models/user_model.dart';
import 'package:mini_school_app/services/auth_service.dart';

/// Profile/User ViewModel using Provider
///
/// Responsibilities:
/// - Display logged-in user information
/// - Handle logout
/// - Manage user preferences
///
/// State properties:
/// - currentUser: Logged-in user info
/// - isLoading: Show loading during logout
/// - errorMessage: Error messages
class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService;

  // ============ State Properties ============

  /// Current logged-in user
  User? get currentUser => _authService.currentUser;

  /// Loading state (during logout)
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Error message
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // ============ Constructor ============

  ProfileViewModel({required AuthService authService})
    : _authService = authService;

  // ============ Public Methods ============

  /// Logout and navigate to login
  ///
  /// Steps:
  /// 1. Set isLoading = true
  /// 2. Call authService.logout()
  /// 3. If success: caller should navigate to login
  /// 4. If error: show error message
  ///
  /// Example:
  /// ```
  /// await viewModel.logout();
  /// // Navigate to login screen
  /// ```
  Future<void> logout() async {
    try {
      _errorMessage = null;
      _isLoading = true;
      notifyListeners();

      await _authService.logout();
    } catch (e) {
      _errorMessage = 'Failed to logout. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
