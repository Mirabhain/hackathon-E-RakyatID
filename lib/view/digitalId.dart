import 'package:flutter/material.dart';
import '../viewmodels/digitalId_viewmodel.dart';
import '../models/user_profile.dart';
import '../theme/app_colors.dart';

class DigitalId extends StatelessWidget {
  final UserProfile userProfile;
  final Function(String) onLog;

  const DigitalId({
    Key? key,
    required this.userProfile,
    required this.onLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = DigitalIdViewModel(onLog: onLog);

    return Scaffold(
      body: Column(
        children: [
          // Header
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryBlue, AppColors.darkBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
                Positioned(
                  left: 24,
                  bottom: 24,
                  child: const Text(
                    "Digital Identification",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Positioned(
                //   right: 24,
                //   top: 24,
                //   child: Image.network(
                //     'https://images.unsplash.com/photo-1618430279534-323d2c5c7707?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGJsdWUlMjBsYW5kc2NhcGV8ZW58MHx8MHx8fDA%3D',
                //     width: 120,
                //     height: 120,
                //     fit: BoxFit.contain,
                //   ),
                // ),
                Positioned(
                  left: 8,
                  top: 40,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Cards list
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                  _buildServiceCard(
                    context,
                    'My Card',
                    'Information of MyCard',
                    () => vm.accessService(context, 'MyCard', userProfile: userProfile),
                  ),
                  _buildServiceCard(
                    context,
                    'Driver License',
                    'Information of Driver License',
                    () => vm.accessService(context, 'Driver License', userProfile: userProfile),
                  ),
                  _buildServiceCard(
                    context,
                    'Student Card',
                    'Information of Student Card',
                    () => vm.accessService(context, 'Student Card', userProfile: userProfile),
                  ),
                  _buildServiceCard(
                    context,
                    'Passport',
                    'Passport information',
                    () => vm.accessService(context, 'Passport', userProfile: userProfile),
                  ),
                  _buildServiceCard(
                    context,
                    'OKU Card',
                    'OKU Card Information',
                    () => vm.accessService(context, 'OKU Card', userProfile: userProfile),
                  ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, String title, String subtitle, VoidCallback onTap) {
    // Assign different colors to different cards
    final Map<String, Color> cardColors = {
      'My Card': AppColors.iconBlue,
      'Driver License': AppColors.iconGreen,
      'Student Card': AppColors.iconOrange,
      'Passport': AppColors.iconPink,
      'OKU Card': AppColors.iconPurple,
    };
    
    final iconColor = cardColors[title] ?? AppColors.iconBlue;
    final iconData = {
      'My Card': Icons.credit_card,
      'Driver License': Icons.drive_eta,
      'Student Card': Icons.school,
      'Passport': Icons.airplane_ticket,
      'OKU Card': Icons.accessible,
    }[title] ?? Icons.badge;
    
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(iconData, color: iconColor, size: 24),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
