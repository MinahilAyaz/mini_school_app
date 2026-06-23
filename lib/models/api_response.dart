/// Generic API response wrapper for consistent error/success handling
class ApiResponse<T> {
  final T? data;
  final String? error;
  final int statusCode;
  final bool isSuccess;

  ApiResponse({
    this.data,
    this.error,
    required this.statusCode,
    required this.isSuccess,
  });

  /// Create successful response
  factory ApiResponse.success({required T data, int statusCode = 200}) {
    return ApiResponse(
      data: data,
      error: null,
      statusCode: statusCode,
      isSuccess: true,
    );
  }

  /// Create error response
  factory ApiResponse.error({required String error, required int statusCode}) {
    return ApiResponse(
      data: null,
      error: error,
      statusCode: statusCode,
      isSuccess: false,
    );
  }

  @override
  String toString() => isSuccess
      ? 'ApiResponse.success(statusCode: $statusCode)'
      : 'ApiResponse.error(error: $error, statusCode: $statusCode)';
}
