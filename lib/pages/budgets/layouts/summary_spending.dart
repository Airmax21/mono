import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/size_config.dart';

List<PieChartSectionData> getSections(int touchedIndex) {
  return [
    PieChartSectionData(
      color: Colors.blue,
      value: 25,
      title: touchedIndex == 0 ? '25%' : '',
      radius: touchedIndex == 0 ? 40 : 30,
    ),
    PieChartSectionData(
      color: Colors.green,
      value: 20,
      title: touchedIndex == 1 ? '20%' : '',
      radius: touchedIndex == 1 ? 40 : 30,
    ),
    PieChartSectionData(
      color: Colors.orange,
      value: 15,
      title: touchedIndex == 2 ? '15%' : '',
      radius: touchedIndex == 2 ? 40 : 30,
    ),
    PieChartSectionData(
      color: Colors.red,
      value: 40,
      title: touchedIndex == 3 ? '40%' : '',
      radius: touchedIndex == 3 ? 40 : 30,
    ),
  ];
}

class PieChartController extends GetxController {
  var touchedIndex = (-1).obs;

  void updateTouchedIndex(int index) {
    touchedIndex.value = index;
  }
}

class SummarySpending extends StatelessWidget {
  const SummarySpending({super.key});

  @override
  Widget build(BuildContext context) {
    final PieChartController controller = Get.put(PieChartController());
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your Account Spendings',
            style: Get.textTheme.titleSmall,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Container(
              height: getProportionateScreenHeight(250),
              decoration: BoxDecoration(
                color: Get.theme.canvasColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Get.theme.shadowColor,
                      blurRadius: 5,
                      spreadRadius: 1),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Obx(
                    () => PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                            enabled: true,
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                controller.updateTouchedIndex(-1);
                                return;
                              }
                              controller.updateTouchedIndex(pieTouchResponse
                                  .touchedSection!.touchedSectionIndex);
                            }),
                        borderData: FlBorderData(
                          show: true, // Pastikan border ditampilkan
                          border: Border.all(
                            width: 5, // Atur ketebalan border
                            color: Colors.grey, // Warna border
                          ),
                        ),
                        sectionsSpace: 5,
                        centerSpaceRadius: 70,
                        sections: getSections(controller.touchedIndex.value),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Rp.53K',
                          style: Get.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        '34 Transactions',
                        style: Get.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
