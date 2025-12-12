import 'package:flutter/material.dart';
import 'package:mykadprototype/models/user_profile.dart';

class DriverLicensePage extends StatelessWidget {
  final UserProfile userProfile;
  
  const DriverLicensePage({Key? key, required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver License'),
        backgroundColor: Colors.lightBlue[300],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // License Card Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[700]!, Colors.blue[400]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'DRIVER LICENSE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Icon(Icons.drive_eta, color: Colors.white, size: 32),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    Center(
                      child: Container(
                        width: 100,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildLicenseInfo('Name', userProfile.name),
                    _buildLicenseInfo('IC Number', userProfile.icNumber),
                    _buildLicenseInfo('License No', 'DL${userProfile.icNumber.substring(0, 8)}'),
                    _buildLicenseInfo('Class', 'D, DA'),
                    _buildLicenseInfo('Valid Until', '31/12/2028'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 30),

                // Image of real driver license
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://metafin.com.my/blog/wp-content/uploads/2025/07/JPJ-Lesen-Memandu-Malaysia-Depan.webp",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              // Additional Information
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'License Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow('Issue Date', '01/01/2023'),
                    _buildDetailRow('Expiry Date', '31/12/2028'),
                    _buildDetailRow('Status', 'Active'),
                    _buildDetailRow('Demerit Points', '0/20'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLicenseInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}