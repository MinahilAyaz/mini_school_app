// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AppColors {
//   // Primary Colors - Updated to match your design palette
//   static const Color primaryBlue = Color(0xFF987D9A); // Purple/Mauve
//   static const Color secondaryPurple = Color(0xFFBB9AB1); // Light Purple
//   static const Color accentYellow = Color(0xFFFEFBD8); // Cream/Light Yellow

//   // Additional colors from palette
//   static const Color accentBeige = Color(0xFFEECEB9); // Tan/Beige

//   // Backgrounds
//   static const Color background = Color(0xFFFAF9F7);
//   static const Color darkBackground = Color(0xFF1A1618);

//   // Text
//   static const Color textPrimary = Color(0xFF2A2520);
//   static const Color textSecondary = Color(0xFF6B6560);
//   static const Color textLight = Color(0xFFFAFAF8);

//   // Status Colors
//   static const Color success = Color(0xFF66BB6A);
//   static const Color error = Color(0xFFEF5350);
//   static const Color warning = Color(0xFFFFB74D);
// }

// class AppTheme {
//   // Light Theme
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: AppColors.background,

//     colorScheme: ColorScheme.light(
//       primary: AppColors.primaryBlue,
//       secondary: AppColors.secondaryPurple,
//       tertiary: AppColors.accentYellow,
//       surface: Colors.white,
//       error: AppColors.error,
//     ),

//     // Typography
//     textTheme: TextTheme(
//       headlineLarge: GoogleFonts.poppins(
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         color: AppColors.textPrimary,
//       ),
//       headlineMedium: GoogleFonts.poppins(
//         fontSize: 24,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimary,
//       ),
//       titleMedium: GoogleFonts.poppins(
//         fontSize: 18,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimary,
//       ),
//       bodyLarge: GoogleFonts.poppins(
//         fontSize: 16,
//         fontWeight: FontWeight.w500,
//         color: AppColors.textPrimary,
//       ),
//       bodyMedium: GoogleFonts.poppins(
//         fontSize: 14,
//         fontWeight: FontWeight.normal,
//         color: AppColors.textPrimary,
//       ),
//       labelSmall: GoogleFonts.poppins(
//         fontSize: 12,
//         fontWeight: FontWeight.normal,
//         color: AppColors.textSecondary,
//       ),
//     ),

//     // Button Styling
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primaryBlue,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 2,
//       ),
//     ),

//     // Input Field Styling
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Color(0xFFE8E4E0)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Color(0xFFE8E4E0)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       hintStyle: GoogleFonts.poppins(
//         color: AppColors.textSecondary,
//         fontSize: 14,
//       ),
//     ),

//     // AppBar Theme
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.white,
//       foregroundColor: AppColors.textPrimary,
//       elevation: 0,
//       centerTitle: true,
//     ),
//   );

//   // Dark Theme
//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: AppColors.darkBackground,

//     colorScheme: ColorScheme.dark(
//       primary: AppColors.primaryBlue,
//       secondary: AppColors.secondaryPurple,
//       tertiary: AppColors.accentYellow,
//       surface: const Color(0xFF2A2520),
//       error: AppColors.error,
//     ),

//     textTheme: TextTheme(
//       headlineLarge: GoogleFonts.poppins(
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         color: AppColors.textLight,
//       ),
//       headlineMedium: GoogleFonts.poppins(
//         fontSize: 24,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textLight,
//       ),
//       titleMedium: GoogleFonts.poppins(
//         fontSize: 18,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textLight,
//       ),
//       bodyLarge: GoogleFonts.poppins(
//         fontSize: 16,
//         fontWeight: FontWeight.w500,
//         color: AppColors.textLight,
//       ),
//       bodyMedium: GoogleFonts.poppins(
//         fontSize: 14,
//         fontWeight: FontWeight.normal,
//         color: const Color(0xFFD4CEC8),
//       ),
//       labelSmall: GoogleFonts.poppins(
//         fontSize: 12,
//         fontWeight: FontWeight.normal,
//         color: const Color(0xFFA09A93),
//       ),
//     ),

//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.primaryBlue,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 2,
//       ),
//     ),

//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: const Color(0xFF3A3430),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Color(0xFF4A4440)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Color(0xFF4A4440)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       hintStyle: GoogleFonts.poppins(
//         color: const Color(0xFFA09A93),
//         fontSize: 14,
//       ),
//     ),

//     // AppBar Theme
//     appBarTheme: AppBarTheme(
//       backgroundColor: const Color(0xFF2A2520),
//       foregroundColor: AppColors.textLight,
//       elevation: 0,
//       centerTitle: true,
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary Colors - Modern & Professional for Education
  // Updated color palette
  static const Color primaryBlue = Color(0xFF987D9A); // Mauve/Purple
  static const Color secondaryPurple = Color(0xFFBB9AB1); // Light Purple
  static const Color accentOrange = Color(0xFFEECEB9); // Beige/Tan
  static const Color accentYellow = Color(0xFFFEFBD8); // Cream/Light Yellow

  // Backgrounds
  static const Color background = Color(0xFFFAFBFC); // Light gray-blue
  static const Color darkBackground = Color(0xFF121212); // Pure dark

  // Text
  static const Color textPrimary = Color(0xFF212121); // Near black
  static const Color textSecondary = Color(0xFF757575); // Medium gray
  static const Color textLight = Color(0xFFFAFBFC); // Almost white

  // Text for Dark Mode (HIGH CONTRAST)
  static const Color textDarkPrimary = Color(0xFFFAFBFC); // Almost white
  static const Color textDarkSecondary = Color(0xFFBDBDBD); // Light gray

  // Status Colors
  static const Color success = Color(0xFF43A047);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFB8C00);

  // Neutral
  static const Color divider = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF424242);
}

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,

    colorScheme: ColorScheme.light(
      primary: AppColors.primaryBlue,
      secondary: AppColors.secondaryPurple,
      tertiary: AppColors.accentYellow,
      surface: Colors.white,
      error: AppColors.error,
    ),

    // Typography
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      ),
    ),

    // Button Styling
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),
    ),

    // Input Field Styling
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE3F2FD)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE3F2FD)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: GoogleFonts.poppins(
        color: AppColors.textSecondary,
        fontSize: 14,
      ),
      labelStyle: TextStyle(color: AppColors.textSecondary),
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.textPrimary,
      elevation: 1,
      centerTitle: true,
    ),
  );

  // Dark Theme - OPTIMIZED FOR READABILITY
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryBlue,
      secondary: AppColors.secondaryPurple,
      tertiary: AppColors.accentYellow,
      surface: const Color(0xFF1E1E1E),
      error: AppColors.error,
    ),

    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textDarkPrimary, // Almost white
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textDarkPrimary, // Almost white
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textDarkPrimary, // Almost white
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textDarkPrimary, // Almost white
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textDarkSecondary, // Light gray
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textDarkSecondary, // Light gray
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3A3A3A)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3A3A3A)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: GoogleFonts.poppins(
        color: AppColors.textDarkSecondary,
        fontSize: 14,
      ),
      labelStyle: TextStyle(color: AppColors.textDarkSecondary),
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: AppColors.textDarkPrimary,
      elevation: 1,
      centerTitle: true,
    ),
  );
}
