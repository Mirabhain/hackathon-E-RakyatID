import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/data_consent_viewmodel.dart';

class DataConsentScreen extends StatelessWidget {
  final Function(String) onShare;

  const DataConsentScreen({Key? key, required this.onShare}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DataConsentViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Consent'),
        backgroundColor: const Color(0xFF10b981),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Share with Bank XYZ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Select the information you want to share',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),

            Expanded(
              child: ListView(
                children: viewModel.consents.keys.map((key) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: CheckboxListTile(
                      title: Text(key),
                      subtitle: Text('Share your $key'),
                      value: viewModel.consents[key],
                      activeColor: const Color(0xFF10b981),
                      onChanged: (value) {
                        viewModel.toggleConsent(key, value ?? false);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            ElevatedButton(
              onPressed: viewModel.hasSelected
                  ? () {
                      onShare('Bank XYZ');
                      Navigator.pop(context);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10b981),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: const Text(
                'Confirm & Share',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
