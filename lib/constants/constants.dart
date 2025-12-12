// lib/constants/constants.dart - UPDATED WITH GREEN
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color blue = Color(0xFF2196F3);      // For RENTER
  static const Color green = Color(0xFF4CAF50);     // For RENTEE (Material Green)
  
  // Optional: Darker shades
  static const Color blueDark = Color(0xFF1976D2);
  static const Color greenDark = Color(0xFF388E3C);
  
  // Neutral Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color card = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF212121);
  static const Color textLight = Color(0xFF757575);
  static const Color border = Color(0xFFE0E0E0);
}

// Role-based color helper
Color getRoleColor(String role) {
  if (role.toLowerCase() == 'renter') {
    return AppColors.blue;
  } else if (role.toLowerCase() == 'rentee') {
    return AppColors.green;
  } else {
    return AppColors.blue; // Default
  }
}

// Role-based button style
ButtonStyle getRoleButtonStyle(String role) {
  return ElevatedButton.styleFrom(
    backgroundColor: getRoleColor(role),
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 50),
  );
}