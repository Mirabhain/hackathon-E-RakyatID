import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/business_access_viewmodel.dart';

class PrivateVerificationScreen extends StatelessWidget {
  final Function(String) onVerify;

  const PrivateVerificationScreen({
    super.key,
    required this.onVerify,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PrivateVerificationViewModel(),
      child: Consumer<PrivateVerificationViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Private Verification'),
              backgroundColor: const Color(0xFF7c3aed),
              foregroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Attribute Verification',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Verify attributes without exposing your full IC number',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),

                  ...vm.attributes.map(
                    (attr) => _buildVerificationCard(
                      context,
                      attr,
                      () {
                        onVerify(attr.value);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerificationCard(
    BuildContext context,
    var attr,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: attr.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(attr.icon, color: attr.color, size: 32),
        ),
        title: Text(
          attr.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(attr.subtitle),
        trailing: const Icon(Icons.verified_user, color: Colors.green),
      ),
    );
  }
}
