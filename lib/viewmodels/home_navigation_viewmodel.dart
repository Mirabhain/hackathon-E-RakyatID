import 'package:flutter/material.dart';

class HomeNavigationViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  /// Update selected tab
  void updateIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
