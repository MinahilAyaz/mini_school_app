import 'package:flutter/material.dart';
import 'package:mini_school_app/screens/profile/profile_screen.dart';
import 'package:mini_school_app/screens/student_detail/student_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:mini_school_app/config/app_theme.dart';
import 'package:mini_school_app/viewmodels/auth_viewmodel.dart';
import 'package:mini_school_app/viewmodels/student_list_viewmodel.dart';
import 'package:mini_school_app/widgets/loading_widget.dart';
import 'package:mini_school_app/widgets/error_widget.dart';
import 'package:mini_school_app/widgets/empty_state_widget.dart';
import 'package:mini_school_app/widgets/student_card.dart';

/// Student List Screen
/// Features:
/// - Display list of students in cards
/// - Pull-to-refresh to reload
/// - Search/filter students
/// - Tap student to view details
/// - Loading, error, empty states
/// - Logout button in app bar
class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  // ============ Search State ============
  late TextEditingController _searchController;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentListViewModel = context.watch<StudentListViewModel>();

    return WillPopScope(
      onWillPop: () async {
        // Handle back press - clear search if searching
        if (_isSearching) {
          _clearSearch();
          return false;
        }
        return true;
      },
      child: Scaffold(
        // ============ App Bar ============
        appBar: AppBar(
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search students...',
                    hintStyle: TextStyle(color: Theme.of(context).hintColor),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      onPressed: _clearSearch,
                    ),
                  ),
                )
              : Text('Students'),
          elevation: 0,
          actions: [
            if (!_isSearching)
              IconButton(icon: Icon(Icons.search), onPressed: _startSearch),
            if (!_isSearching)
              IconButton(
                icon: Icon(Icons.person_outline),
                onPressed: () => _navigateToProfile(context),
                tooltip: 'Profile',
              ),
          ],
        ),

        // ============ Body ============
        body: Stack(
          children: [
            // Main content
            _buildContent(context, studentListViewModel),

            // Error banner (top-level)
            if (studentListViewModel.errorMessage != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ErrorBannerWidget(
                  message: studentListViewModel.errorMessage!,
                  onDismiss: studentListViewModel.clearError,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============ Content Builder ============

  Widget _buildContent(BuildContext context, StudentListViewModel viewModel) {
    // Show loading spinner on initial load
    if (viewModel.isLoading && viewModel.students.isEmpty) {
      return LoadingWidget(message: 'Loading students...');
    }

    // Show error screen if error and no data
    if (viewModel.errorMessage != null && viewModel.students.isEmpty) {
      return ErrorDisplayWidget(
        message: viewModel.errorMessage!,
        onRetry: viewModel.retryLoad,
        isInline: true,
      );
    }

    // Show empty state if no students
    if (viewModel.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.person_outline,
        title: 'No Students Found',
        message: 'No students in the system yet.',
        onAction: viewModel.fetchStudents,
        actionText: 'Refresh',
      );
    }

    // Show search empty state if search has no results
    if (_isSearching &&
        viewModel.searchQuery.isNotEmpty &&
        viewModel.filteredStudents.isEmpty) {
      return SearchEmptyStateWidget(
        query: viewModel.searchQuery,
        onClear: _clearSearch,
      );
    }

    // Show list with pull-to-refresh
    return RefreshIndicator(
      onRefresh: viewModel.fetchStudents,
      backgroundColor: AppColors.primaryBlue,
      color: Colors.white,
      child: ListView.builder(
        itemCount: viewModel.filteredStudents.length,
        padding: EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final student = viewModel.filteredStudents[index];
          return StudentCard(
            student: student,
            onTap: () => _navigateToDetail(context, student.id),
          );
        },
      ),
    );
  }

  // ============ Private Methods ============

  /// Start search mode
  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  /// Clear search and return to normal view
  void _clearSearch() {
    _searchController.clear();
    context.read<StudentListViewModel>().clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  /// Handle search input changes
  void _onSearchChanged() {
    context.read<StudentListViewModel>().searchStudents(_searchController.text);
  }

  /// Navigate to student detail screen
  void _navigateToDetail(BuildContext context, int studentId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StudentDetailScreen(studentId: studentId),
      ),
    );
  }

  /// Handle logout
  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              await context.read<AuthViewModel>().logout();
              // Auto-navigate to login happens in main.dart Consumer
            },
            child: Text('Logout', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

/// Navigate to profile screen
void _navigateToProfile(BuildContext context) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
}
