import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/controllers/statistics_controller.dart';
import 'package:mono_app/pages/statistics/layouts/total_transactions.dart';
import 'package:mono_app/pages/statistics/layouts/weekly_sales_chart.dart';
import 'package:mono_app/size_config.dart';
import 'package:intl/intl.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StatisticsController>();

    return RefreshIndicator(
      onRefresh: () => controller.fetchStatistics(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(10)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'statistics'.tr,
                          style: Get.textTheme.titleLarge,
                        ),
                        // Month Dropdown selector
                        Obx(() {
                          final now = DateTime.now();
                          final months = List.generate(6, (index) {
                            final date = DateTime(now.year, now.month - index, 1);
                            return {
                              'value': '${date.year}-${date.month.toString().padLeft(2, '0')}',
                              'label': DateFormat('MMMM yyyy').format(date)
                            };
                          });

                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: controller.selectedMonth.value,
                                dropdownColor: Get.theme.primaryColor,
                                icon: Icon(
                                  Icons.arrow_drop_down, 
                                  color: Get.isDarkMode ? Colors.white : Colors.black87,
                                ),
                                style: TextStyle(
                                  color: Get.isDarkMode ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                items: months.map((m) {
                                  return DropdownMenuItem<String>(
                                    value: m['value'],
                                    child: Text(m['label']!),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    controller.changeMonth(val);
                                  }
                                },
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Text(
                      'overall_spending'.tr,
                      style: Get.textTheme.bodyLarge,
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    
                    // Weekly chart container
                    Container(
                      width: double.infinity,
                      height: getProportionateScreenHeight(350),
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
                      padding: const EdgeInsets.all(10),
                      child: const WeeklySalesChart(),
                    ),
                    
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const DashboardScreen(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
