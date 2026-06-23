/// App-wide constants and configuration
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  // ============ API Configuration ============

  /// Base URL for authentication API (reqres.in - fake but realistic)
  static const String authBaseUrl = 'https://reqres.in/api';

  /// Base URL for student/user data API (JSONPlaceholder)
  static const String studentBaseUrl = 'https://jsonplaceholder.typicode.com';

  // ============ Authentication Endpoints ============

  /// Login endpoint - POST request
  /// Request body: { "email": "...", "password": "..." }
  /// Response: { "token": "..." } or { "error": "..." }
  static const String loginEndpoint = '$authBaseUrl/login';

  // ============ Student Endpoints ============

  /// Get all students (using JSONPlaceholder users as students)
  /// GET request - returns list of users (treated as students)
  static const String getStudentsEndpoint = '$studentBaseUrl/users';

  /// Get single student by ID
  /// GET request - format: /users/{id}
  static const String getStudentDetail = '$studentBaseUrl/users';

  // ============ HTTP Configuration ============

  /// Timeout duration for HTTP requests (in seconds)
  static const int requestTimeoutSeconds = 30;

  /// Maximum retries for failed requests
  static const int maxRetries = 3;

  // ============ Local Storage Keys ============

  /// Key for storing user token in SharedPreferences
  static const String tokenKey = 'auth_token';

  /// Key for storing user email in SharedPreferences
  static const String userEmailKey = 'user_email';

  /// Key for storing entire user object in SharedPreferences
  static const String userKey = 'user_data';

  // ============ Session Configuration ============

  /// Session timeout in minutes
  /// If no activity for this duration, user needs to login again
  static const int sessionTimeoutMinutes = 30;

  // ============ UI Configuration ============

  /// Delay before showing loading indicator (milliseconds)
  /// Prevents flickering for fast requests
  static const int loadingDelayMs = 500;

  // ============ Test Credentials ============

  /// Valid test email for reqres.in
  /// (Use this for testing login if needed)
  static const String testEmail = 'eve.holt@reqres.in';

  /// Valid test password for reqres.in
  /// (Use this for testing login if needed)
  static const String testPassword = 'cityslickas';
}
