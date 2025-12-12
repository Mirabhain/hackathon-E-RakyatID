import 'package:flutter/material.dart';
import '../models/business_access_model.dart';
import '../models/user_profile.dart';

class BusinessAccessViewModel extends ChangeNotifier {
  final UserProfile user;

  BusinessAccessViewModel(this.user);

  List<BusinessService> get businessServices => [
        BusinessService(
          title: 'Employee Portal',
          subtitle: 'Access company resources',
          icon: Icons.business_center,
          color: Colors.teal,
          enabled: user.isEmployee,
        ),
        BusinessService(
          title: 'Payroll System',
          subtitle: 'View salary information',
          icon: Icons.payment,
          color: Colors.green,
          enabled: user.isEmployee,
        ),
        BusinessService(
          title: 'Leave Management',
          subtitle: 'Apply for leave',
          icon: Icons.event_available,
          color: Colors.blue,
          enabled: user.isEmployee,
        ),
        BusinessService(
          title: 'HR Services',
          subtitle: 'Contact human resources',
          icon: Icons.people,
          color: Colors.purple,
          enabled: user.isEmployee,
        ),
      ];
}

class PrivateVerificationViewModel extends ChangeNotifier {
  List<VerificationAttribute> get attributes => [
        VerificationAttribute(
          title: 'Age Verification',
          subtitle: 'Prove you are 18+',
          icon: Icons.cake,
          color: Colors.purple,
          value: 'Age: 18+',
        ),
        VerificationAttribute(
          title: 'Citizenship Status',
          subtitle: 'Verify Malaysian citizenship',
          icon: Icons.flag,
          color: Colors.red,
          value: 'Citizenship: Malaysian',
        ),
        VerificationAttribute(
          title: 'Residential State',
          subtitle: 'Verify state of residence',
          icon: Icons.location_on,
          color: Colors.blue,
          value: 'State: Kuala Lumpur',
        ),
        VerificationAttribute(
          title: 'Gender Verification',
          subtitle: 'Verify gender attribute',
          icon: Icons.person,
          color: Colors.green,
          value: 'Gender: Male',
        ),
      ];
}
