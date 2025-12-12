import 'package:flutter/material.dart';

class AuthMethodScreen extends StatelessWidget {
  const AuthMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6366f1), Color(0xFF8b5cf6)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                
                // Header
                const Text(
                  'Verify Your Identity',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 12),
                
                const Text(
                  'Choose your preferred verification method',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const Spacer(),
                
                // Biometric Option
                _buildAuthCard(
                  context,
                  icon: Icons.fingerprint,
                  title: 'Biometric',
                  subtitle: 'Use fingerprint or face recognition',
                  onTap: () {
                    Navigator.pushNamed(context, '/biometric-verification');
                  },
                ),
                
                const SizedBox(height: 20),
                
                // PIN Option
                _buildAuthCard(
                  context,
                  icon: Icons.pin,
                  title: 'PIN',
                  subtitle: 'Enter your 6-digit PIN',
                  onTap: () {
                    Navigator.pushNamed(context, '/pin-verification');
                  },
                ),
                
                const Spacer(),
                
                // Skip button (optional)
                TextButton(
                  onPressed: () {
                    // Navigate directly to home or show warning
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Skip Verification?'),
                        content: const Text(
                          'Skipping verification will limit access to certain features. Are you sure?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                            child: const Text('Skip'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    'Skip for now',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF6366f1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 32,
                color: const Color(0xFF6366f1),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1f2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF6366f1),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}