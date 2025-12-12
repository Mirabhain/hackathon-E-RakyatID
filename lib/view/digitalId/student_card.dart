import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../theme/app_colors.dart';

class StudentCardPage extends StatelessWidget {
  final UserProfile userProfile;

  const StudentCardPage({Key? key, required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Card", style: AppTextStyles.h2.copyWith(color: AppColors.white)),
        backgroundColor: AppColors.iconOrange,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Card container
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [AppColors.iconOrange, AppColors.iconOrange.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row: Logo + Student Card
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.school, color: AppColors.iconOrange, size: 24),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "STUDENT CARD",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // User photo and info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Photo placeholder
                        Container(
                          width: 100,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.person, color: Colors.white, size: 60),
                        ),
                        const SizedBox(width: 16),
                        // User info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name: ${userProfile.name}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Ic Number: ${userProfile.icNumber}",
                                style: const TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Status: Active Student",
                                style: const TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                              if (userProfile.dateOfBirth != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  "Birth Date: ${userProfile.dateOfBirth}",
                                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.iconGreen,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "ACTIVE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Student Information
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Student Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                       const SizedBox(height: 24),
                 Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://www.rhbgroup.com/-/media/Assets/Corporate-Website/Images/Islamic/pro-savings-account-i/rhb-mysiswa-debit-card-i-graybg.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                    const SizedBox(height: 16),
                    _buildInfoRow("Institution", "Universiti Malaya"),
                    const Divider(),
                    _buildInfoRow("Programme", "Sarjana Muda Sains Komputer"),
                    const Divider(),
                    _buildInfoRow("Matric No.", "A20EC0001"),
                    const Divider(),
                    _buildInfoRow("Session", "2024/2025"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

