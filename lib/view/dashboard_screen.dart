import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../theme/app_colors.dart';
import 'education_screen.dart';
import 'health_access_screen.dart';
import 'business_access_screen.dart';
import 'government_screen.dart';
import 'transport_screen.dart';
import 'finance_screen.dart';
import 'housing_screen.dart';
import 'more_services_screen.dart';
import 'subsidies_screen.dart';

class DashboardScreen extends StatelessWidget {
  final UserProfile userProfile;

  const DashboardScreen({super.key, required this.userProfile});

  static const int _gridColumns = 4;
  static const double _serviceCardBorderRadius = 0.05;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context, screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.02),
            _buildServicesSection(context, screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.02),
            _buildHelpSection(context, screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.03,
      ),
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
      child: _buildGreetingSection(screenWidth, screenHeight),
    );
  }

  Widget _buildGreetingSection(double screenWidth, double screenHeight) {
    final avatarSize = screenWidth > 400 ? screenWidth * 0.12 : 40.0;
    final nameFontSize = screenWidth > 400 ? 28.0 : 22.0;
    final subtitleFontSize = screenWidth > 400 ? 15.0 : 13.0;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hi, ${userProfile.name}! 👋',
                style: TextStyle(
                  fontSize: nameFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: screenHeight * 0.008),
              Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.04),
        CircleAvatar(
          radius: avatarSize,
          backgroundColor: Colors.white,
          child: Text(
            userProfile.name.isNotEmpty
                ? userProfile.name[0].toUpperCase()
                : 'U',
            style: TextStyle(
              fontSize: avatarSize * 0.6,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServicesSection(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Services',
            style: AppTextStyles.h3,
          ),
          SizedBox(height: screenHeight * 0.015),
          _buildServicesGrid(context, screenWidth),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context, double screenWidth) {
    final services = _getServicesList(context);
    final spacing = screenWidth * 0.03;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: _gridColumns,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      childAspectRatio: 1.0,
      children: services
          .map((service) => _buildServiceCard(
                context,
                icon: service['icon'] as IconData,
                title: service['title'] as String,
                color: service['color'] as Color,
                onTap: service['onTap'] as VoidCallback,
              ))
          .toList(),
    );
  }

  List<Map<String, dynamic>> _getServicesList(BuildContext context) {
    return [
      {
        'icon': Icons.school,
        'title': 'Education',
        'color': AppColors.iconBlue,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EducationScreen(userProfile: userProfile),
            ),
          );
        },
      },
      {
        'icon': Icons.health_and_safety,
        'title': 'Health',
        'color': AppColors.iconRed,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HealthAccessScreen(
                userProfile: userProfile,
                onLog: (String log) {},
              ),
            ),
          );
        },
      },
      {
        'icon': Icons.business,
        'title': 'Business',
        'color': AppColors.iconOrange,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessAccessScreen(
                userProfile: userProfile,
                onLog: (String log) {},
              ),
            ),
          );
        },
      },
      {
        'icon': Icons.account_balance,
        'title': 'Government',
        'color': AppColors.iconPurple,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GovernmentScreen(userProfile: userProfile),
            ),
          );
        },
      },
      {
        'icon': Icons.directions_car,
        'title': 'Transport',
        'color': AppColors.iconGreen,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransportScreen(userProfile: userProfile),
            ),
          );
        },
      },
      {
        'icon': Icons.payment,
        'title': 'Finance',
        'color': AppColors.iconIndigo,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FinanceScreen(userProfile: userProfile),
            ),
          );
        },
      },
      {
        'icon': Icons.home,
        'title': 'Housing',
        'color': AppColors.iconTeal,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HousingScreen(userProfile: userProfile),
            ),
          );
        },
      },
      {
        'icon': Icons.more_horiz,
        'title': 'More',
        'color': AppColors.iconPink,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MoreServicesScreen(userProfile: userProfile),
            ),
          );
        },
      },
    ];
  }

  Widget _buildHelpSection(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(
                Icons.help_outline,
                color: AppColors.primaryBlue,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Benefits & Assistance',
                style: AppTextStyles.h3,
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          _buildHelpCard(
            context,
            icon: Icons.account_balance_wallet,
            title: 'Subsidies & Benefits',
            subtitle: 'Government assistance programs',
            color: AppColors.iconBlue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubsidiesScreen(userProfile: userProfile),
                ),
              );
            },
          ),
          SizedBox(height: screenWidth * 0.02),
          _buildHelpCard(
            context,
            icon: Icons.directions_transit,
            title: 'Transportation',
            subtitle: 'Passes, student discounts & more',
            color: AppColors.iconGreen,
            onTap: () => _showTransportationInfo(context),
          ),
          SizedBox(height: screenWidth * 0.02),
          _buildHelpCard(
            context,
            icon: Icons.volunteer_activism,
            title: 'Volunteering Benefits',
            subtitle: 'Rewards for community service',
            color: AppColors.iconOrange,
            onTap: () => _showVolunteeringInfo(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSubsidiesInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.account_balance_wallet, color: Colors.blue),
            SizedBox(width: 8),
            Text('Subsidies & Benefits'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Government Assistance Programs:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              _buildInfoItem('Bantuan Keluarga Malaysia (BKM)', 'Monthly financial assistance for eligible families'),
              _buildInfoItem('Bantuan Prihatin Rakyat (BPR)', 'One-time financial aid for low-income households'),
              _buildInfoItem('Student Financial Aid', 'Education subsidies and scholarships'),
              _buildInfoItem('Senior Citizen Benefits', 'Special discounts and assistance for elderly'),
              _buildInfoItem('Healthcare Subsidies', 'Medical and health insurance support'),
              _buildInfoItem('Housing Assistance', 'Affordable housing programs'),
              const SizedBox(height: 12),
              Text(
                'Eligibility is based on your profile information and verified through government databases.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showTransportationInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.directions_transit, color: Colors.green),
            SizedBox(width: 8),
            Text('Transportation Benefits'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Transportation Benefits:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              _buildInfoItem('Student Pass', 'Discounted public transportation for students'),
              _buildInfoItem('Senior Citizen Pass', 'Free or discounted travel for seniors'),
              _buildInfoItem('Monthly Pass', 'Unlimited travel with monthly subscription'),
              _buildInfoItem('Student Discount', '50% off on buses, trains, and LRT'),
              _buildInfoItem('RapidKL Student Card', 'Special rates for students'),
              _buildInfoItem('KTM Student Pass', 'Discounted train tickets for students'),
              const SizedBox(height: 12),
              if (userProfile.isStudent)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'You are eligible for student transportation benefits!',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.green.shade700,
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showVolunteeringInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.volunteer_activism, color: Colors.orange),
            SizedBox(width: 8),
            Text('Volunteering Benefits'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Benefits for Volunteers:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              _buildInfoItem('Recognition Certificates', 'Official certificates for volunteer work'),
              _buildInfoItem('Priority Access', 'Early access to government programs'),
              _buildInfoItem('Skills Development', 'Training and workshops for volunteers'),
              _buildInfoItem('Networking Opportunities', 'Connect with other volunteers and organizations'),
              _buildInfoItem('Transportation Allowance', 'Reimbursement for travel expenses'),
              _buildInfoItem('Meal Allowance', 'Food provided during volunteer activities'),
              _buildInfoItem('Reference Letters', 'Official letters for job applications'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.orange, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'How to Get Started:',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.orange.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '1. Register as a volunteer through government portal\n'
                      '2. Complete volunteer activities\n'
                      '3. Track your hours and contributions\n'
                      '4. Redeem benefits based on your volunteer record',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 18, color: AppColors.primaryBlue),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - (screenWidth * 0.08) - (screenWidth * 0.09)) / 4;
    final iconSize = cardWidth * 0.35;
    final titleFontSize = cardWidth * 0.12;
    final borderRadius = screenWidth > 400 
        ? screenWidth * _serviceCardBorderRadius 
        : 12.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.015,
            vertical: screenWidth * 0.02,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: iconSize > 32 ? 32 : (iconSize < 20 ? 20 : iconSize),
                color: color,
              ),
              SizedBox(height: screenWidth * 0.015),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize > 14 ? 14 : (titleFontSize < 10 ? 10 : titleFontSize),
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 