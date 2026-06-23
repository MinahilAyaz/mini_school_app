import 'package:flutter/foundation.dart';
import 'package:mini_school_app/models/student_model.dart';
import 'package:mini_school_app/services/student_service.dart';
import 'package:mini_school_app/utils/exceptions.dart';

/// Student Detail ViewModel using Provider
///
/// Responsibilities:
/// - Fetch single student by ID
/// - Display full student details
/// - Handle loading and error states
///
/// State properties:
/// - student: Currently displayed student
/// - isLoading: Show loading indicator
/// - errorMessage: Error to display
class StudentDetailViewModel extends ChangeNotifier {
  final StudentService _studentService;

  // ============ State Properties ============

  /// Currently displayed student
  Student? _student;
  Student? get student => _student;

  /// Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Error message
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // ============ Constructor ============

  /// Constructor
  StudentDetailViewModel({required StudentService studentService})
    : _studentService = studentService;

  // ============ Public Methods ============

  /// Fetch student detail by ID
  ///
  /// Steps:
  /// 1. Validate student ID
  /// 2. Set isLoading = true
  /// 3. Call studentService.getStudentDetail(id)
  /// 4. If success: save student
  /// 5. If error: set error message
  ///
  /// Example:
  /// ```
  /// await viewModel.loadStudentDetail(1);
  /// print(viewModel.student?.name); // Student name
  /// ```
  Future<void> loadStudentDetail(int studentId) async {
    try {
      if (studentId <= 0) {
        throw ValidationException(
          message: 'Invalid student ID',
          code: 'INVALID_ID',
        );
      }

      _errorMessage = null;
      _isLoading = true;
      notifyListeners();

      // Fetch student detail
      _student = await _studentService.getStudentDetail(studentId);
    } on NetworkException catch (e) {
      _errorMessage = e.message;
      _student = null;
    } on ServerException catch (e) {
      _errorMessage = e.message;
      _student = null;
    } on ValidationException catch (e) {
      _errorMessage = e.message;
      _student = null;
    } on ParsingException catch (e) {
      _errorMessage = e.message;
      _student = null;
    } catch (e) {
      _errorMessage = 'Failed to load student details. Please try again.';
      _student = null;
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

  /// Retry loading student
  Future<void> retryLoad(int studentId) async {
    await loadStudentDetail(studentId);
  }
}
