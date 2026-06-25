import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/user_model.dart';
import 'package:student_hub/services/auth_service.dart';

/// Profile/User ViewModel using Provider

/// Responsibilities:
/// - Display logged-in user information
/// - Handle logout
/// - Manage user preferences

/// State properties:
/// - currentUser: Logged-in user info
/// - isLoading: Show loading during logout
/// - errorMessage: Error messages
class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService;
  final SharedPreferences _prefs;

  // ============ State Properties ============

  /// Current logged-in user
  User? get currentUser => _authService.currentUser;

  /// Loading state (during logout)
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Error message
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Theme preference state
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  // ============ Constructor ============

  ProfileViewModel({
    required AuthService authService,
    required SharedPreferences prefs,
  }) : _authService = authService,
       _prefs = prefs {
    _loadThemePreference();
  }

  /// Load preferences from SharedPreferences
  void _loadThemePreference() {
    _isDarkMode = _prefs.getBool('is_dark_mode') ?? false;
    _notificationsEnabled = _prefs.getBool('notifications_enabled') ?? true;
    notifyListeners();
  }

  /// Toggle and save theme preference
  Future<void> toggleTheme(bool value) async {
    _isDarkMode = value;
    await _prefs.setBool('is_dark_mode', value);
    notifyListeners();
  }

  // ============ Public Methods ============

  /// Logout and navigate to login

  /// Steps:
  /// 1. Set isLoading = true
  /// 2. Call authService.logout()
  /// 3. If success: caller should navigate to login
  /// 4. If error: show error message
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

  /// Notification preference state
  bool _notificationsEnabled = true;

  bool get notificationsEnabled => _notificationsEnabled;

  Future<void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    notifyListeners();
    await _prefs.setBool('notifications_enabled', value);
  }
}
