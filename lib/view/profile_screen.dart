import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_profile.dart';
import '../viewmodels/user_profile_view_model.dart';
import '../theme/app_colors.dart';

// Profile Page View
class ProfilePage extends StatelessWidget {
  final UserProfile userProfile;
  final Function(String)? onLog;

  const ProfilePage({
    Key? key,
    required this.userProfile,
    this.onLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileViewModel>(
        builder: (context, viewModel, child) {
          final profile = viewModel.user;

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryBlue, AppColors.darkBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 37,
                            backgroundColor: AppColors.skyBlue,
                            child: Text(
                              profile.name.isNotEmpty 
                                  ? profile.name[0].toUpperCase()
                                  : 'U',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.name,
                                style: AppTextStyles.h2.copyWith(color: AppColors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  'IC: ${profile.icNumber}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Your Details Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: AppColors.primaryBlue,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Your Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        _buildDetailRow(
                          icon: Icons.calendar_today,
                          label: 'Date of Birth:',
                          value: profile.dateOfBirth ?? 'Not provided',
                        ),
                        _buildDetailRow(
                          icon: Icons.location_on,
                          label: 'Address:',
                          value: profile.address,
                        ),
                        _buildDetailRow(
                          icon: Icons.phone,
                          label: 'Phone:',
                          value: profile.phone ?? 'Not provided',
                        ),
                        _buildDetailRow(
                          icon: Icons.email,
                          label: 'Email:',
                          value: profile.email ?? 'Not provided',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, isLast ? 16 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.primaryBlue,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primaryBlue, size: 22),
        ),
        title: Text(
          label,
          style: AppTextStyles.label,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            value,
            style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, bool isActive, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryBlue : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isActive ? AppColors.white : AppColors.grey,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.white : AppColors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primaryBlue, size: 22),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: AppTextStyles.bodySmall,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.lightGrey,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildCompactInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildCompactActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGrey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(Icons.chevron_right, size: 16, color: AppColors.lightGrey),
          ],
        ),
      ),
    );
  }
}