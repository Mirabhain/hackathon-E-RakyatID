import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary Blue - Pure Blue #0000FF
  static const Color primaryBlue = Color(0xFF0000FF); // Pure blue #0000FF
  static const Color darkBlue = Color(0xFF000080); // Dark blue
  static const Color mediumBlue = Color(0xFF4169E1); // Royal blue
  static const Color lightBlue = Color(0xFF87CEEB); // Sky blue
  static const Color skyBlue = Color(0xFFB0E0E6); // Powder blue
  static const Color navyBlue = Color(0xFF000080); // Navy blue
  static const Color brightBlue = Color(0xFF1E90FF); // Dodger blue
  static const Color cyanBlue = Color(0xFF00CED1); // Dark turquoise (for variety)
  
  // Accent Colors - Varied for interesting icons
  static const Color indigoBlue = Color(0xFF4B0082); // Indigo
  static const Color deepBlue = Color(0xFF00008B); // Dark blue
  static const Color blueGrey = Color(0xFF4682B4); // Steel blue
  static const Color tealBlue = Color(0xFF008080); // Teal (kept for compatibility but will use pure blue)
  
  // Icon Colors - Varied and interesting
  static const Color iconBlue = Color(0xFF0000FF);
  static const Color iconPurple = Color(0xFF8A2BE2);
  static const Color iconGreen = Color(0xFF228B22);
  static const Color iconOrange = Color(0xFFFF8C00);
  static const Color iconRed = Color(0xFFDC143C);
  static const Color iconPink = Color(0xFFFF1493);
  static const Color iconTeal = Color(0xFF008080);
  static const Color iconIndigo = Color(0xFF4B0082);
  
  // Neutral Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black87;
  static const Color grey = Color(0xFF757575);
  static const Color lightGrey = Color(0xFFE0E0E0);
}

class AppTextStyles {
  // Headings
  static TextStyle h1 = GoogleFonts.quicksand(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  
  static TextStyle h2 = GoogleFonts.quicksand(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  
  static TextStyle h3 = GoogleFonts.quicksand(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  
  // Body Text
  static TextStyle bodyLarge = GoogleFonts.quicksand(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );
  
  static TextStyle bodyMedium = GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );
  
  static TextStyle bodySmall = GoogleFonts.quicksand(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF757575),
  );
  
  // Labels
  static TextStyle label = GoogleFonts.quicksand(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF757575),
  );
}

