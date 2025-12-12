import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class ServiceViewModel extends ChangeNotifier {
  final UserProfile userProfile;
  final Function(String) onLog;

  ServiceViewModel({required this.userProfile, required this.onLog});

  bool get hasHealthRecord => userProfile.hasHealthRecord;

  void openFullRecord(BuildContext context) {
    onLog('Viewed full health records');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Health Records'),
        content: const Text('Full health records accessed successfully'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
