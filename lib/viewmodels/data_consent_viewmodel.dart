import 'package:flutter/material.dart';

class DataConsentViewModel extends ChangeNotifier {
  final Map<String, bool> _consents = {
    'Name': false,
    'IC Number': false,
    'Address': false,
    'Phone Number': false,
    'Email': false,
  };

  Map<String, bool> get consents => _consents;

  void toggleConsent(String key, bool value) {
    _consents[key] = value;
    notifyListeners();
  }

  bool get hasSelected => _consents.values.any((v) => v);
}
