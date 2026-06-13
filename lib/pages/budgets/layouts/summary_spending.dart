import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/legend_tag.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/enums/transaction_type_enum.dart';
import 'package:mono_app/controllers/transactions_controller.dart';
import 'package:mono_app/size_config.dart';
import 'package:intl/intl.dart';

class SummarySpending extends StatelessWidget {
  const SummarySpending({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionsController = Get.find<TransactionsController>();
    final touchedIndex = (-1).obs;
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'your_account_spendings'.tr,
            style: Get.textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Get.theme.shadowColor,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Obx(() {
              final now = DateTime.now();
              // Filter transactions to show current month expense categories
              final currentMonthTxs = transactionsController.transactions.where((tx) {
                return tx.transactionType == TransactionType.expense &&
                    tx.createdAt.year == now.year &&
                    tx.createdAt.month == now.month;
              }).toList();

              if (currentMonthTxs.isEmpty) {
                final isDark = Get.isDarkMode;
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  child: Column(
                    children: [
                      Icon(
                        Icons.pie_chart_outline,
                        size: 64,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'no_spending_current_month'.tr,
                        style: Get.textTheme.bodyMedium?.copyWith(
                          color: isDark ? Colors.white60 : Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              // Sum expenses per category
              double totalExpense = 0.0;
              final Map<Category, double> categorySums = {};
              for (final tx in currentMonthTxs) {
                totalExpense += tx.price;
                categorySums[tx.category] = (categorySums[tx.category] ?? 0.0) + tx.price;
              }

              // Create sections data
              final List<Map<String, dynamic>> sectionsData = [];
              categorySums.forEach((category, sum) {
                final percentage = totalExpense > 0 ? (sum / totalExpense) * 100 : 0.0;
                final catName = category.name;
                final label = catName.isNotEmpty
                    ? catName[0].toUpperCase() + catName.substring(1)
                    : 'Lainnya';
                sectionsData.add({
                  'category': category,
                  'color': categoryColors[category] ?? Colors.grey,
                  'value': percentage,
                  'sum': sum,
                  'title': label,
                });
              });

              // Sort by value (descending)
              sectionsData.sort((a, b) => b['value'].compareTo(a['value']));
              final int txCount = currentMonthTxs.length;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: getProportionateScreenHeight(150),
                          child: Obx(() {
                            final idx = touchedIndex.value;
                            return PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  enabled: true,
                                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection == null) {
                                      touchedIndex.value = -1;
                                      return;
                                    }
                                    touchedIndex.value = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                  },
                                ),
                                sectionsSpace: 4,
                                centerSpaceRadius: 70,
                                sections: List.generate(sectionsData.length, (index) {
                                  final item = sectionsData[index];
                                  final isTouched = idx == index;
                                  final radius = isTouched ? 40.0 : 30.0;
                                  return PieChartSectionData(
                                    color: item['color'] as Color,
                                    value: item['value'] as double,
                                    title: isTouched ? '${(item['value'] as double).toStringAsFixed(1)}%' : '',
                                    radius: radius,
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  );
                                }),
                              ),
                            );
                          }),
                        ),
                        
                        // Center Info overlay text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Rp. ${currencyFormatter.format(totalExpense)}',
                              style: Get.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '$txCount ${'transactions_count'.tr}',
                              style: Get.textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Legend tag wrapping list
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 24),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 8,
                      children: sectionsData.map((item) {
                        return LegendTag(
                          color: item['color'] as Color,
                          label: '${item['title']} (${(item['value'] as double).toStringAsFixed(0)}%)',
                        );
                      }).toList(),
                    ),
                  )
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
