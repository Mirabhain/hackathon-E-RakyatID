import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/app_colors.dart';
import 'education_screen.dart';
import 'health_access_screen.dart';
import 'business_access_screen.dart';
import 'government_screen.dart';
import 'transport_screen.dart';
import 'finance_screen.dart';
import 'housing_screen.dart';
import 'digitalId.dart';

class ServiceScreen extends StatefulWidget {
  final UserProfile userProfile;
  final Function(String) onLog;

  const ServiceScreen({
    Key? key,
    required this.userProfile,
    required this.onLog,
  }) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _allServices = [
    {
      'title': 'Education',
      'subtitle': 'Access educational records and certificates',
      'icon': Icons.school,
      'color': AppColors.iconBlue,
      'screen': 'education',
    },
    {
      'title': 'Health',
      'subtitle': 'Medical records and healthcare services',
      'icon': Icons.health_and_safety,
      'color': AppColors.iconRed,
      'screen': 'health',
    },
    {
      'title': 'Business',
      'subtitle': 'Corporate access and verification',
      'icon': Icons.business,
      'color': AppColors.iconOrange,
      'screen': 'business',
    },
    {
      'title': 'Government',
      'subtitle': 'Government services and documents',
      'icon': Icons.account_balance,
      'color': AppColors.iconPurple,
      'screen': 'government',
    },
    {
      'title': 'Transport',
      'subtitle': 'Public transportation and passes',
      'icon': Icons.directions_car,
      'color': AppColors.iconGreen,
      'screen': 'transport',
    },
    {
      'title': 'Finance',
      'subtitle': 'Banking and financial services',
      'icon': Icons.payment,
      'color': AppColors.iconIndigo,
      'screen': 'finance',
    },
    {
      'title': 'Housing',
      'subtitle': 'Housing applications and assistance',
      'icon': Icons.home,
      'color': AppColors.iconTeal,
      'screen': 'housing',
    },
    {
      'title': 'Digital ID',
      'subtitle': 'MyKad and digital identification',
      'icon': Icons.badge,
      'color': AppColors.iconBlue,
      'screen': 'digitalId',
    },
    {
      'title': 'Tax Services',
      'subtitle': 'File and manage your taxes',
      'icon': Icons.receipt_long,
      'color': AppColors.iconOrange,
      'screen': null,
    },
    {
      'title': 'Voter Registration',
      'subtitle': 'Register and check voting status',
      'icon': Icons.how_to_vote,
      'color': AppColors.iconBlue,
      'screen': null,
    },
    {
      'title': 'Passport Services',
      'subtitle': 'Apply and renew passport',
      'icon': Icons.airplane_ticket,
      'color': AppColors.iconPink,
      'screen': null,
    },
    {
      'title': 'Driver License',
      'subtitle': 'Renew and manage driver license',
      'icon': Icons.drive_eta,
      'color': AppColors.iconGreen,
      'screen': null,
    },
    {
      'title': 'Birth Certificate',
      'subtitle': 'Apply for birth certificate',
      'icon': Icons.description,
      'color': AppColors.iconBlue,
      'screen': null,
    },
    {
      'title': 'Marriage Certificate',
      'subtitle': 'Register and obtain certificate',
      'icon': Icons.favorite,
      'color': AppColors.iconPink,
      'screen': null,
    },
    {
      'title': 'Death Certificate',
      'subtitle': 'Obtain death certificate',
      'icon': Icons.celebration,
      'color': AppColors.iconTeal,
      'screen': null,
    },
    {
      'title': 'Property Services',
      'subtitle': 'Land titles and property records',
      'icon': Icons.home_work,
      'color': AppColors.iconPurple,
      'screen': null,
    },
    {
      'title': 'Legal Services',
      'subtitle': 'Court records and legal documents',
      'icon': Icons.gavel,
      'color': AppColors.iconIndigo,
      'screen': null,
    },
    {
      'title': 'Social Welfare',
      'subtitle': 'Welfare assistance programs',
      'icon': Icons.family_restroom,
      'color': AppColors.iconOrange,
      'screen': null,
    },
    {
      'title': 'Employment Services',
      'subtitle': 'Job search and employment records',
      'icon': Icons.work,
      'color': AppColors.iconBlue,
      'screen': null,
    },
    {
      'title': 'Utility Bills',
      'subtitle': 'Pay water, electricity, and gas bills',
      'icon': Icons.electrical_services,
      'color': AppColors.iconRed,
      'screen': null,
    },
  ];

  List<Map<String, dynamic>> get _filteredServices {
    if (_searchQuery.isEmpty) {
      return _allServices;
    }
    return _allServices.where((service) {
      return service['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          service['subtitle'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services', style: AppTextStyles.h2.copyWith(color: AppColors.white)),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: AppColors.primaryBlue,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search services...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ),
          // Services List
          Expanded(
            child: _filteredServices.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No services found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try a different search term',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredServices.length,
                    itemBuilder: (context, index) {
                      final service = _filteredServices[index];
                      return _buildServiceCard(context, service);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> service) {
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (service['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            service['icon'] as IconData,
            color: service['color'] as Color,
            size: 24,
          ),
        ),
        title: Text(
          service['title'] as String,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            service['subtitle'] as String,
            style: AppTextStyles.bodySmall,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: AppColors.lightGrey,
        ),
        onTap: () => _navigateToService(context, service),
      ),
    );
  }

  void _navigateToService(BuildContext context, Map<String, dynamic> service) {
    final screen = service['screen'] as String?;
    
    if (screen == null) {
      // Show coming soon dialog for services without screens
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(service['title'] as String),
          content: Text('${service['subtitle'] as String}\n\nThis service will be available soon.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
      return;
    }

    Widget? destinationScreen;
    switch (screen) {
      case 'education':
        destinationScreen = EducationScreen(userProfile: widget.userProfile);
        break;
      case 'health':
        destinationScreen = HealthAccessScreen(
          userProfile: widget.userProfile,
          onLog: widget.onLog,
        );
        break;
      case 'business':
        destinationScreen = BusinessAccessScreen(
          userProfile: widget.userProfile,
          onLog: widget.onLog,
        );
        break;
      case 'government':
        destinationScreen = GovernmentScreen(userProfile: widget.userProfile);
        break;
      case 'transport':
        destinationScreen = TransportScreen(userProfile: widget.userProfile);
        break;
      case 'finance':
        destinationScreen = FinanceScreen(userProfile: widget.userProfile);
        break;
      case 'housing':
        destinationScreen = HousingScreen(userProfile: widget.userProfile);
        break;
      case 'digitalId':
        destinationScreen = DigitalId(
          userProfile: widget.userProfile,
          onLog: widget.onLog,
        );
        break;
    }

    if (destinationScreen != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destinationScreen!),
      );
    }
  }
}
