import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class GovernmentScreen extends StatelessWidget {
  final UserProfile userProfile;

  const GovernmentScreen({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Services'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Government Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Access government services and information',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildFeatureCard(
              context,
              icon: Icons.description,
              title: 'Apply for Documents',
              subtitle: 'IC, passport, birth certificate',
              color: Colors.purple,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.payment,
              title: 'Pay Government Fees',
              subtitle: 'Settle fines, taxes, and fees',
              color: Colors.indigo,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.how_to_vote,
              title: 'Voter Registration',
              subtitle: 'Register and check voting status',
              color: Colors.deepPurple,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.business,
              title: 'Business Registration',
              subtitle: 'Register new businesses',
              color: Colors.purpleAccent,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.home_work,
              title: 'Property Services',
              subtitle: 'Land titles and property records',
              color: Colors.deepPurpleAccent,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.gavel,
              title: 'Legal Services',
              subtitle: 'Court records and legal documents',
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: Text('Access $subtitle through government portal'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

