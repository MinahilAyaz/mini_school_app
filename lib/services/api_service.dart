import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_school_app/config/app_constants.dart';
import 'package:mini_school_app/utils/exceptions.dart';

/// Base API service handling all HTTP requests
///
/// Responsibilities:
/// - Making HTTP requests (GET, POST, etc)
/// - Error handling (converts exceptions to custom types)
/// - Header management (authentication tokens)
/// - Response parsing and validation
class ApiService {
  /// HTTP client instance
  final http.Client _httpClient;

  /// Authentication token (set after login)
  String? _authToken;

  /// Constructor
  ApiService({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  // ============ Public Methods ============

  /// Set authentication token (called after successful login)
  void setAuthToken(String token) {
    _authToken = token;
  }

  /// Clear authentication token (called on logout)
  void clearAuthToken() {
    _authToken = null;
  }

  /// Check if user is authenticated
  bool get isAuthenticated => _authToken != null;

  /// Get current authentication token
  String? get authToken => _authToken;

  // ============ HTTP Methods ============

  /// Perform GET request
  ///
  /// Example:
  /// ```
  /// final response = await apiService.get('/users');
  /// final users = response.map((u) => User.fromJson(u)).toList();
  /// ```
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParameters,
    bool requiresAuth = false,
  }) async {
    try {
      final Uri uri = Uri.parse(
        endpoint,
      ).replace(queryParameters: queryParameters);

      final response = await _httpClient
          .get(uri, headers: _getHeaders(requiresAuth: requiresAuth))
          .timeout(
            Duration(seconds: AppConstants.requestTimeoutSeconds),
            onTimeout: () => throw TimeoutException('Request timeout'),
          );

      return _handleResponse(response);
    } catch (e) {
      throw _handleException(e);
    }
  }

  /// Perform POST request
  ///
  /// Example:
  /// ```
  /// final response = await apiService.post(
  ///   '/login',
  ///   body: {'email': 'test@example.com', 'password': '123456'},
  /// );
  /// final token = response['token'];
  /// ```
  Future<dynamic> post(
    String endpoint, {
    required Map<String, dynamic> body,
    Map<String, String>? queryParameters,
    bool requiresAuth = false,
  }) async {
    try {
      final Uri uri = Uri.parse(
        endpoint,
      ).replace(queryParameters: queryParameters);

      final response = await _httpClient
          .post(
            uri,
            headers: _getHeaders(requiresAuth: requiresAuth),
            body: jsonEncode(body),
          )
          .timeout(
            Duration(seconds: AppConstants.requestTimeoutSeconds),
            onTimeout: () => throw TimeoutException('Request timeout'),
          );

      return _handleResponse(response);
    } catch (e) {
      throw _handleException(e);
    }
  }

  /// Perform PUT request (for updates)
  Future<dynamic> put(
    String endpoint, {
    required Map<String, dynamic> body,
    bool requiresAuth = false,
  }) async {
    try {
      final response = await _httpClient
          .put(
            Uri.parse(endpoint),
            headers: _getHeaders(requiresAuth: requiresAuth),
            body: jsonEncode(body),
          )
          .timeout(
            Duration(seconds: AppConstants.requestTimeoutSeconds),
            onTimeout: () => throw TimeoutException('Request timeout'),
          );

      return _handleResponse(response);
    } catch (e) {
      throw _handleException(e);
    }
  }

  /// Perform DELETE request
  Future<dynamic> delete(String endpoint, {bool requiresAuth = false}) async {
    try {
      final response = await _httpClient
          .delete(
            Uri.parse(endpoint),
            headers: _getHeaders(requiresAuth: requiresAuth),
          )
          .timeout(
            Duration(seconds: AppConstants.requestTimeoutSeconds),
            onTimeout: () => throw TimeoutException('Request timeout'),
          );

      return _handleResponse(response);
    } catch (e) {
      throw _handleException(e);
    }
  }

  // ============ Private Helper Methods ============

  /// Build request headers
  ///
  /// Includes:
  /// - Content-Type: application/json
  /// - Authorization: Bearer token (if authenticated)
  Map<String, String> _getHeaders({bool requiresAuth = false}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add authorization token if required and available
    if (requiresAuth && _authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  /// Handle HTTP response
  ///
  /// - 200-299: Parse and return response
  /// - 400-499: Throw AuthException or ValidationException
  /// - 500-599: Throw ServerException
  /// - Others: Throw UnknownException
  dynamic _handleResponse(http.Response response) {
    try {
      // Parse response body
      final body = response.body;
      final decoded = jsonDecode(body) as dynamic;

      // Success response (200-299)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded;
      }

      // Client error (400-499)
      if (response.statusCode >= 400 && response.statusCode < 500) {
        if (response.statusCode == 401 || response.statusCode == 403) {
          // Authentication error
          final errorMessage = decoded is Map
              ? (decoded['error'] ?? 'Unauthorized')
              : 'Unauthorized access';

          throw AuthException(
            message: errorMessage,
            code: 'HTTP_${response.statusCode}',
          );
        } else if (response.statusCode == 422 || response.statusCode == 400) {
          // Validation error
          final errorMessage = decoded is Map
              ? (decoded['message'] ?? decoded['error'] ?? 'Invalid request')
              : 'Invalid request data';

          throw ValidationException(
            message: errorMessage,
            code: 'HTTP_${response.statusCode}',
          );
        } else {
          throw UnknownException(
            message: decoded is Map
                ? (decoded['message'] ?? 'Client error')
                : 'Client error occurred',
          );
        }
      }

      // Server error (500-599)
      if (response.statusCode >= 500) {
        throw ServerException(
          message: 'Server error occurred. Please try again later.',
          code: 'HTTP_${response.statusCode}',
          statusCode: response.statusCode,
        );
      }

      // Unknown status code
      throw UnknownException(
        message: 'Unexpected response status: ${response.statusCode}',
      );
    } on AppException {
      // Re-throw app exceptions
      rethrow;
    } catch (e) {
      // Catch parsing errors
      throw ParsingException(
        message: 'Failed to parse response data',
        originalException: e,
      );
    }
  }

  /// Handle exceptions from HTTP calls
  ///
  /// Converts various exception types to custom exceptions:
  /// - SocketException → NetworkException
  /// - TimeoutException → NetworkException
  /// - AppException → re-throw
  /// - Others → UnknownException
  AppException _handleException(dynamic exception) {
    // Already an app exception
    if (exception is AppException) {
      return exception;
    }

    // Network errors
    if (exception is SocketException) {
      return NetworkException(
        message: 'No internet connection. Please check your connection.',
        code: 'NO_INTERNET',
        originalException: exception,
      );
    }

    if (exception is TimeoutException) {
      return NetworkException(
        message: 'Request timeout. Please check your connection and try again.',
        code: 'REQUEST_TIMEOUT',
        originalException: exception,
      );
    }

    if (exception is IOException) {
      return NetworkException(
        message: 'Network error occurred. Please try again.',
        code: 'NETWORK_ERROR',
        originalException: exception,
      );
    }

    // Unknown error
    return UnknownException(
      message: 'An unexpected error occurred',
      originalException: exception,
    );
  }
}
