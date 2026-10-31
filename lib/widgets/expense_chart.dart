import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/expense_model.dart';
import '../services/app_data_service.dart';

class ExpenseChartWidget extends StatelessWidget {
  final AppDataService dataService;

  const ExpenseChartWidget({Key? key, required this.dataService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final last7Days = dataService.getLast7DaysData();
    double maxAmount = 1.0;
    for (final item in last7Days) {
      if ((item['amount'] as double) > maxAmount) {
        maxAmount = item['amount'] as double;
      }
    }

    final categoryMap = dataService.categoryBreakdown;
    final totalSpend = dataService.totalSpend;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Daily Spend Bar Chart
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Weekly Spending Trend',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.primary.withOpacity(0.25)),
              ),
              child: const Text(
                'Last 7 Days',
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Custom Bar Chart Render
        SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: last7Days.map((item) {
              final amount = item['amount'] as double;
              final day = item['day'] as String;
              final heightPercent = (amount / maxAmount).clamp(0.08, 1.0);
              final isToday = day == last7Days.last['day'];

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (amount > 0)
                        Text(
                          '₹${amount >= 1000 ? (amount / 1000).toStringAsFixed(1) + 'k' : amount.toInt()}',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: isToday
                                ? AppColors.cyan
                                : AppColors.textSecondary,
                          ),
                        )
                      else
                        const SizedBox(height: 12),
                      const SizedBox(height: 4),
                      Container(
                        height: 70 * heightPercent,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: isToday
                              ? AppColors.primaryGradient
                              : LinearGradient(
                                  colors: [
                                    AppColors.primary.withOpacity(0.6),
                                    AppColors.primary.withOpacity(0.2),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                          boxShadow: isToday
                              ? [
                                  BoxShadow(
                                    color: AppColors.cyan.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              : null,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        day,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight:
                              isToday ? FontWeight.bold : FontWeight.w500,
                          color: isToday
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),

        // Category Breakdown Progress Bars
        const Text(
          'Top Spending Categories',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),

        if (categoryMap.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'No expenses recorded yet.',
              style: TextStyle(color: AppColors.textMuted, fontSize: 12),
            ),
          )
        else
          ...categoryMap.entries.map((entry) {
            final category = entry.key;
            final amount = entry.value;
            final percent = totalSpend > 0 ? (amount / totalSpend) : 0.0;
            final color = ExpenseModel.getCategoryColor(category);

            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            ExpenseModel.getCategoryIcon(category),
                            color: color,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            category,
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '₹${amount.toStringAsFixed(0)} (${(percent * 100).toStringAsFixed(0)}%)',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: percent,
                      backgroundColor: const Color(0xFF1E293B),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
      ],
    );
  }
}
