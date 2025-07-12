import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mono_app/pages/statistics/layouts/total_transactions.dart';
import 'package:mono_app/pages/statistics/layouts/weekly_sales_chart.dart';
import 'package:mono_app/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Statistics',
                    style: Get.textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Text(
                    'Overall',
                    style: Get.textTheme.bodyLarge,
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  // Panggil widget grafik di sini
                  Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(350),
                    decoration: BoxDecoration(
                      color: Get.theme.canvasColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(10),
                    child: const WeeklySalesChart(),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  DashboardScreen()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
