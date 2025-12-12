import 'package:flutter/material.dart';

class BusinessService {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool enabled;

  BusinessService({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.enabled,
  });
}

class VerificationAttribute {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String value;

  VerificationAttribute({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.value,
  });
}
