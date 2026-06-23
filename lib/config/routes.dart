import 'package:flutter/material.dart';
import 'package:mini_school_app/screens/login/login_screen.dart';
import 'package:mini_school_app/screens/student_list/student_list_screen.dart';

/// App route names
class Routes {
  Routes._(); // Private constructor to prevent instantiation

  static const String login = '/login';
  static const String studentList = '/student-list';
  static const String studentDetail = '/student-detail';
  static const String profile = '/profile';
}

/// Route generator for named routes
class RouteGenerator {
  /// Generate routes based on route name
  ///
  /// Example:
  /// ```
  /// Navigator.of(context).pushNamed(Routes.studentList);
  /// ```
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.studentList:
        return MaterialPageRoute(builder: (_) => const StudentListScreen());

      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
