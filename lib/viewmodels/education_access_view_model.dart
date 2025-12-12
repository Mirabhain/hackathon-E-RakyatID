import 'package:flutter/material.dart';

class EducationAccessViewModel extends ChangeNotifier {
  final Function(String) onLog;

  EducationAccessViewModel({required this.onLog});

  void accessService(BuildContext context, String serviceName) {
    onLog('Accessed $serviceName');
    _showSuccessDialog(context, serviceName);
  }

  void _showSuccessDialog(BuildContext context, String service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Access Granted'),
        content: Text('Successfully accessed $service'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}