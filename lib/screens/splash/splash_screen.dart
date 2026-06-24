// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:mini_school_app/config/routes.dart';
// import 'package:mini_school_app/viewmodels/auth_viewmodel.dart';

// /// Splash Screen shown on app launch
// /// Behavior:
// /// - Displays for ~2 seconds with a soft fade-in + scale animation
// /// - Checks authentication state after delay
// /// - Navigates to Student List if logged in, Login otherwise
// /// - Prevents returning to splash via back button (pushNamedAndRemoveUntil)
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
//     );

//     _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
//     );

//     _animationController.forward();
//     _navigateAfterDelay();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> _navigateAfterDelay() async {
//     await Future.delayed(const Duration(milliseconds: 2200));
//     if (!mounted) return;

//     final isLoggedIn = context.read<AuthViewModel>().isLoggedIn;
//     final destination = isLoggedIn ? Routes.studentList : Routes.login;

//     Navigator.of(
//       context,
//     ).pushNamedAndRemoveUntil(destination, (route) => false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return Scaffold(
//       backgroundColor: colorScheme.primary,
//       body: Center(
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: ScaleTransition(
//             scale: _scaleAnimation,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // ============ App Icon ============
//                 Container(
//                   width: 110,
//                   height: 110,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withValues(alpha: 0.18),
//                     borderRadius: BorderRadius.circular(28),
//                     border: Border.all(
//                       color: Colors.white.withValues(alpha: 0.4),
//                       width: 2,
//                     ),
//                   ),
//                   child: const Icon(
//                     Icons.school_rounded,
//                     size: 64,
//                     color: Colors.white,
//                   ),
//                 ),

//                 const SizedBox(height: 32),

//                 // ============ App Name ============
//                 Text(
//                   'Mini School App',
//                   style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 0.5,
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 // ============ Subtitle ============
//                 Text(
//                   'Student Management Portal',
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     color: Colors.white.withValues(alpha: 0.8),
//                     letterSpacing: 0.3,
//                   ),
//                 ),

//                 const SizedBox(height: 64),

//                 // ============ Loading Indicator ============
//                 SizedBox(
//                   width: 28,
//                   height: 28,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2.5,
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       Colors.white.withValues(alpha: 0.7),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_school_app/config/routes.dart';
import 'package:mini_school_app/viewmodels/auth_viewmodel.dart';

/// Elegant Splash Screen with beautiful animations and modern design
/// Features:
/// - Gradient background (deep purple to navy)
/// - Sophisticated fade-in and scale animations
/// - Elegant typography with proper spacing
/// - Modern design elements with glassmorphism
/// - Smooth loading indicator animation
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Fade in animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Scale animation for logo
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    // Slide up animation for text
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
    _navigateAfterDelay();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 2800));
    if (!mounted) return;

    final isLoggedIn = context.read<AuthViewModel>().isLoggedIn;
    final destination = isLoggedIn ? Routes.studentList : Routes.login;

    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(destination, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0F0C29),
              const Color(0xFF302B63),
              const Color(0xFF24243E),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // ============ Animated Background Blobs ============
            Positioned(
              top: -100,
              right: -100,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFA89BAB).withValues(alpha: 0.1),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -80,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF9B7BA8).withValues(alpha: 0.08),
                  ),
                ),
              ),
            ),

            // ============ Main Content ============
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ============ Logo with Glassmorphism ============
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.15),
                              Colors.white.withValues(alpha: 0.08),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFFA89BAB,
                              ).withValues(alpha: 0.2),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          size: 76,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 56),

                    // ============ App Name with Slide Animation ============
                    Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            Text(
                              'Mini School',
                              style: Theme.of(context).textTheme.displaySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'App',
                              style: Theme.of(context).textTheme.displaySmall
                                  ?.copyWith(
                                    color: const Color(0xFFA89BAB),
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ============ Subtitle ============
                    Transform.translate(
                      offset: Offset(0, _slideAnimation.value * 0.8),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'Student Management Portal',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.75),
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 80),

                    // ============ Animated Loading Indicator ============
                    Transform.translate(
                      offset: Offset(0, _slideAnimation.value * 1.2),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ============ Bottom Elegant Accent ============
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Center(
                  child: Text(
                    'Loading...',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.4),
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
