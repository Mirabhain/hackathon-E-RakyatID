import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class TransportScreen extends StatelessWidget {
  final UserProfile userProfile;

  const TransportScreen({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transport Services'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transport Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Access transportation services and bookings',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildFeatureCard(
              context,
              icon: Icons.card_membership,
              title: 'Student Pass',
              subtitle: userProfile.isStudent ? 'Active - 50% discount' : 'Apply for student discount',
              color: Colors.green,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.confirmation_number,
              title: 'Buy Tickets',
              subtitle: 'Purchase bus, train, and LRT tickets',
              color: Colors.blue,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.subway,
              title: 'RapidKL Services',
              subtitle: 'LRT, MRT, and bus services',
              color: Colors.orange,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.train,
              title: 'KTM Commuter',
              subtitle: 'Train services and schedules',
              color: Colors.red,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.directions_bus,
              title: 'Bus Routes',
              subtitle: 'Find bus routes and schedules',
              color: Colors.teal,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.location_on,
              title: 'Nearby Stations',
              subtitle: 'Find nearest transport stations',
              color: Colors.greenAccent,
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
              content: Text('Access $subtitle through transport services'),
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

