import 'package:flutter/material.dart';

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String paidById;
  final String paidByName;
  final String paymentMethod;
  final String notes;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.paidById,
    required this.paidByName,
    this.paymentMethod = 'UPI',
    this.notes = '',
  });

  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food & dining':
      case 'food':
        return Icons.restaurant_rounded;
      case 'travel & transport':
      case 'travel':
        return Icons.directions_car_rounded;
      case 'office & supplies':
      case 'office':
        return Icons.business_center_rounded;
      case 'cloud & software':
      case 'cloud':
        return Icons.cloud_done_rounded;
      case 'utilities & bills':
      case 'bills':
        return Icons.receipt_long_rounded;
      case 'hardware & equipment':
      case 'hardware':
        return Icons.computer_rounded;
      default:
        return Icons.shopping_bag_rounded;
    }
  }

  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food & dining':
      case 'food':
        return const Color(0xFFF59E0B); // Amber
      case 'travel & transport':
      case 'travel':
        return const Color(0xFF06B6D4); // Cyan
      case 'office & supplies':
      case 'office':
        return const Color(0xFF8B5CF6); // Purple
      case 'cloud & software':
      case 'cloud':
        return const Color(0xFF6366F1); // Indigo
      case 'utilities & bills':
      case 'bills':
        return const Color(0xFFEF4444); // Red/Rose
      case 'hardware & equipment':
      case 'hardware':
        return const Color(0xFF10B981); // Emerald
      default:
        return const Color(0xFF38BDF8); // Sky blue
    }
  }

  static List<ExpenseModel> getSampleExpenses() {
    final now = DateTime.now();
    return [
      ExpenseModel(
        id: 'exp-1',
        title: 'AWS Cloud Hosting & DB Cluster',
        amount: 3450.00,
        category: 'Cloud & Software',
        date: now.subtract(const Duration(hours: 3)),
        paidById: 'usr-1',
        paidByName: 'Hemanthkumar N',
        paymentMethod: 'Credit Card',
        notes: 'Monthly RDS PostgreSQL and ECS container hosting invoice.',
      ),
      ExpenseModel(
        id: 'exp-2',
        title: 'Team Working Lunch & Refreshments',
        amount: 850.00,
        category: 'Food & Dining',
        date: now.subtract(const Duration(hours: 6)),
        paidById: 'usr-2',
        paidByName: 'Priya Sharma',
        paymentMethod: 'UPI',
        notes: 'Sprint planning lunch with backend developers.',
      ),
      ExpenseModel(
        id: 'exp-3',
        title: 'Client Onsite Client Travel / Cab',
        amount: 520.00,
        category: 'Travel & Transport',
        date: now.subtract(const Duration(days: 1, hours: 2)),
        paidById: 'usr-3',
        paidByName: 'Rajesh Kumar',
        paymentMethod: 'UPI',
        notes: 'Cab visit for customer maintenance requirements meeting.',
      ),
      ExpenseModel(
        id: 'exp-4',
        title: 'Ergonomic Keyboards & USB Hubs',
        amount: 2100.00,
        category: 'Hardware & Equipment',
        date: now.subtract(const Duration(days: 2)),
        paidById: 'usr-1',
        paidByName: 'Hemanthkumar N',
        paymentMethod: 'Net Banking',
        notes: 'Development peripherals for QA testing workstation.',
      ),
      ExpenseModel(
        id: 'exp-5',
        title: 'High-Speed Fiber Internet Bill',
        amount: 1199.00,
        category: 'Utilities & Bills',
        date: now.subtract(const Duration(days: 3)),
        paidById: 'usr-4',
        paidByName: 'Ananya Patel',
        paymentMethod: 'UPI',
        notes: 'Monthly office broadband lease line.',
      ),
    ];
  }
}
