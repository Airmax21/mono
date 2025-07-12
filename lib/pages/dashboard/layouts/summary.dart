import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/size_config.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Get.theme.primaryColor,
                      Get.theme.scaffoldBackgroundColor
                    ]),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // DropdownButton<String>(
                //   dropdownColor: Colors.blueAccent,
                //   value: 'February',
                //   style: TextStyle(color: Colors.white),
                //   onChanged: (String? newValue) {},
                //   items: <String>['January', 'February', 'March']
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // ),
                Text(
                  'Saldo',
                  style: Get.textTheme.bodyMedium,
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  'Rp. 120.000',
                  style: Get.textTheme.titleMedium,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Last 3 Months',
                      style: Get.textTheme.titleMedium,
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(120),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 1000),
                            FlSpot(1, 1090),
                            FlSpot(2, 980),
                            FlSpot(3, 1050),
                            FlSpot(4, 1020),
                            FlSpot(5, 1000),
                            FlSpot(6, 1090),
                            FlSpot(7, 980),
                            FlSpot(8, 1050),
                            FlSpot(9, 1020),
                          ],
                          isCurved: true,
                          color: Colors.green,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 1010),
                            FlSpot(1, 1050),
                            FlSpot(2, 1000),
                            FlSpot(3, 1000),
                            FlSpot(4, 1040),
                            FlSpot(5, 990),
                            FlSpot(6, 1090),
                            FlSpot(7, 910),
                            FlSpot(8, 1030),
                            FlSpot(9, 1000),
                          ],
                          isCurved: true,
                          color: Colors.redAccent,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Transform.translate(
              offset: Offset(0, 170),
              child: Container(
                width: getProportionateScreenWidth(280),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Get.theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text('Income',
                        //     style: Get.textTheme.bodyMedium
                        //         ?.copyWith(color: Colors.green)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Rp. 10K',
                              style: Get.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.green),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_upward,
                              size: 18,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text('Expense',
                        //     style: Get.textTheme.bodyMedium
                        //         ?.copyWith(color: Colors.red)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '-Rp. 10K',
                              style: Get.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.red),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_downward,
                              size: 18,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text('Shift',
                        //     style: Get.textTheme.bodyMedium
                        //         ?.copyWith(color: Colors.lightBlue)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Rp. 10K',
                              style: Get.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.lightBlue),
                            ),
                            SizedBox(width: 4),
                            Transform.rotate(
                              angle: 1.5708,
                              child: Icon(Icons.compare_arrows,
                                  size: 18, color: Colors.lightBlue),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
