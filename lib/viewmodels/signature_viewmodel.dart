import 'package:flutter/material.dart';

class SignatureViewModel extends ChangeNotifier {
  final List<Offset?> _points = [];

  List<Offset?> get points => _points;

  void addPoint(Offset position) {
    _points.add(position);
    notifyListeners();
  }

  void endStroke() {
    _points.add(null);
    notifyListeners();
  }

  void clear() {
    _points.clear();
    notifyListeners();
  }

  bool get hasSignature => _points.isNotEmpty;
}
