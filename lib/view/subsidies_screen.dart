import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/app_colors.dart';

class SubsidiesScreen extends StatelessWidget {
  final UserProfile userProfile;

  const SubsidiesScreen({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Government Subsidies',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            color: Colors.green.shade700,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: const Text(
              "Programs you're eligible for",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ),
          // Subsidies List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSubsidyCard(
                  context,
                  icon: Icons.card_giftcard,
                  title: 'Bantuan Sara Hidup (BSH)',
                  amount: 'RM 2,000/year',
                  criteria: 'Household income < RM 4,850',
                  isEligible: true,
                  deadline: '31 Dec 2025',
                ),
                const SizedBox(height: 12),
                _buildSubsidyCard(
                  context,
                  icon: Icons.home,
                  title: 'Bantuan Prihatin Rakyat (BPR)',
                  amount: 'RM 1,500/year',
                  criteria: 'Malaysian citizen, married',
                  isEligible: true,
                  deadline: '30 Nov 2025',
                ),
                const SizedBox(height: 12),
                _buildSubsidyCard(
                  context,
                  icon: Icons.shopping_cart,
                  title: 'e-Pemula',
                  amount: 'RM 250',
                  criteria: 'Age 18-20 only',
                  isEligible: userProfile.age >= 18 && userProfile.age <= 20,
                  deadline: '15 Dec 2025',
                ),
                const SizedBox(height: 12),
                _buildSubsidyCard(
                  context,
                  icon: Icons.school,
                  title: 'Student Financial Aid',
                  amount: 'RM 1,200/year',
                  criteria: 'Active student status',
                  isEligible: userProfile.isStudent,
                  deadline: '28 Feb 2025',
                ),
                const SizedBox(height: 12),
                _buildSubsidyCard(
                  context,
                  icon: Icons.elderly,
                  title: 'Senior Citizen Benefits',
                  amount: 'RM 500/year',
                  criteria: 'Age 60 and above',
                  isEligible: userProfile.isSeniorCitizen,
                  deadline: '31 Jan 2025',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubsidyCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String amount,
    required String criteria,
    required bool isEligible,
    required String deadline,
  }) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.green.shade700,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        amount,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              criteria,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (isEligible)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green.shade700,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Eligible',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
                Text(
                  'Apply by: $deadline',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isEligible
                    ? () {
                        // Handle apply action
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Application for $title will be auto-filled with your details'),
                            backgroundColor: Colors.green.shade700,
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Apply Now (Auto-Fill Ready)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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

