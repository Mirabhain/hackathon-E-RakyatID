import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../theme/app_colors.dart';
import '../home_navigation.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticating = false;
  bool _biometricAvailable = false;
  List<BiometricType> _availableBiometrics = [];
  String _selectedMethod = 'biometric'; // 'biometric' or 'pin'
  final TextEditingController _pinController = TextEditingController();
  String _enteredPin = '';
  bool _showPinError = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _checkBiometrics() async {
    try {
      final bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();
      
      if (canCheckBiometrics && isDeviceSupported) {
        final List<BiometricType> availableBiometrics =
            await _localAuth.getAvailableBiometrics();
        
        setState(() {
          _biometricAvailable = availableBiometrics.isNotEmpty;
          _availableBiometrics = availableBiometrics;
          if (!_biometricAvailable) {
            _selectedMethod = 'pin';
          }
        });
      } else {
        setState(() {
          _biometricAvailable = false;
          _selectedMethod = 'pin';
        });
      }
    } catch (e) {
      setState(() {
        _biometricAvailable = false;
        _selectedMethod = 'pin';
      });
    }
  }

  Future<void> _authenticateWithBiometric() async {
    if (_isAuthenticating) return;
    
    setState(() => _isAuthenticating = true);

    try {
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to verify your identity',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        if (mounted) {
          _navigateToHome();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Authentication cancelled or failed'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Biometric authentication error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Biometric unavailable. Please use PIN instead.'),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 3),
          ),
        );
        setState(() {
          _selectedMethod = 'pin';
          _biometricAvailable = false;
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isAuthenticating = false);
      }
    }
  }

  void _authenticateWithPin() {
    debugPrint('PIN authentication called with PIN length: ${_enteredPin.length}');
    
    if (_enteredPin.length < 6) {
      setState(() => _showPinError = true);
      return;
    }

    if (_enteredPin.length == 6) {
      debugPrint('PIN verified, navigating to home');
      _navigateToHome();
    } else {
      setState(() => _showPinError = true);
    }
  }

  void _navigateToHome() {
    if (!mounted) return;
    try {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavBar()),
      );
    } catch (e) {
      debugPrint('Navigation error: $e');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavBar()),
        (route) => false,
      );
    }
  }

  String _getBiometricTypeName(BiometricType type) {
    switch (type) {
      case BiometricType.face:
        return 'Face ID';
      case BiometricType.fingerprint:
        return 'Fingerprint';
      case BiometricType.iris:
        return 'Iris';
      case BiometricType.strong:
        return 'Strong';
      case BiometricType.weak:
        return 'Weak';
    }
  }

  IconData _getBiometricIcon() {
    if (_availableBiometrics.contains(BiometricType.face)) {
      return Icons.face;
    } else if (_availableBiometrics.contains(BiometricType.fingerprint)) {
      return Icons.fingerprint;
    }
    return Icons.security;

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryBlue, AppColors.darkBlue],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                
                // Header
                const Text(
                  'Verify Your Identity',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 6),
                
                const Text(
                  'Choose your preferred verification method',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 20),
                
                // Method Selection
                Row(
                  children: [
                    Expanded(
                      child: _buildMethodOption(
                        'biometric',
                        _getBiometricIcon(),
                        _biometricAvailable ? 'Biometric' : 'Biometric\n(Not Available)',
                        _biometricAvailable,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMethodOption(
                        'pin',
                        Icons.lock,
                        'PIN',
                        true,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Verification UI
                _selectedMethod == 'biometric'
                    ? _buildBiometricVerification()
                    : _buildPinVerification(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMethodOption(String method, IconData icon, String label, bool enabled) {
    final isSelected = _selectedMethod == method;
    final isEnabled = enabled && !_isAuthenticating;
    
    return GestureDetector(
      onTap: isEnabled
          ? () {
              setState(() {
                _selectedMethod = method;
                _enteredPin = '';
                _showPinError = false;
              });
            }
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected
                  ? AppColors.primaryBlue
                  : (isEnabled ? Colors.white : Colors.white38),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? AppColors.primaryBlue
                    : (isEnabled ? Colors.white : Colors.white38),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBiometricVerification() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getBiometricIcon(),
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _availableBiometrics.isNotEmpty
              ? 'Use ${_getBiometricTypeName(_availableBiometrics.first)} to verify'
              : 'Biometric authentication not available',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        if (_biometricAvailable)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isAuthenticating ? null : _authenticateWithBiometric,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isAuthenticating
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
                      ),
                    )
                  : const Text(
                      'Authenticate',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPinVerification() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.lock,
          size: 50,
          color: Colors.white,
        ),
        const SizedBox(height: 16),
        const Text(
          'Enter your 6-digit PIN',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        
        // PIN Display
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _showPinError ? Colors.red : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index < _enteredPin.length
                      ? Colors.white
                      : Colors.white.withOpacity(0.3),
                ),
              );
            }),
          ),
        ),
        
        if (_showPinError) ...[
          const SizedBox(height: 10),
          const Text(
            'PIN must be 6 digits',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],
        
        const SizedBox(height: 20),
        
        // PIN Keypad - Constrained width for better mobile layout
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                if (index == 9) {
                  return const SizedBox.shrink();
                } else if (index == 10) {
                  return _buildKeypadButton('0', () {
                    if (_enteredPin.length < 6) {
                      final newPin = _enteredPin + '0';
                      setState(() {
                        _enteredPin = newPin;
                        _showPinError = false;
                      });
                      
                      if (newPin.length == 6) {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if (mounted) {
                            _authenticateWithPin();
                          }
                        });
                      }
                    }
                  });
                } else if (index == 11) {
                  return _buildKeypadButton(
                    Icons.backspace,
                    () {
                      if (_enteredPin.isNotEmpty) {
                        setState(() {
                          _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
                          _showPinError = false;
                        });
                      }
                    },
                    isIcon: true,
                  );
                } else {
                  final number = (index + 1).toString();
                  return _buildKeypadButton(number, () {
                    if (_enteredPin.length < 6) {
                      final newPin = _enteredPin + number;
                      setState(() {
                        _enteredPin = newPin;
                        _showPinError = false;
                      });
                      
                      if (newPin.length == 6) {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if (mounted) {
                            _authenticateWithPin();
                          }
                        });
                      }
                    }
                  });
                }
              },
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _enteredPin.length == 6 ? _authenticateWithPin : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBackgroundColor: Colors.white.withOpacity(0.3),
            ),
            child: const Text(
              'Verify',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildKeypadButton(dynamic content, VoidCallback onTap, {bool isIcon = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: isIcon
              ? Icon(content, color: Colors.white, size: 24)
              : Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}