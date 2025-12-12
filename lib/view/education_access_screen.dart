import 'package:flutter/material.dart';
import '../viewmodels/education_access_view_model.dart';
import '../models/user_profile.dart';

class EducationAccessScreen extends StatelessWidget {
  final UserProfile userProfile;
  final Function(String) onLog;

  const EducationAccessScreen({
    Key? key,
    required this.userProfile,
    required this.onLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = EducationAccessViewModel(onLog: onLog);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Education Access'),
        backgroundColor: const Color(0xFF6366f1),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Smart Education Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Automatic access to educational resources',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),

            _buildServiceCard(
              context,
              'University Portal',
              'Access student dashboard',
              Icons.school,
              Colors.blue,
              () => vm.accessService(context, 'University Portal'),
            ),

            _buildServiceCard(
              context,
              'Digital Library',
              'Browse online resources',
              Icons.library_books,
              Colors.purple,
              () => vm.accessService(context, 'Digital Library'),
            ),

            _buildServiceCard(
              context,
              'Course Registration',
              'Register for new courses',
              Icons.app_registration,
              Colors.green,
              () => vm.accessService(context, 'Course Registration'),
            ),

            _buildServiceCard(
              context,
              'Exam Schedule',
              'View upcoming exams',
              Icons.calendar_today,
              Colors.orange,
              () => vm.accessService(context, 'Exam Schedule'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 32),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}