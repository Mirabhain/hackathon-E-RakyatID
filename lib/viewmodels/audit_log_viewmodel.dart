import 'package:flutter/material.dart';
import '../models/audit_log_model.dart';

class AuditLogViewModel extends ChangeNotifier {
  final List<AuditLog> _logs = [];

  List<AuditLog> get logs => List.from(_logs.reversed);

  void addLog(String action) {
    _logs.add(AuditLog(action: action, timestamp: DateTime.now()));
    notifyListeners();
  }
}
