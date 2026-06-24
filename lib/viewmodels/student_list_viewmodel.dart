import 'package:flutter/foundation.dart';
import 'package:student_hub/models/student_model.dart';
import 'package:student_hub/services/student_service.dart';
import 'package:student_hub/utils/exceptions.dart';

/// Student List ViewModel using Provider for state management
///
/// Responsibilities:
/// - Fetch list of students from API
/// - Handle loading, success, error, empty states
/// - Support pull-to-refresh
/// - Filter/search students
///
/// State properties:
/// - students: List of fetched students
/// - isLoading: Show loading indicator
/// - errorMessage: Error to display
/// - isEmpty: Show empty state when no students
class StudentListViewModel extends ChangeNotifier {
  final StudentService _studentService;

  // ============ State Properties ============

  /// List of students fetched from API
  List<Student> _students = [];
  List<Student> get students => _students;

  /// Filtered students (after search)
  List<Student> _filteredStudents = [];
  List<Student> get filteredStudents => _filteredStudents;

  /// Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Error message
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Check if list is empty
  bool get isEmpty => _students.isEmpty && !_isLoading;

  /// Current search query
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // ============ Constructor ============

  /// Constructor - fetch students immediately
  StudentListViewModel({required StudentService studentService})
    : _studentService = studentService {
    fetchStudents();
  }

  // ============ Public Methods ============

  /// Fetch students from API
  ///
  /// Steps:
  /// 1. Set isLoading = true
  /// 2. Call studentService.getStudents()
  /// 3. If success: save students list
  /// 4. If error: set error message
  /// 5. Reset search filter
  ///
  /// Used for:
  /// - Initial load
  /// - Pull-to-refresh
  /// - Retry after error
  ///
  /// Example:
  /// ```
  /// await viewModel.fetchStudents();
  /// print(viewModel.students.length); // Number of students
  /// ```
  Future<void> fetchStudents() async {
    try {
      _errorMessage = null;
      _isLoading = true;
      _searchQuery = '';
      _filteredStudents.clear();
      notifyListeners();

      // Fetch from API
      _students = await _studentService.getStudents();

      // Reset filter to show all
      _filteredStudents = List.from(_students);

      if (_students.isEmpty) {
        _errorMessage = null; // No error, just no data
      }
    } on NetworkException catch (e) {
      _errorMessage = e.message;
      _students.clear();
      _filteredStudents.clear();
    } on ServerException catch (e) {
      _errorMessage = e.message;
      _students.clear();
      _filteredStudents.clear();
    } on ParsingException catch (e) {
      _errorMessage = e.message;
      _students.clear();
      _filteredStudents.clear();
    } catch (e) {
      _errorMessage = 'Failed to load students. Please try again.';
      _students.clear();
      _filteredStudents.clear();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Search/filter students by name or email
  ///
  /// Steps:
  /// 1. Update search query
  /// 2. Filter students based on query
  /// 3. Notify listeners
  ///
  /// Example:
  /// ```
  /// await viewModel.searchStudents('john');
  /// // Shows only students with 'john' in name/email
  /// ```
  void searchStudents(String query) {
    _searchQuery = query;

    if (query.isEmpty) {
      _filteredStudents = List.from(_students);
    } else {
      final lowerQuery = query.toLowerCase();
      _filteredStudents = _students
          .where(
            (student) =>
                student.name.toLowerCase().contains(lowerQuery) ||
                student.email.toLowerCase().contains(lowerQuery),
          )
          .toList();
    }

    notifyListeners();
  }

  /// Clear search filter
  void clearSearch() {
    _searchQuery = '';
    _filteredStudents = List.from(_students);
    notifyListeners();
  }

  /// Clear error message (when user dismisses error)
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Retry loading students (called after error)
  Future<void> retryLoad() async {
    await fetchStudents();
  }
}
