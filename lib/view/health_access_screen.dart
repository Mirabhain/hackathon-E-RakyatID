import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../viewmodels/health_access_view_model.dart';

class HealthAccessScreen extends StatelessWidget {
  final UserProfile userProfile;
  final Function(String) onLog;

  const HealthAccessScreen({
    Key? key,
    required this.userProfile,
    required this.onLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = HealthAccessViewModel(
      userProfile: userProfile,
      onLog: onLog,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Records'),
        backgroundColor: const Color(0xFFef4444),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const SizedBox(height: 32),

            vm.hasHealthRecord
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Recent Records',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 16),
                                _buildHealthItem(
                                    'Blood Type', 'O+', Icons.bloodtype),
                                _buildHealthItem('Last Checkup', '15 Nov 2024',
                                    Icons.calendar_today),
                                _buildHealthItem('Allergies', 'None recorded',
                                    Icons.warning),
                                _buildHealthItem('Vaccinations', 'Up to date',
                                    Icons.vaccines),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildFeatureCard(
                          context,
                          icon: Icons.calendar_today,
                          title: 'Book Appointment',
                          subtitle: 'Schedule doctor appointments',
                          color: Colors.blue,
                          onTap: () => _showFeature(context, 'Book Appointment', 'Schedule appointments with healthcare providers'),
                        ),
                        _buildFeatureCard(
                          context,
                          icon: Icons.medication,
                          title: 'Medication Reminders',
                          subtitle: 'Set reminders for medications',
                          color: Colors.green,
                          onTap: () => _showFeature(context, 'Medication Reminders', 'Manage your medication schedule'),
                        ),
                        _buildFeatureCard(
                          context,
                          icon: Icons.local_hospital,
                          title: 'Find Healthcare Providers',
                          subtitle: 'Search nearby clinics and hospitals',
                          color: Colors.orange,
                          onTap: () => _showFeature(context, 'Find Healthcare Providers', 'Locate nearby medical facilities'),
                        ),
                        _buildFeatureCard(
                          context,
                          icon: Icons.emergency,
                          title: 'Emergency Contacts',
                          subtitle: 'Quick access to emergency services',
                          color: Colors.red,
                          onTap: () => _showFeature(context, 'Emergency Contacts', 'Access emergency medical contacts'),
                        ),
                        _buildFeatureCard(
                          context,
                          icon: Icons.folder_open,
                          title: 'View Full Records',
                          subtitle: 'Complete medical history',
                          color: const Color(0xFFef4444),
                          onTap: () => vm.openFullRecord(context),
                        ),
                      ],
                    ),
                  )
                : const Center(child: Text('No health records available')),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFef4444)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 12)),
                Text(value,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
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
        onTap: onTap,
      ),
    );
  }

  void _showFeature(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}