import 'dart:async';
import '../models/user_profile.dart';

class TapCardViewModel {
  Future<UserProfile> authenticate() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    return UserProfile(
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
      email: 'fauziah@email.com',
    );
  }
}
