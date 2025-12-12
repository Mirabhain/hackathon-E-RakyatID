import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class MoreServicesScreen extends StatelessWidget {
  final UserProfile userProfile;

  const MoreServicesScreen({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Services'),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'More Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Additional services and resources',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'More services coming soon...',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

