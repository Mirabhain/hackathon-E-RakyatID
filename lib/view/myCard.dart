import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/app_colors.dart';

class MyCardPage extends StatelessWidget {
  final UserProfile userProfile;

  const MyCardPage({Key? key, required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MyKad",
          style: AppTextStyles.h2.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primaryBlue,
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
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryBlue, AppColors.darkBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row: Logo + Malaysia MyKad
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.flag, color: AppColors.primaryBlue, size: 24),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "MALAYSIA MYKAD",
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
                                "Nama: ${userProfile.name}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "No KP: ${userProfile.icNumber}",
                                style: const TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Alamat: ${userProfile.address}",
                                style: const TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                              if (userProfile.dateOfBirth != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  "Tarikh Lahir: ${userProfile.dateOfBirth}",
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
                 Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://www.remaja.my/wp-content/uploads/2021/03/6e3d2b4e-7ec7-44b9-8cee-837abdef5c96-1.png",
                      fit: BoxFit.cover,
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
                  "Renew",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
