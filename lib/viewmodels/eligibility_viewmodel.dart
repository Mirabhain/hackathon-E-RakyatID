import 'package:flutter/material.dart';
import '../../models/user_profile.dart';

class EligibilityItem {
  final String title;
  final bool eligible;
  final IconData icon;
  final Color color;

  EligibilityItem({
    required this.title,
    required this.eligible,
    required this.icon,
    required this.color,
  });
}

class EligibilityViewModel {
  List<EligibilityItem> getEligibility(UserProfile user) {
    return [
      EligibilityItem(
        title: 'Student Loan',
        eligible: user.isStudent,
        icon: Icons.school,
        color: Colors.blue,
      ),
      EligibilityItem(
        title: 'Senior Citizen Discount',
        eligible: user.isSeniorCitizen,
        icon: Icons.elderly,
        color: Colors.orange,
      ),
      EligibilityItem(
        title: 'Employment Benefits',
        eligible: user.isEmployee,
        icon: Icons.work,
        color: Colors.green,
      ),
      EligibilityItem(
        title: 'Health Insurance',
        eligible: user.age >= 18,
        icon: Icons.health_and_safety,
        color: Colors.red,
      ),
    ];
  }
}
