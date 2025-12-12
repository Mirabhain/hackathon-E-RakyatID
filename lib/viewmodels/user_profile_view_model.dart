import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class UserProfileViewModel extends ChangeNotifier {
  // Initial user data
  UserProfile _user = UserProfile(
    name: 'Amira',
    icNumber: '04030708****',
    fullIC : '040307080124',
    age: 22,
    isStudent: true,
    isEmployee: false,
    isSeniorCitizen: false,
    hasHealthRecord: true,
    loyaltyPoints: 120,
    address: 'No 45, Jalan Mawar 3/2, Taman Sentosa, 43000 Kajang, Selangor',
    dateOfBirth: '15 March 1992',
    phone: '012-3456789',
    email: 'ahmad.abdullah@email.com',
  );

  // Getter to access the user profile
  UserProfile get user => _user;

  // Update the entire user profile
  void updateUser(UserProfile newUser) {
    _user = newUser;
    notifyListeners();
  }
}
