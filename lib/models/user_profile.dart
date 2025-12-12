class UserProfile {

  final String name;
  final String icNumber;
  final String fullIC;
  final int age;
  final bool isStudent;
  final bool isSeniorCitizen;
  final bool hasHealthRecord;
  final bool isEmployee;
  final String address;
  int loyaltyPoints;
  final String? dateOfBirth;
  final String? phone;
  final String? email;

  UserProfile({
    required this.name,
    required this.icNumber,
    required this.fullIC,
    required this.age,
    required this.isStudent,
    required this.isSeniorCitizen,
    required this.hasHealthRecord,
    required this.isEmployee,
    required this.address,
    required this.loyaltyPoints,
    this.dateOfBirth,
    this.phone,
    this.email,
  });
}
