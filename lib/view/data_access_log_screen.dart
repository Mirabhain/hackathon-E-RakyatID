import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DataAccessLogScreen extends StatelessWidget {
  const DataAccessLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample access log data
    final accessLogs = [
      {
        'organization': 'Ministry of Health',
        'purpose': 'Health Record Access',
        'date': '2024-01-15 14:30:25',
        'dataAccessed': ['Name', 'IC Number', 'Health Records'],
        'status': 'Authorized',
      },
      {
        'organization': 'JPJ (Road Transport Department)',
        'purpose': 'Driver License Verification',
        'date': '2024-01-10 09:15:10',
        'dataAccessed': ['Name', 'IC Number', 'Driver License'],
        'status': 'Authorized',
      },
      {
        'organization': 'Ministry of Education',
        'purpose': 'Student Verification',
        'date': '2024-01-05 11:45:30',
        'dataAccessed': ['Name', 'IC Number', 'Education Records'],
        'status': 'Authorized',
      },
      {
        'organization': 'Unknown Source',
        'purpose': 'Unauthorized Access Attempt',
        'date': '2024-01-03 16:20:15',
        'dataAccessed': ['All Data'],
        'status': 'Blocked',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Access Log', style: AppTextStyles.h2.copyWith(color: AppColors.white)),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: AppColors.primaryBlue.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Who Viewed Your Data',
                  style: AppTextStyles.h3,
                ),
                const SizedBox(height: 8),
                Text(
                  'Track all organizations and services that have accessed your information',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: accessLogs.length,
              itemBuilder: (context, index) {
                final log = accessLogs[index];
                final isBlocked = log['status'] == 'Blocked';
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isBlocked ? Colors.red.shade300 : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isBlocked 
                                    ? Colors.red.shade50 
                                    : AppColors.primaryBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                isBlocked ? Icons.block : Icons.verified_user,
                                color: isBlocked 
                                    ? Colors.red.shade700 
                                    : AppColors.primaryBlue,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    log['organization'] as String,
                                    style: AppTextStyles.bodyLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    log['purpose'] as String,
                                    style: AppTextStyles.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isBlocked 
                                    ? Colors.red.shade50 
                                    : Colors.green.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                log['status'] as String,
                                style: TextStyle(
                                  color: isBlocked 
                                      ? Colors.red.shade700 
                                      : Colors.green.shade700,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              log['date'] as String,
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Data Accessed:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: (log['dataAccessed'] as List<String>).map((data) {
                            return Chip(
                              label: Text(
                                data,
                                style: const TextStyle(fontSize: 11),
                              ),
                              backgroundColor: Colors.grey.shade100,
                              padding: EdgeInsets.zero,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

