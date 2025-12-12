import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/card_reader_viewmodel.dart';
import '../../viewmodels/user_profile_view_model.dart';
import '../../view/verification_screen.dart';

class CardReaderScreen extends StatelessWidget {
  const CardReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CardReaderViewModel(),
      child: const _CardReaderScreenContent(),
    );
  }
}

class _CardReaderScreenContent extends StatelessWidget {
  const _CardReaderScreenContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CardReaderViewModel>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2563eb), Color(0xFF06b6d4)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Card Reader Icon Box
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.credit_card,
                    size: 150,
                    color: Color(0xFF2563eb),
                  ),
                ),

                const SizedBox(height: 48),

                Text(
                  viewModel.isConnected
                      ? 'Card Reader Connected'
                      : 'Connect Card Reader',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  viewModel.isConnected
                      ? 'Insert your MyKad to read'
                      : 'Place device near card reader',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 48),

                if (viewModel.isLoading)
                  Column(
                    children: [
                      const CircularProgressIndicator(color: Colors.white),
                      const SizedBox(height: 16),
                      Text(
                        viewModel.statusMessage,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  )
                else if (!viewModel.isConnected)
                  ElevatedButton(
                    onPressed: () async {
                      await viewModel.connectReader();
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
                    child: const Text('Connect Reader'),
                  )
                else
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final userProfile = await viewModel.readCard();

                        // Update the ViewModel with the read user data
                        Provider.of<UserProfileViewModel>(context, listen: false)
                            .updateUser(userProfile);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VerificationScreen(),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${e.toString()}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF2563eb),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Read MyKad'),
                  ),

                if (viewModel.isConnected) ...[
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      viewModel.disconnect();
                    },
                    child: const Text(
                      'Disconnect Reader',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}