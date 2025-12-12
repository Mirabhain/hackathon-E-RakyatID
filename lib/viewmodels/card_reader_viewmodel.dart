import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';

class CardReaderViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isConnected = false;
  String _statusMessage = '';

  bool get isLoading => _isLoading;
  bool get isConnected => _isConnected;
  String get statusMessage => _statusMessage;

  /// Simulate connecting to a card reader device
  Future<void> connectReader() async {
    _isLoading = true;
    _statusMessage = 'Searching for card reader...';
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _statusMessage = 'Connecting to device...';
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _statusMessage = 'Initializing reader...';
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isConnected = true;
    _isLoading = false;
    _statusMessage = 'Reader connected successfully';
    notifyListeners();
  }

  /// Simulate reading MyKad data from the card reader
  Future<UserProfile> readCard() async {
    if (!_isConnected) {
      throw Exception('Card reader not connected');
    }

    _isLoading = true;
    _statusMessage = 'Waiting for card...';
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    _statusMessage = 'Reading card data...';
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _statusMessage = 'Processing information...';
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    // Simulate reading MyKad data
    final userProfile = UserProfile(
      name: "Nik Fauziah binti Ismail",
      icNumber: "920315-08-****",
      fullIC: "920315-08-5432",
      age: 32,
      isStudent: false,
      isSeniorCitizen: false,
      hasHealthRecord: true,
      isEmployee: true,
      loyaltyPoints: 1250,
      address: 'No 45, Jalan Mawar 3/2, Taman Sentosa, 43000 Kajang, Selangor',
      dateOfBirth: '15 March 1992',
      phone: '012-3456789',
      email: 'ahmad.abdullah@email.com',
    );

    _isLoading = false;
    _statusMessage = 'Card read successfully';
    notifyListeners();

    return userProfile;
  }

  /// Disconnect from the card reader
  void disconnect() {
    _isConnected = false;
    _statusMessage = '';
    notifyListeners();
  }

  /// Reset the view model state
  void reset() {
    _isLoading = false;
    _isConnected = false;
    _statusMessage = '';
    notifyListeners();
  }

  @override
  void dispose() {
    // Clean up any resources if needed
    super.dispose();
  }
}