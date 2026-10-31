import 'package:flutter/material.dart';

class ChatMessageModel {
  final String id;
  final String senderName;
  final String senderRole;
  final String senderInitials;
  final Color avatarColor;
  final String message;
  final DateTime timestamp;
  final String? relatedExpenseId;

  ChatMessageModel({
    required this.id,
    required this.senderName,
    required this.senderRole,
    required this.senderInitials,
    required this.avatarColor,
    required this.message,
    required this.timestamp,
    this.relatedExpenseId,
  });

  static List<ChatMessageModel> getInitialMessages() {
    final now = DateTime.now();
    return [
      ChatMessageModel(
        id: 'msg-1',
        senderName: 'Hemanthkumar N',
        senderRole: 'Admin / Lead',
        senderInitials: 'HK',
        avatarColor: const Color(0xFF6366F1),
        message: 'Welcome team! Please log all daily project & travel expenses here.',
        timestamp: now.subtract(const Duration(hours: 4)),
      ),
      ChatMessageModel(
        id: 'msg-2',
        senderName: 'Priya Sharma',
        senderRole: 'Finance Manager',
        senderInitials: 'PS',
        avatarColor: const Color(0xFF06B6D4),
        message: 'Approved the ₹3,450 AWS cloud hosting invoice for October.',
        timestamp: now.subtract(const Duration(hours: 3)),
      ),
      ChatMessageModel(
        id: 'msg-3',
        senderName: 'Rajesh Kumar',
        senderRole: 'Operations Lead',
        senderInitials: 'RK',
        avatarColor: const Color(0xFF10B981),
        message: 'Updated daily cab travel expense (₹520) for the onsite client sprint demo.',
        timestamp: now.subtract(const Duration(hours: 1)),
      ),
      ChatMessageModel(
        id: 'msg-4',
        senderName: 'Ananya Patel',
        senderRole: 'Product Designer',
        senderInitials: 'AP',
        avatarColor: const Color(0xFFF59E0B),
        message: 'Hardware peripherals and ergonomic keyboards received and verified!',
        timestamp: now.subtract(const Duration(minutes: 25)),
      ),
    ];
  }
}
