import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mykadprototype/view/dashboard_screen.dart';
import 'package:mykadprototype/view/service_screen.dart';
import 'package:mykadprototype/view/digitalId.dart';
import 'package:mykadprototype/view/profile_screen.dart';
import 'package:mykadprototype/viewmodels/user_profile_view_model.dart';
import 'package:mykadprototype/theme/app_colors.dart';

  // for role switch

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfileViewModel>(context).user;
    
    // 4 pages for 4 buttons
    final pages = [
      DashboardScreen(userProfile: userProfile),     // Home
      ServiceScreen(userProfile: userProfile, onLog: (String log) {}),       // Services
      DigitalId(userProfile: userProfile, onLog: (String log) {}),           // Digital ID
      ProfilePage(userProfile: userProfile),         // Profile
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.grey,
        backgroundColor: AppColors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge),
            label: "Digital ID",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
