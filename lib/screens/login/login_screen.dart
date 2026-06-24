import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/config/app_theme.dart';
import 'package:student_hub/viewmodels/auth_viewmodel.dart';

/// Login Screen
/// Features:
/// - Email and password input with validation
/// - Login button with loading indicator
/// - Error message display
/// - Test credentials button (for development)
/// - Auto-navigation to student list on success
/// - Form validation feedback
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ============ Form Controllers ============
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  // ============ Form State ============
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get auth viewmodel
    final authViewModel = context.watch<AuthViewModel>();

    // Auto-navigate to student list on successful login
    if (authViewModel.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/student-list');
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ============ Logo / Header ============
                SizedBox(height: 60),

                // App Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.school_rounded,
                    size: 60,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 32),

                // Title
                Text(
                  'StudentHub',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 12),

                // Subtitle
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 48),

                // ============ Login Form ============
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // ============ Email Field ============
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your username',
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: 'Username',
                        ),
                        keyboardType: TextInputType.text,
                        enabled: !authViewModel.isLoading,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Username is required';
                          }

                          return null;
                        },
                        onChanged: (_) {
                          if (authViewModel.errorMessage != null) {
                            authViewModel.clearError();
                          }
                        },
                      ),
                      SizedBox(height: 16),

                      // ============ Password Field ============
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock_outlined),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscurePassword,
                        enabled: !authViewModel.isLoading,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        onChanged: (_) {
                          if (authViewModel.errorMessage != null) {
                            authViewModel.clearError();
                          }
                        },
                      ),

                      SizedBox(height: 24),

                      // ============ Error Message ============
                      if (authViewModel.errorMessage != null)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.error,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: AppColors.error),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  authViewModel.errorMessage!,
                                  style: TextStyle(
                                    color: AppColors.error,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (authViewModel.errorMessage != null)
                        SizedBox(height: 20),

                      // ============ Login Button ============
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: authViewModel.isLoading
                              ? null
                              : () => _handleLogin(context, authViewModel),
                          child: authViewModel.isLoading
                              ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.textPrimary,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============ Private Methods ============

  /// Handle login button press
  /// Steps:
  /// 1. Validate form
  /// 2. Call viewModel.login()
  /// 3. Auto-navigation handled in Consumer above
  void _handleLogin(BuildContext context, AuthViewModel viewModel) async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Call login
    await viewModel.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }
}
