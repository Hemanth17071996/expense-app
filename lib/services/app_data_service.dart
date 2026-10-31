import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/expense_model.dart';
import '../models/chat_model.dart';

class AppDataService extends ChangeNotifier {
  static final AppDataService _instance = AppDataService._internal();
  factory AppDataService() => _instance;

  AppDataService._internal() {
    _users = UserModel.getInitialUsers();
    _expenses = ExpenseModel.getSampleExpenses();
    _chatMessages = ChatMessageModel.getInitialMessages();
  }

  late List<UserModel> _users;
  late List<ExpenseModel> _expenses;
  late List<ChatMessageModel> _chatMessages;

  List<UserModel> get users => List.unmodifiable(_users);
  List<ExpenseModel> get expenses => List.unmodifiable(_expenses);
  List<ChatMessageModel> get chatMessages => List.unmodifiable(_chatMessages);

  // --- User Operations ---
  void addUser(UserModel user) {
    _users.insert(0, user);
    notifyListeners();
  }

  void deleteUser(String id) {
    _users.removeWhere((u) => u.id == id);
    notifyListeners();
  }

  UserModel? getUserById(String id) {
    try {
      return _users.firstWhere((u) => u.id == id);
    } catch (_) {
      return null;
    }
  }

  // --- Expense Operations ---
  void addExpense(ExpenseModel expense) {
    _expenses.insert(0, expense);
    notifyListeners();
  }

  void updateExpense(ExpenseModel updated) {
    final idx = _expenses.indexWhere((e) => e.id == updated.id);
    if (idx != -1) {
      _expenses[idx] = updated;
      notifyListeners();
    }
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // --- Chat Operations ---
  void addChatMessage(ChatMessageModel message) {
    _chatMessages.insert(0, message);
    notifyListeners();
  }

  // --- Analytics & Chart Data ---
  double get totalSpend =>
      _expenses.fold(0.0, (sum, item) => sum + item.amount);

  double get todaySpend {
    final now = DateTime.now();
    return _expenses
        .where((e) =>
            e.date.year == now.year &&
            e.date.month == now.month &&
            e.date.day == now.day)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get thisMonthSpend {
    final now = DateTime.now();
    return _expenses
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  // Category breakdown for charts
  Map<String, double> get categoryBreakdown {
    final map = <String, double>{};
    for (final e in _expenses) {
      map[e.category] = (map[e.category] ?? 0.0) + e.amount;
    }
    return map;
  }

  // Last 7 days breakdown for bar chart
  List<Map<String, dynamic>> getLast7DaysData() {
    final list = <Map<String, dynamic>>[];
    final now = DateTime.now();

    for (int i = 6; i >= 0; i--) {
      final day = now.subtract(Duration(days: i));
      final dayLabel = _getDayName(day.weekday);

      final total = _expenses
          .where((e) =>
              e.date.year == day.year &&
              e.date.month == day.month &&
              e.date.day == day.day)
          .fold(0.0, (sum, item) => sum + item.amount);

      list.add({
        'day': dayLabel,
        'amount': total,
        'date': day,
      });
    }
    return list;
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }
}
