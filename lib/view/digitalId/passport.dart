import 'package:flutter/material.dart';
import 'package:mykadprototype/models/user_profile.dart';

class PassportPage extends StatelessWidget {
  final UserProfile userProfile;
  
  const PassportPage({Key? key, required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passport'),
        backgroundColor: Colors.lightBlue[300],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Passport Card Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red[900]!, Colors.red[600]!],
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'MALAYSIA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const Text(
                              'PASSPORT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.flight_takeoff, color: Colors.white, size: 32),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Photo placeholder
                    Center(
                      child: Container(
                        width: 100,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildPassportInfo('Surname', userProfile.name.split(' ').last.toUpperCase()),
                    _buildPassportInfo('Given Names', userProfile.name.split(' ').first.toUpperCase()),
                    _buildPassportInfo('Nationality', 'MALAYSIAN'),
                    _buildPassportInfo('Passport No', 'A${userProfile.icNumber.substring(0, 8)}'),
                    _buildPassportInfo('IC Number', userProfile.icNumber),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPassportInfo('Date of Birth', '${userProfile.icNumber.substring(4, 6)}/${userProfile.icNumber.substring(2, 4)}/19${userProfile.icNumber.substring(0, 2)}'),
                        ),
                        Expanded(
                          child: _buildPassportInfo('Sex', 'M'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Passport Details
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
                      'Passport Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow('Type', 'Ordinary Passport'),
                    _buildDetailRow('Country Code', 'MYS'),
                    _buildDetailRow('Issue Date', '15/03/2023'),
                    _buildDetailRow('Expiry Date', '14/03/2033'),
                    _buildDetailRow('Status', 'Active'),
                    _buildDetailRow('Place of Issue', 'PUTRAJAYA'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Travel Information
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue[700]),
                        const SizedBox(width: 8),
                        const Text(
                          'Travel Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'This passport is valid for international travel. Please ensure it has at least 6 months validity before traveling.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPassportInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
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