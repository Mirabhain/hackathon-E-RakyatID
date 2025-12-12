import 'package:flutter/material.dart';
import 'tap_card_screen.dart';
import '../view/qr_scan/qr_scan_screen.dart';
import 'connect_reader_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF1e40af), // solid blue background
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.shield,
                      size: 80,
                      color: Color(0xFF67e8f9),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'e-RakyatID',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'One MyKad to Connect Them All',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF67e8f9),
                    ),
                  ),
                  const SizedBox(height: 64),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TapCardScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.credit_card, size: 24),
                      label: const Text(
                        'Tap MyKad',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3b82f6), // lighter blue
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QRScanScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.qr_code_scanner, size: 24),
                      label: const Text(
                        'Scan QR Code',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2563eb), // different blue
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CardReaderScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.usb, size: 24),
                      label: const Text(
                        'Connect Card Reader',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2563eb), // different blue
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Secure • Private • Instant',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
