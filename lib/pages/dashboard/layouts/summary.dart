import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/controllers/transactions_controller.dart';
import 'package:mono_app/size_config.dart';
import 'package:intl/intl.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  String _formatCompactCurrency(double value) {
    final absVal = value.abs();
    String text;
    if (absVal >= 1000000) {
      text = '${(absVal / 1000000).toStringAsFixed(1)}M';
    } else if (absVal >= 1000) {
      text = '${(absVal / 1000).toStringAsFixed(0)}K';
    } else {
      text = absVal.round().toString();
    }
    return 'Rp. $text';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionsController>();
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Get.theme.primaryColor,
                  Get.theme.scaffoldBackgroundColor,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Obx(() {
              final totalBal = controller.totalBalance.value;
              final stats = controller.dashboardStatistics.value;
              final weeklyRev = stats?.weeklyRevenue ?? [0.0, 0.0, 0.0, 0.0];
              final weeklyExp = stats?.weeklyExpenses ?? [0.0, 0.0, 0.0, 0.0];

              final spotsIncome = List.generate(
                weeklyRev.length,
                (i) => FlSpot(i.toDouble(), weeklyRev[i]),
              );
              final spotsExpense = List.generate(
                weeklyExp.length,
                (i) => FlSpot(i.toDouble(), weeklyExp[i]),
              );

              // Calculate maxY to scale graph
              double maxVal = 100.0;
              for (final val in [...weeklyRev, ...weeklyExp]) {
                if (val > maxVal) {
                  maxVal = val;
                }
              }
              final maxY = ((maxVal / 100).ceil() * 100).toDouble();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'balance'.tr,
                    style: Get.textTheme.bodyMedium,
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Text(
                    'Rp. ${currencyFormatter.format(totalBal)}',
                    style: Get.textTheme.titleMedium,
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'weekly_overview'.tr,
                        style: Get.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  
                  // Graph Area
                  SizedBox(
                    height: getProportionateScreenHeight(120),
                    child: LineChart(
                      LineChartData(
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                String formattedValue;
                                final val = spot.y;
                                if (val >= 1000000) {
                                  formattedValue = 'Rp. ${(val / 1000000).toStringAsFixed(1)}M';
                                } else if (val >= 1000) {
                                  formattedValue = 'Rp. ${(val / 1000).toStringAsFixed(0)}K';
                                } else {
                                  formattedValue = 'Rp. ${val.round()}';
                                }
                                return LineTooltipItem(
                                  formattedValue,
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        minX: 0,
                        maxX: 3,
                        minY: 0,
                        maxY: maxY,
                        lineBarsData: [
                          // Income Line (Green)
                          LineChartBarData(
                            spots: spotsIncome,
                            isCurved: true,
                            color: Colors.green,
                            barWidth: 3,
                            dotData: const FlDotData(show: true),
                          ),
                          // Expense Line (Red)
                          LineChartBarData(
                            spots: spotsExpense,
                            isCurved: true,
                            color: Colors.redAccent,
                            barWidth: 3,
                            dotData: const FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          
          // Floating Summary Overlay
          Transform.translate(
            offset: const Offset(0, 150),
            child: Container(
              width: getProportionateScreenWidth(290),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Get.isDarkMode ? Get.theme.scaffoldBackgroundColor : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Get.isDarkMode ? Colors.black26 : Colors.black.withValues(alpha: 0.08), 
                    blurRadius: 8, 
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Obx(() {
                final stats = controller.dashboardStatistics.value;
                final totalRev = stats?.totalRevenue ?? 0.0;
                final totalExp = stats?.totalExpenditure ?? 0.0;
                final netBalance = totalRev - totalExp;

                final isDark = Get.isDarkMode;
                final dividerColor = isDark ? Colors.white24 : Colors.black.withValues(alpha: 0.1);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Income
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              _formatCompactCurrency(totalRev),
                              style: Get.textTheme.bodyMedium?.copyWith(color: Colors.green, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.arrow_upward, size: 14, color: Colors.green),
                        ],
                      ),
                    ),
                    
                    // Divider
                    Container(height: 20, width: 1, color: dividerColor),
                    
                    // Expense
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              '-${_formatCompactCurrency(totalExp)}',
                              style: Get.textTheme.bodyMedium?.copyWith(color: Colors.red, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.arrow_downward, size: 14, color: Colors.red),
                        ],
                      ),
                    ),
                    
                    // Divider
                    Container(height: 20, width: 1, color: dividerColor),
                    
                    // Net/Shift
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              _formatCompactCurrency(netBalance.abs()),
                              style: Get.textTheme.bodyMedium?.copyWith(color: Colors.lightBlue, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Transform.rotate(
                            angle: 1.5708,
                            child: const Icon(Icons.compare_arrows, size: 14, color: Colors.lightBlue),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
