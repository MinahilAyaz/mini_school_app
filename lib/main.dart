import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:student_hub/screens/splash/splash_screen.dart';
import 'package:student_hub/screens/student_list/student_list_screen.dart';
import 'config/app_theme.dart';
import 'config/routes.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/student_service.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/student_list_viewmodel.dart';
import 'viewmodels/student_detail_viewmodel.dart';
import 'viewmodels/profile_viewmodel.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences for local storage
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

/// Root application widget
/// Responsibilities:
/// - Setup Provider with all services and viewmodels
/// - Configure themes (light and dark)
/// - Setup navigation
/// - Provide initial screen based on auth state

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    // Initialize services
    final httpClient = http.Client();
    final apiService = ApiService(httpClient: httpClient);
    final authService = AuthService(apiService: apiService, prefs: prefs);
    final studentService = StudentService(apiService: apiService);

    return MultiProvider(
      // ============ Provide Services ============
      // These are available throughout the app
      // Use context.read<ServiceType>() to access
      providers: [
        // API service (base HTTP client)
        Provider<ApiService>(create: (_) => apiService),

        // Authentication service
        Provider<AuthService>(create: (_) => authService),

        // Student service
        Provider<StudentService>(create: (_) => studentService),

        // ============ Provide ViewModels ============
        // These use services and manage state
        // Use context.watch<ViewModelType>() to listen to changes
        // Use context.read<ViewModelType>() to access without listening
        /// Authentication ViewModel
        /// Manages login/logout state and current user
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) =>
              AuthViewModel(authService: context.read<AuthService>()),
        ),

        /// Student List ViewModel
        /// Manages list of students, loading, error states
        ChangeNotifierProvider<StudentListViewModel>(
          create: (context) => StudentListViewModel(
            studentService: context.read<StudentService>(),
          ),
        ),

        /// Student Detail ViewModel
        /// Manages single student detail view
        ChangeNotifierProvider<StudentDetailViewModel>(
          create: (context) => StudentDetailViewModel(
            studentService: context.read<StudentService>(),
          ),
        ),

        /// Profile ViewModel
        /// Manages user profile and logout
        ChangeNotifierProvider<ProfileViewModel>(
          create: (context) => ProfileViewModel(
            authService: context.read<AuthService>(),
            prefs: prefs,
          ),
        ),
      ],

      // ============ Material App Configuration ============
      child: Consumer<ProfileViewModel>(
        builder: (context, profileViewModel, _) {
          return MaterialApp(
            title: 'StudentHub',
            debugShowCheckedModeBanner: false,

            // ============ Themes ============
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: profileViewModel.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,

            // ============ Routing ============
            onGenerateRoute: RouteGenerator.generateRoute,

            // ============ Initial Route ============

            // Show login if not authenticated, else show student list
            home: Consumer<AuthViewModel>(
              builder: (context, authViewModel, _) {
                if (authViewModel.isLoggedIn) {
                  // User is logged in, show student list
                  return const StudentListScreen();
                } else {
                  // User not logged in, show login
                  return const SplashScreen();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
