// Login Screen by Tapping Card

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/tap_card_viewmodel.dart';
import '../../models/user_profile.dart';
import '../../viewmodels/user_profile_view_model.dart';
import '../../view/verification_screen.dart';

class TapCardScreen extends StatefulWidget {
  const TapCardScreen({super.key});

  @override
  State<TapCardScreen> createState() => _TapCardScreenState();
}

class _TapCardScreenState extends State<TapCardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TapCardViewModel viewModel = TapCardViewModel();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _authenticate() async {
    UserProfile user = await viewModel.authenticate();
    
    // Update the ViewModel with the authenticated user
    Provider.of<UserProfileViewModel>(context, listen: false).updateUser(user);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const VerificationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0e7490), Color(0xFF1e40af)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF06b6d4).withOpacity(0.3 * _controller.value),
                      ),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.credit_card,
                            size: 80,
                            color: Color(0xFF67e8f9),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 48),
                const Text(
                  'Tap Your MyKad',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Place your card on the reader',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF67e8f9),
                  ),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: _authenticate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Simulate Tap'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
