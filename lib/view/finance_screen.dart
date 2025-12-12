import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class FinanceScreen extends StatelessWidget {
  final UserProfile userProfile;

  const FinanceScreen({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Services'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Finance Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Access financial services and banking',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildFeatureCard(
              context,
              icon: Icons.account_balance,
              title: 'Bank Account Linking',
              subtitle: 'Link your bank accounts',
              color: Colors.teal,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.payment,
              title: 'Bill Payments',
              subtitle: 'Pay utilities and bills',
              color: Colors.blue,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.savings,
              title: 'Savings Accounts',
              subtitle: 'Open and manage savings',
              color: Colors.green,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.credit_card,
              title: 'Credit Services',
              subtitle: 'Apply for credit cards',
              color: Colors.orange,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.trending_up,
              title: 'Investment Services',
              subtitle: 'Explore investment options',
              color: Colors.purple,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.receipt_long,
              title: 'Tax Services',
              subtitle: 'File and manage taxes',
              color: Colors.red,
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
              content: Text('Access $subtitle through financial services'),
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

