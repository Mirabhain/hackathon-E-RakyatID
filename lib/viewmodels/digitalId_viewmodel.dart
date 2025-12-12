import 'package:flutter/material.dart';
import '../view/myCard.dart';
import '../view/digitalId/driverLisence.dart';
import '../view/digitalId/passport.dart';
import '../view/digitalId/student_card.dart';
import '../view/digitalId/oku_card.dart';
import '../models/user_profile.dart';

class DigitalIdViewModel extends ChangeNotifier {
  final Function(String) onLog;

  DigitalIdViewModel({required this.onLog});

  /// Access a service page based on the service name
  void accessService(
    BuildContext context,
    String serviceName, {
    required UserProfile userProfile,
  }) {
    onLog('Accessed $serviceName');

    Widget? targetPage;

    switch (serviceName) {
      case 'MyCard':
        targetPage = MyCardPage(userProfile: userProfile);
        break;
      case 'Driver License':
        targetPage = DriverLicensePage(userProfile: userProfile);
        break;
      case 'Student Card':
        targetPage = StudentCardPage(userProfile: userProfile);
        break;
      case 'Passport':
        targetPage = PassportPage(userProfile: userProfile);
        break;
      case 'OKU Card':
        targetPage = OKUCardPage(userProfile: userProfile);
        break;
    }

    if (targetPage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => targetPage!),
      );
    }
  }
}
