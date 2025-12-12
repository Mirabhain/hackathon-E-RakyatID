import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class HousingScreen extends StatelessWidget {
  final UserProfile userProfile;

  const HousingScreen({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Housing Services'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Housing Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Access housing services and applications',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildFeatureCard(
              context,
              icon: Icons.home,
              title: 'Affordable Housing',
              subtitle: 'Apply for affordable housing programs',
              color: Colors.brown,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.apartment,
              title: 'Public Housing',
              subtitle: 'Public housing applications',
              color: Colors.brown.shade700,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.house_siding,
              title: 'Housing Loans',
              subtitle: 'Apply for housing loans',
              color: Colors.brown.shade600,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.construction,
              title: 'Home Renovation Grants',
              subtitle: 'Financial assistance for renovations',
              color: Colors.brown.shade800,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.verified_user,
              title: 'Property Ownership',
              subtitle: 'Check property ownership records',
              color: Colors.brown.shade900,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.real_estate_agent,
              title: 'Rental Assistance',
              subtitle: 'Apply for rental subsidies',
              color: Colors.brown,
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
              content: Text('Access $subtitle through housing services'),
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

