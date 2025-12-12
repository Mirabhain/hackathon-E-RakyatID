import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../viewmodels/eligibility_viewmodel.dart';

class EligibilityCheckScreen extends StatelessWidget {
  final UserProfile userProfile;
  final Function(String) onLog;

  const EligibilityCheckScreen({
    Key? key,
    required this.userProfile,
    required this.onLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = EligibilityViewModel();
    final eligibilityList = viewModel.getEligibility(userProfile);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eligibility Check'),
        backgroundColor: const Color(0xFFf97316),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Eligibility Status',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Automatically checked based on your profile',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),

            Expanded(
              child: ListView.builder(
                itemCount: eligibilityList.length,
                itemBuilder: (context, index) {
                  final item = eligibilityList[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: item.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(item.icon, color: item.color, size: 32),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        item.eligible ? 'You are eligible' : 'Not eligible',
                        style: TextStyle(
                          color:
                              item.eligible ? Colors.green : Colors.grey,
                        ),
                      ),
                      trailing: Icon(
                        item.eligible ? Icons.check_circle : Icons.cancel,
                        color: item.eligible ? Colors.green : Colors.grey,
                        size: 32,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
