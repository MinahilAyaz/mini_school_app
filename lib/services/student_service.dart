import 'package:student_hub/config/app_constants.dart';
import 'package:student_hub/models/student_model.dart';
import 'package:student_hub/utils/exceptions.dart';

import 'api_service.dart';

/// Service for fetching student data
///
/// Uses JSONPlaceholder API (free, open API)
/// - /users returns list of users (treated as students)
/// - /users/{id} returns single user detail
class StudentService {
  final ApiService _apiService;

  /// Constructor
  StudentService({required ApiService apiService}) : _apiService = apiService;

  // ============ Public Methods ============

  /// Get list of all students
  ///
  /// API: GET https://jsonplaceholder.typicode.com/users
  /// Returns: List of 10 users (treated as students)
  ///
  /// Throws:
  /// - NetworkException: No internet or connection error
  /// - ServerException: 500+ error
  /// - ParsingException: Invalid response format
  Future<List<Student>> getStudents() async {
    try {
      final response = await _apiService.get(AppConstants.getStudentsEndpoint);

      // Handle different response types
      if (response is List) {
        return response
            .map((student) => Student.fromJson(student as Map<String, dynamic>))
            .toList();
      } else if (response is Map) {
        // If API returns paginated response
        final data = response['data'] ?? response['results'] ?? [];
        if (data is List) {
          return data
              .map((s) => Student.fromJson(s as Map<String, dynamic>))
              .toList();
        }
      }

      throw ParsingException(
        message: 'Unexpected response format for students list',
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Get single student by ID
  ///
  /// API: GET https://jsonplaceholder.typicode.com/users/{id}
  /// Returns: Single user with full details
  ///
  /// Parameters:
  /// - id: Student ID (1-10 for JSONPlaceholder)
  ///
  /// Throws:
  /// - ValidationException: If ID is invalid
  /// - NetworkException: No internet or connection error
  /// - ServerException: 500+ error
  /// - ParsingException: Invalid response format
  Future<Student> getStudentDetail(int id) async {
    // Validate input
    if (id <= 0) {
      throw ValidationException(
        message: 'Invalid student ID',
        code: 'INVALID_ID',
      );
    }

    try {
      final endpoint = '${AppConstants.getStudentDetail}/$id';

      final response = await _apiService.get(endpoint);

      if (response is Map<String, dynamic>) {
        return Student.fromJson(response);
      }

      throw ParsingException(
        message: 'Unexpected response format for student detail',
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Search students by name (client-side filtering)
  ///
  /// First fetches all students, then filters locally
  /// Not ideal for large datasets, but works for JSONPlaceholder
  ///
  /// Parameters:
  /// - query: Search term (case-insensitive)
  ///
  /// Returns: Filtered list of students
  Future<List<Student>> searchStudents(String query) async {
    try {
      if (query.isEmpty) {
        return await getStudents();
      }

      final allStudents = await getStudents();
      final lowerQuery = query.toLowerCase();

      return allStudents
          .where(
            (student) =>
                student.name.toLowerCase().contains(lowerQuery) ||
                student.email.toLowerCase().contains(lowerQuery),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
