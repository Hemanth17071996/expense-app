import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/expense_model.dart';
import '../models/user_model.dart';
import '../services/app_data_service.dart';
import '../widgets/glass_card.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final AppDataService _dataService = AppDataService();
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Cloud & Software',
    'Food & Dining',
    'Travel & Transport',
    'Hardware & Equipment',
    'Utilities & Bills',
    'Office & Supplies',
  ];

  @override
  void initState() {
    super.initState();
    _dataService.addListener(_onDataChanged);
  }

  @override
  void dispose() {
    _dataService.removeListener(_onDataChanged);
    super.dispose();
  }

  void _onDataChanged() {
    if (mounted) setState(() {});
  }

  void _openAddExpenseModal({ExpenseModel? existing}) {
    final titleController =
        TextEditingController(text: existing != null ? existing.title : '');
    final amountController = TextEditingController(
        text: existing != null ? existing.amount.toStringAsFixed(0) : '');
    final notesController =
        TextEditingController(text: existing != null ? existing.notes : '');

    String category = existing != null ? existing.category : 'Cloud & Software';
    String paymentMethod =
        existing != null ? existing.paymentMethod : 'UPI';
    UserModel selectedUser = existing != null
        ? (_dataService.getUserById(existing.paidById) ??
            _dataService.users.first)
        : _dataService.users.first;
    DateTime selectedDate = existing != null ? existing.date : DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          existing != null ? 'Edit Expense' : 'Add Daily Expense',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: AppColors.textMuted),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.cardGlassBorder),
                    const SizedBox(height: 12),

                    // Title
                    const Text('Expense Title / Reason',
                        style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'e.g. AWS Cloud, Client Travel, Lunch',
                        hintStyle: const TextStyle(color: AppColors.textMuted),
                        filled: true,
                        fillColor: const Color(0xFF1E293B),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Amount Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Amount (₹)',
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary)),
                              const SizedBox(height: 6),
                              TextField(
                                controller: amountController,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  prefixText: '₹ ',
                                  prefixStyle: const TextStyle(
                                      color: AppColors.cyan,
                                      fontWeight: FontWeight.bold),
                                  hintText: '0.00',
                                  hintStyle:
                                      const TextStyle(color: AppColors.textMuted),
                                  filled: true,
                                  fillColor: const Color(0xFF1E293B),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Payment Method',
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary)),
                              const SizedBox(height: 6),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E293B),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButton<String>(
                                  value: paymentMethod,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  dropdownColor: const Color(0xFF1E293B),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 13),
                                  items: ['UPI', 'Credit Card', 'Cash', 'Net Banking']
                                      .map((m) => DropdownMenuItem(
                                          value: m, child: Text(m)))
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setModalState(() => paymentMethod = val);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Category Dropdown
                    const Text('Category',
                        style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        value: category,
                        isExpanded: true,
                        underline: const SizedBox(),
                        dropdownColor: const Color(0xFF1E293B),
                        style: const TextStyle(color: Colors.white, fontSize: 13.5),
                        items: _categories
                            .where((c) => c != 'All')
                            .map((c) => DropdownMenuItem(
                                  value: c,
                                  child: Row(
                                    children: [
                                      Icon(
                                        ExpenseModel.getCategoryIcon(c),
                                        color:
                                            ExpenseModel.getCategoryColor(c),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(c),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() => category = val);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Paid By User Dropdown (Multi-User selection)
                    const Text('Paid By (Select User)',
                        style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<UserModel>(
                        value: selectedUser,
                        isExpanded: true,
                        underline: const SizedBox(),
                        dropdownColor: const Color(0xFF1E293B),
                        items: _dataService.users
                            .map((u) => DropdownMenuItem<UserModel>(
                                  value: u,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: u.avatarColor,
                                        child: Text(
                                          u.initials,
                                          style: const TextStyle(
                                              fontSize: 9,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${u.displayName} (${u.role})',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() => selectedUser = val);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Optional Notes
                    const Text('Notes / Remarks',
                        style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: notesController,
                      maxLines: 2,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Add invoice number or specific details...',
                        hintStyle: const TextStyle(color: AppColors.textMuted),
                        filled: true,
                        fillColor: const Color(0xFF1E293B),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          final title = titleController.text.trim();
                          final amount =
                              double.tryParse(amountController.text.trim()) ?? 0.0;

                          if (title.isEmpty || amount <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please provide a valid title and amount!'),
                                backgroundColor: AppColors.rose,
                              ),
                            );
                            return;
                          }

                          if (existing != null) {
                            final updated = ExpenseModel(
                              id: existing.id,
                              title: title,
                              amount: amount,
                              category: category,
                              date: selectedDate,
                              paidById: selectedUser.id,
                              paidByName: selectedUser.displayName,
                              paymentMethod: paymentMethod,
                              notes: notesController.text.trim(),
                            );
                            _dataService.updateExpense(updated);
                          } else {
                            final newExpense = ExpenseModel(
                              id: 'exp-${DateTime.now().millisecondsSinceEpoch}',
                              title: title,
                              amount: amount,
                              category: category,
                              date: DateTime.now(),
                              paidById: selectedUser.id,
                              paidByName: selectedUser.displayName,
                              paymentMethod: paymentMethod,
                              notes: notesController.text.trim(),
                            );
                            _dataService.addExpense(newExpense);
                          }

                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(existing != null
                                  ? 'Expense updated successfully!'
                                  : 'Expense added to tracker!'),
                              backgroundColor: AppColors.emerald,
                            ),
                          );
                        },
                        child: Text(
                          existing != null ? 'Update Expense' : 'Save Expense',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredExpenses = _dataService.expenses.where((e) {
      final matchesCategory =
          _selectedCategory == 'All' || e.category == _selectedCategory;
      final matchesQuery = _searchQuery.isEmpty ||
          e.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          e.paidByName.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C1019),
        elevation: 0,
        title: const Text(
          'Daily Expense Tracker',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppColors.cyan),
            tooltip: 'Add Expense',
            onPressed: () => _openAddExpenseModal(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Expense',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: () => _openAddExpenseModal(),
      ),
      body: Column(
        children: [
          // Header summary pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: const Color(0xFF0E1424),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Recorded Expenses',
                        style: TextStyle(
                            color: AppColors.textMuted, fontSize: 11)),
                    const SizedBox(height: 2),
                    Text(
                      '₹${_dataService.totalSpend.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: AppColors.cyan,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.emerald.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: AppColors.emerald.withOpacity(0.3)),
                  ),
                  child: Text(
                    '${_dataService.expenses.length} Records',
                    style: const TextStyle(
                      color: AppColors.emerald,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              style: const TextStyle(color: Colors.white, fontSize: 13.5),
              decoration: InputDecoration(
                hintText: 'Search by title, merchant, or user...',
                hintStyle:
                    const TextStyle(color: AppColors.textMuted, fontSize: 13),
                prefixIcon: const Icon(Icons.search,
                    color: AppColors.textMuted, size: 20),
                filled: true,
                fillColor: const Color(0xFF131B2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.cardGlassBorder),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),

          // Horizontal Category Filter Pills
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: _categories.length,
              itemBuilder: (context, idx) {
                final cat = _categories[idx];
                final isSelected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    backgroundColor: const Color(0xFF131B2E),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.cardGlassBorder,
                    ),
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 6),

          // Expense List View
          Expanded(
            child: filteredExpenses.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.receipt_long_outlined,
                            size: 48, color: AppColors.textMuted),
                        SizedBox(height: 12),
                        Text(
                          'No expenses found',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Tap + Add Expense to track spending',
                          style: TextStyle(
                              color: AppColors.textMuted, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                    itemCount: filteredExpenses.length,
                    itemBuilder: (context, index) {
                      final exp = filteredExpenses[index];
                      final catColor =
                          ExpenseModel.getCategoryColor(exp.category);
                      final catIcon =
                          ExpenseModel.getCategoryIcon(exp.category);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111827),
                          borderRadius: BorderRadius.circular(14),
                          border:
                              Border.all(color: AppColors.cardGlassBorder),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          leading: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: catColor.withOpacity(0.14),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: catColor.withOpacity(0.3)),
                            ),
                            child: Icon(catIcon, color: catColor, size: 22),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  exp.title,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Text(
                                '₹${exp.amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.06),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      exp.category,
                                      style: TextStyle(
                                        color: catColor,
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${exp.date.day}/${exp.date.month}/${exp.date.year}',
                                    style: const TextStyle(
                                        color: AppColors.textMuted,
                                        fontSize: 11),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 1.5),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.primary.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      exp.paymentMethod,
                                      style: const TextStyle(
                                        color: AppColors.primaryLight,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.person,
                                      size: 13, color: AppColors.textMuted),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Paid by: ${exp.paidByName}',
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 11.5,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () =>
                                        _openAddExpenseModal(existing: exp),
                                    child: const Text('Edit',
                                        style: TextStyle(
                                            color: AppColors.cyan,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(width: 14),
                                  GestureDetector(
                                    onTap: () {
                                      _dataService.deleteExpense(exp.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Expense record deleted'),
                                          backgroundColor: AppColors.rose,
                                        ),
                                      );
                                    },
                                    child: const Text('Delete',
                                        style: TextStyle(
                                            color: AppColors.rose,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
