import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import '../theme/app_colors.dart';
import '../viewmodels/user_profile_view_model.dart';

class AutofillScreen extends StatefulWidget {
  const AutofillScreen({super.key});

  @override
  State<AutofillScreen> createState() => _AutofillScreenState();
}

class _AutofillScreenState extends State<AutofillScreen> {
  final TextEditingController _urlController = TextEditingController();
  late WebViewController _webViewController;
  bool _isLoading = false;
  bool _showWebView = false;
  bool _hasAutofilled = false;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            if (!_hasAutofilled) {
              _autofillForm();
            }
          },
        ),
      );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _autofillForm() async {
    final userProfile = Provider.of<UserProfileViewModel>(context, listen: false).user;
    
    // JavaScript code to autofill common form fields
    final autofillScript = '''
      (function() {
        const data = {
          name: "${userProfile.name}",
          fullName: "${userProfile.name}",
          icNumber: "${userProfile.icNumber}",
          fullIC: "${userProfile.fullIC}",
          ic: "${userProfile.fullIC}",
          age: "${userProfile.age}",
          address: "${userProfile.address}",
          dateOfBirth: "${userProfile.dateOfBirth ?? ''}",
          dob: "${userProfile.dateOfBirth ?? ''}",
          phone: "${userProfile.phone ?? ''}",
          telephone: "${userProfile.phone ?? ''}",
          mobile: "${userProfile.phone ?? ''}",
          email: "${userProfile.email ?? ''}",
        };

        // Common field name patterns
        const fieldPatterns = {
          name: ['name', 'fullname', 'full_name', 'nama', 'nama_penuh'],
          ic: ['ic', 'icnumber', 'ic_number', 'nric', 'noic', 'no_ic', 'mykad'],
          address: ['address', 'alamat', 'address1', 'address_1'],
          dob: ['dob', 'dateofbirth', 'date_of_birth', 'tarikh_lahir', 'birthdate'],
          phone: ['phone', 'telephone', 'mobile', 'tel', 'hp', 'handphone'],
          email: ['email', 'e-mail', 'email_address'],
        };

        function fillField(pattern, value) {
          if (!value) return;
          
          // Try by name attribute
          pattern.forEach(p => {
            const fields = document.querySelectorAll(`input[name*="\${p}" i], input[id*="\${p}" i], textarea[name*="\${p}" i], textarea[id*="\${p}" i]`);
            fields.forEach(field => {
              if (field.type !== 'submit' && field.type !== 'button' && field.type !== 'hidden') {
                field.value = value;
                field.dispatchEvent(new Event('input', { bubbles: true }));
                field.dispatchEvent(new Event('change', { bubbles: true }));
              }
            });
          });
        }

        // Fill name fields
        fillField(fieldPatterns.name, data.name);
        
        // Fill IC fields
        fillField(fieldPatterns.ic, data.fullIC);
        
        // Fill address fields
        fillField(fieldPatterns.address, data.address);
        
        // Fill date of birth fields
        fillField(fieldPatterns.dob, data.dateOfBirth);
        
        // Fill phone fields
        fillField(fieldPatterns.phone, data.phone);
        
        // Fill email fields
        fillField(fieldPatterns.email, data.email);

        // Also try to fill by placeholder text
        document.querySelectorAll('input, textarea').forEach(field => {
          const placeholder = (field.placeholder || '').toLowerCase();
          const name = (field.name || '').toLowerCase();
          const id = (field.id || '').toLowerCase();
          
          if (placeholder.includes('name') || name.includes('name') || id.includes('name')) {
            if (!field.value && data.name) {
              field.value = data.name;
              field.dispatchEvent(new Event('input', { bubbles: true }));
            }
          }
          if (placeholder.includes('ic') || name.includes('ic') || id.includes('ic')) {
            if (!field.value && data.fullIC) {
              field.value = data.fullIC;
              field.dispatchEvent(new Event('input', { bubbles: true }));
            }
          }
          if (placeholder.includes('address') || name.includes('address') || id.includes('address')) {
            if (!field.value && data.address) {
              field.value = data.address;
              field.dispatchEvent(new Event('input', { bubbles: true }));
            }
          }
          if ((placeholder.includes('phone') || name.includes('phone') || id.includes('phone')) && 
              (placeholder.includes('mobile') || name.includes('mobile') || id.includes('mobile'))) {
            if (!field.value && data.phone) {
              field.value = data.phone;
              field.dispatchEvent(new Event('input', { bubbles: true }));
            }
          }
          if (placeholder.includes('email') || name.includes('email') || id.includes('email')) {
            if (!field.value && data.email) {
              field.value = data.email;
              field.dispatchEvent(new Event('input', { bubbles: true }));
            }
          }
        });

        return 'Autofill completed';
      })();
    ''';

    try {
      await _webViewController.runJavaScript(autofillScript);
      setState(() {
        _hasAutofilled = true;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Form autofilled successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Autofill error: $e'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  void _loadForm() async {
    if (_urlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a URL')),
      );
      return;
    }

    String url = _urlController.text.trim();
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    setState(() {
      _isLoading = true;
      _showWebView = true;
      _hasAutofilled = false;
    });

    try {
      await _webViewController.loadRequest(Uri.parse(url));
    } catch (e) {
      setState(() {
        _isLoading = false;
        _showWebView = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading URL: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfileViewModel>(context).user;

    if (_showWebView) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () {
              setState(() {
                _showWebView = false;
                _hasAutofilled = false;
              });
            },
          ),
          title: Text(
            'Form Autofill',
            style: AppTextStyles.h2.copyWith(color: AppColors.white),
          ),
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: AppColors.white),
              onPressed: () {
                setState(() {
                  _hasAutofilled = false;
                });
                _loadForm();
              },
              tooltip: 'Reload',
            ),
            IconButton(
              icon: const Icon(Icons.auto_fix_high, color: AppColors.white),
              onPressed: _autofillForm,
              tooltip: 'Autofill Again',
            ),
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _webViewController),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Autofill',
          style: AppTextStyles.h2.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Form URL',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: 8),
            Text(
              'Paste the URL of the form you want to autofill',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: 'https://example.com/form',
                prefixIcon: const Icon(Icons.link),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 24),
            Text(
              'Your Information',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow('Name', userProfile.name),
                    const Divider(),
                    _buildInfoRow('IC Number', userProfile.icNumber),
                    const Divider(),
                    _buildInfoRow('Address', userProfile.address),
                    if (userProfile.dateOfBirth != null) ...[
                      const Divider(),
                      _buildInfoRow('Date of Birth', userProfile.dateOfBirth!),
                    ],
                    if (userProfile.phone != null) ...[
                      const Divider(),
                      _buildInfoRow('Phone', userProfile.phone!),
                    ],
                    if (userProfile.email != null) ...[
                      const Divider(),
                      _buildInfoRow('Email', userProfile.email!),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.primaryBlue, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'The form will be automatically filled when the page loads',
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryBlue),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _loadForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Load Form & Autofill',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall,
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
