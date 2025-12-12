import 'package:flutter/material.dart';


class UserProfile {
  int loyaltyPoints;
  UserProfile({required this.loyaltyPoints});
}

class RewardItem {
  final String title;
  final String pointsLabel;
  final IconData icon;
  final Color color;

  RewardItem({
    required this.title,
    required this.pointsLabel,
    required this.icon,
    required this.color,
  });
}

class RedeemItem {
  final String title;
  final String requiredPoints;
  final IconData icon;

  RedeemItem({
    required this.title,
    required this.requiredPoints,
    required this.icon,
  });
}
