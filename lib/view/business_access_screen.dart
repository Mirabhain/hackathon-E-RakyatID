import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/business_access_viewmodel.dart';
import '../models/user_profile.dart';

class BusinessAccessScreen extends StatelessWidget {
  final UserProfile userProfile;
  final Function(String) onLog;

  const BusinessAccessScreen({
    super.key,
    required this.userProfile,
    required this.onLog,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BusinessAccessViewModel(userProfile),
      child: Consumer<BusinessAccessViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Business Services'),
              backgroundColor: const Color(0xFF14b8a6),
              foregroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Corporate Access',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Seamless business verification',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),

                  ...vm.businessServices.map(
                    (service) => _buildBusinessCard(
                      context,
                      service,
                      () {
                        if (service.enabled) {
                          onLog('Accessed ${service.title}');
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Access Granted'),
                              content: Text(
                                'Successfully accessed ${service.title}',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
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

  Widget _buildBusinessCard(
    BuildContext context,
    var service,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: service.enabled ? onTap : null,
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: service.color.withOpacity(service.enabled ? 0.1 : 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            service.icon,
            color: service.enabled ? service.color : Colors.grey,
            size: 32,
          ),
        ),
        title: Text(
          service.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: service.enabled ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: Text(
          service.subtitle,
          style: TextStyle(
            color: service.enabled ? Colors.grey : Colors.grey[400],
          ),
        ),
        trailing: Icon(
          service.enabled ? Icons.arrow_forward_ios : Icons.lock,
          size: 16,
          color: service.enabled ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
