import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class EducationScreen extends StatelessWidget {
  final UserProfile userProfile;

  const EducationScreen({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education Services'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Education Services',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Access your educational records and certificates',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),
              
              // Exam Results Section
              _buildSectionHeader(
                icon: Icons.assignment,
                title: 'Exam Results',
                subtitle: 'View your examination results',
              ),
              const SizedBox(height: 12),
              _buildExamResultCard(
                context,
                title: 'UPSR',
                subtitle: 'Ujian Pencapaian Sekolah Rendah',
                icon: Icons.school,
                color: Colors.blue,
                onTap: () => _showExamResults(context, 'UPSR'),
              ),
              _buildExamResultCard(
                context,
                title: 'PT3',
                subtitle: 'Pentaksiran Tingkatan 3',
                icon: Icons.assignment,
                color: Colors.green,
                onTap: () => _showExamResults(context, 'PT3'),
              ),
              _buildExamResultCard(
                context,
                title: 'SPM',
                subtitle: 'Sijil Pelajaran Malaysia',
                icon: Icons.verified,
                color: Colors.orange,
                onTap: () => _showExamResults(context, 'SPM'),
              ),
              _buildExamResultCard(
                context,
                title: 'STPM',
                subtitle: 'Sijil Tinggi Persekolahan Malaysia',
                icon: Icons.workspace_premium,
                color: Colors.purple,
                onTap: () => _showExamResults(context, 'STPM'),
              ),
              
              const SizedBox(height: 24),
              
              // Co-curriculum Certificates Section
              _buildSectionHeader(
                icon: Icons.emoji_events,
                title: 'Co-curriculum Certificates',
                subtitle: 'Sports, clubs, and competitions',
              ),
              const SizedBox(height: 12),
              _buildCertificateCard(
                context,
                title: 'Sports Certificates',
                subtitle: 'Athletics, competitions, achievements',
                icon: Icons.sports_soccer,
                color: Colors.red,
                onTap: () => _showCertificates(context, 'Sports'),
              ),
              _buildCertificateCard(
                context,
                title: 'Club Certificates',
                subtitle: 'Clubs and societies participation',
                icon: Icons.groups,
                color: Colors.teal,
                onTap: () => _showCertificates(context, 'Clubs'),
              ),
              _buildCertificateCard(
                context,
                title: 'Competition Certificates',
                subtitle: 'Academic and non-academic competitions',
                icon: Icons.stars,
                color: Colors.amber,
                onTap: () => _showCertificates(context, 'Competitions'),
              ),
              
              const SizedBox(height: 24),
              
              // School Leaving Certificates Section
              _buildSectionHeader(
                icon: Icons.description,
                title: 'School Leaving Certificates',
                subtitle: 'Official school completion documents',
              ),
              const SizedBox(height: 12),
              _buildCertificateCard(
                context,
                title: 'School Leaving Certificate',
                subtitle: 'Official completion certificate',
                icon: Icons.school,
                color: Colors.indigo,
                onTap: () => _showSchoolLeaving(context),
              ),
              
              const SizedBox(height: 24),
              
              // Trial Exam Results Section
              _buildSectionHeader(
                icon: Icons.quiz,
                title: 'Trial Exam Results',
                subtitle: 'MOE API supported trial examinations',
              ),
              const SizedBox(height: 12),
              _buildExamResultCard(
                context,
                title: 'Trial Exam Results',
                subtitle: 'View trial exam results (MOE API)',
                icon: Icons.assessment,
                color: Colors.cyan,
                onTap: () => _showTrialResults(context),
              ),
              
              const SizedBox(height: 24),
              
              // Qualification Certificates Section
              _buildSectionHeader(
                icon: Icons.card_membership,
                title: 'Qualification Certificates',
                subtitle: 'Certificates from programs and courses',
              ),
              const SizedBox(height: 12),
              _buildCertificateCard(
                context,
                title: 'Professional Certificates',
                subtitle: 'Industry-recognized qualifications',
                icon: Icons.work_outline,
                color: Colors.deepPurple,
                onTap: () => _showQualificationCertificates(context, 'Professional'),
              ),
              _buildCertificateCard(
                context,
                title: 'Training Programs',
                subtitle: 'Workshops and training course certificates',
                icon: Icons.person_outline,
                color: Colors.pink,
                onTap: () => _showQualificationCertificates(context, 'Training'),
              ),
              _buildCertificateCard(
                context,
                title: 'Online Courses',
                subtitle: 'Digital learning platform certificates',
                icon: Icons.computer,
                color: Colors.blueGrey,
                onTap: () => _showQualificationCertificates(context, 'Online Courses'),
              ),
              _buildCertificateCard(
                context,
                title: 'Skill Development',
                subtitle: 'Skills and competency certificates',
                icon: Icons.build,
                color: Colors.deepOrange,
                onTap: () => _showQualificationCertificates(context, 'Skill Development'),
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blue.shade700, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExamResultCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey.shade400,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildCertificateCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey.shade400,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showExamResults(BuildContext context, String examType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$examType Results'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${userProfile.name}'),
            Text('IC Number: ${userProfile.icNumber}'),
            const SizedBox(height: 16),
            const Text(
              'Results will be displayed here once connected to MOE API.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCertificates(BuildContext context, String category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$category Certificates'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${userProfile.name}'),
            Text('IC Number: ${userProfile.icNumber}'),
            const SizedBox(height: 16),
            const Text(
              'Certificates will be displayed here once connected to MOE API.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSchoolLeaving(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('School Leaving Certificate'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${userProfile.name}'),
            Text('IC Number: ${userProfile.icNumber}'),
            const SizedBox(height: 16),
            const Text(
              'School leaving certificate will be displayed here once connected to MOE API.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showTrialResults(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Trial Exam Results'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${userProfile.name}'),
            Text('IC Number: ${userProfile.icNumber}'),
            const SizedBox(height: 16),
            const Text(
              'Trial exam results will be displayed here once connected to MOE API.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showQualificationCertificates(BuildContext context, String category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$category Certificates'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${userProfile.name}'),
              Text('IC Number: ${userProfile.icNumber}'),
              const SizedBox(height: 16),
              const Text(
                'Qualification certificates from programs will be displayed here.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              const Text(
                'This includes certificates from:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text('• Professional development programs'),
              const Text('• Training workshops'),
              const Text('• Online courses'),
              const Text('• Skill development programs'),
              const Text('• Continuing education courses'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

