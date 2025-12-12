import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/qr_scan_viewmodel.dart';
import '../../viewmodels/user_profile_view_model.dart';
import '../../view/verification_screen.dart';

class QRScanScreen extends StatelessWidget {
  const QRScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QRScanViewModel(),
      child: const _QRScanScreenContent(),
    );
  }
}

class _QRScanScreenContent extends StatelessWidget {
  const _QRScanScreenContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<QRScanViewModel>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF7c3aed), Color(0xFFdb2777)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon Box
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner,
                    size: 150,
                    color: Color(0xFF7c3aed),
                  ),
                ),

                const SizedBox(height: 48),

                const Text(
                  'Scan QR Code',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Align QR code within frame',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 48),

                viewModel.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : ElevatedButton(
                        onPressed: () async {
                          try {
                            final userProfile = await viewModel.simulateScan();
                            
                            // Update the ViewModel with the scanned user
                            Provider.of<UserProfileViewModel>(context, listen: false)
                                .updateUser(userProfile);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const VerificationScreen(),
                              ),
                            );
                          } catch (e) {
                            // Handle errors
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: ${e.toString()}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Simulate Scan'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}