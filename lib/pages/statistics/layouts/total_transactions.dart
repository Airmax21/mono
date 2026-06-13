import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/stat_card.dart';
import 'package:mono_app/controllers/statistics_controller.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StatisticsController>();
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 2);

    return Obx(() {
      final stats = controller.statistics.value;
      if (controller.isLoading.value && stats == null) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      final revenueVal = stats != null ? currencyFormatter.format(stats.totalRevenue) : '0,00';
      final revenueChangeVal = stats != null ? 'Rp.${currencyFormatter.format(stats.revenueChange.abs())}' : 'Rp.0,00';
      final revenuePctVal = stats != null 
          ? '${stats.revenuePercentageChange >= 0 ? '+' : ''}${stats.revenuePercentageChange.toStringAsFixed(2)}%'
          : '+0.00%';
      final revenueColor = stats != null && stats.revenuePercentageChange >= 0 ? Colors.green.shade600 : Colors.red.shade600;

      final expenseVal = stats != null ? currencyFormatter.format(stats.totalExpenditure) : '0,00';
      final expenseChangeVal = stats != null ? 'Rp.${currencyFormatter.format(stats.expenditureChange.abs())}' : 'Rp.0,00';
      final expensePctVal = stats != null 
          ? '${stats.expenditurePercentageChange >= 0 ? '+' : ''}${stats.expenditurePercentageChange.toStringAsFixed(2)}%'
          : '+0.00%';
      final expenseColor = stats != null && stats.expenditurePercentageChange >= 0 ? Colors.red.shade600 : Colors.green.shade600;

      return Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            StatCard(
              title: 'total_revenue'.tr,
              subtitle: 'Rp',
              mainValue: revenueVal,
              changeValue: revenueChangeVal,
              percentageChange: revenuePctVal,
              indicatorColor: revenueColor,
              icon: Icons.trending_up,
            ),
            StatCard(
              title: 'total_expenditure'.tr,
              subtitle: 'Rp',
              mainValue: expenseVal,
              changeValue: expenseChangeVal,
              percentageChange: expensePctVal,
              indicatorColor: expenseColor,
              icon: Icons.trending_down,
            ),
          ],
        ),
      );
    });
  }
}
