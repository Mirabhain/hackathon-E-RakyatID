import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/audit_log_viewmodel.dart';

class AuditLogScreen extends StatelessWidget {
  const AuditLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuditLogViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audit Logs'),
        backgroundColor: const Color(0xFF1e40af),
        foregroundColor: Colors.white,
      ),
      body: vm.logs.isEmpty
          ? const Center(child: Text('No activity logged yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vm.logs.length,
              itemBuilder: (context, index) {
                final log = vm.logs[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.history, color: Color(0xFF1e40af)),
                    title: Text(log.action),
                    subtitle: Text(
                      "${log.timestamp.day}/${log.timestamp.month}/${log.timestamp.year} "
                      "${log.timestamp.hour}:${log.timestamp.minute.toString().padLeft(2, '0')}",
                    ),
                    trailing: const Icon(Icons.check_circle, color: Colors.green),
                  ),
                );
              },
            ),
    );
  }
}
