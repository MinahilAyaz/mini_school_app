/// Base exception class for all app exceptions
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  AppException({required this.message, this.code, this.originalException});

  @override
  String toString() => 'AppException: $message';
}

/// Exception for network-related errors (no internet, connection timeout, etc)

/// When to use:
/// - No internet connection
/// - Connection timeout
/// - Network unreachable
class NetworkException extends AppException {
  NetworkException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'NETWORK_ERROR',
         originalException: originalException,
       );

  @override
  String toString() => 'NetworkException: $message';
}

/// Exception for authentication-related errors (login failed, invalid token, etc)

/// When to use:
/// - Invalid email/password
/// - Token expired
/// - Unauthorized access (401)
/// - Credentials mismatch
class AuthException extends AppException {
  AuthException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'AUTH_ERROR',
         originalException: originalException,
       );

  @override
  String toString() => 'AuthException: $message';
}

/// Exception for form/input validation errors

/// When to use:
/// - Email format invalid
/// - Password too short
/// - Required field empty
/// - Phone number invalid
class ValidationException extends AppException {
  ValidationException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'VALIDATION_ERROR',
         originalException: originalException,
       );

  @override
  String toString() => 'ValidationException: $message';
}

/// Exception for server-side errors (500, 502, 503, etc)

/// When to use:
/// - HTTP 500 Internal Server Error
/// - HTTP 502 Bad Gateway
/// - HTTP 503 Service Unavailable
/// - Server returned error status code
class ServerException extends AppException {
  final int? statusCode;

  ServerException({
    required String message,
    String? code,
    this.statusCode,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'SERVER_ERROR',
         originalException: originalException,
       );

  @override
  String toString() => 'ServerException: $message (HTTP $statusCode)';
}

/// Exception for parsing JSON/data errors

/// When to use:
/// - Invalid JSON response
/// - Unexpected response format
/// - Missing required fields in response
class ParsingException extends AppException {
  ParsingException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'PARSING_ERROR',
         originalException: originalException,
       );

  @override
  String toString() => 'ParsingException: $message';
}

/// Exception for unknown/unexpected errors

/// When to use:
/// - Unexpected error that doesn't fit other categories
/// - Fallback for unknown exceptions
class UnknownException extends AppException {
  UnknownException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
         message: message,
         code: code ?? 'UNKNOWN_ERROR',
         originalException: originalException,
       );

  @override
  String toString() => 'UnknownException: $message';
}
