import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String username;
  final String displayName;
  final String role;
  final String email;
  final String phone;
  final String initials;
  final Color avatarColor;
  final DateTime joinedDate;

  UserModel({
    required this.id,
    required this.username,
    required this.displayName,
    required this.role,
    required this.email,
    this.phone = '+91 9655774087',
    required this.initials,
    this.avatarColor = const Color(0xFF6366F1),
    DateTime? joinedDate,
  }) : joinedDate = joinedDate ?? DateTime.now();

  static UserModel createHemanthSession() {
    return UserModel(
      id: 'usr-1',
      username: 'Hemanth',
      displayName: 'Hemanthkumar N',
      role: 'Admin / Lead Engineer',
      email: 'hemanth17071996@gmail.com',
      phone: '+91 9655774087',
      initials: 'HK',
      avatarColor: const Color(0xFF6366F1),
    );
  }

  static List<UserModel> getInitialUsers() {
    return [
      createHemanthSession(),
      UserModel(
        id: 'usr-2',
        username: 'Priya',
        displayName: 'Priya Sharma',
        role: 'Finance Manager',
        email: 'priya.finance@example.com',
        phone: '+91 9840123456',
        initials: 'PS',
        avatarColor: const Color(0xFF06B6D4),
      ),
      UserModel(
        id: 'usr-3',
        username: 'Rajesh',
        displayName: 'Rajesh Kumar',
        role: 'Operations Lead',
        email: 'rajesh.ops@example.com',
        phone: '+91 9789123456',
        initials: 'RK',
        avatarColor: const Color(0xFF10B981),
      ),
      UserModel(
        id: 'usr-4',
        username: 'Ananya',
        displayName: 'Ananya Patel',
        role: 'Product Designer',
        email: 'ananya.design@example.com',
        phone: '+91 9444123456',
        initials: 'AP',
        avatarColor: const Color(0xFFF59E0B),
      ),
    ];
  }
}
