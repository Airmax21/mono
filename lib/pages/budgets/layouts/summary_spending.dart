import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/legend_tag.dart';
import 'package:mono_app/size_config.dart';

final List<Map<String, dynamic>> getSectionsData = [
  {
    'color': Colors.blue,
    'value': 25,
    'label': '25%',
    'title': 'Makan',
  },
  {
    'color': Colors.green,
    'value': 20,
    'label': '20%',
    'title': 'Olshop',
  },
  {
    'color': Colors.orange,
    'value': 15,
    'label': '15%',
    'title': 'Listrik',
  },
  {
    'color': Colors.red,
    'value': 40,
    'label': '40%',
    'title': 'Dokter',
  },
];

List<PieChartSectionData> getSections(int touchedIndex) {
  return List.generate(getSectionsData.length, (index) {
    final item = getSectionsData[index];
    return PieChartSectionData(
      color: item['color'],
      value: item['value'].toDouble(),
      title: touchedIndex == index ? '${item['value']}%' : '',
      radius: touchedIndex == index ? 40 : 30,
    );
  });
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
            style: Get.textTheme.titleMedium,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Container(
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Get.theme.shadowColor,
                    blurRadius: 5,
                    spreadRadius: 1),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                          width: double.infinity, // Atur lebar penuh
                          height: getProportionateScreenHeight(150),
                          child: Obx(
                            () => PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                    enabled: true,
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        controller.updateTouchedIndex(-1);
                                        return;
                                      }
                                      controller.updateTouchedIndex(
                                          pieTouchResponse.touchedSection!
                                              .touchedSectionIndex);
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
                                sections:
                                    getSections(controller.touchedIndex.value),
                              ),
                            ),
                          )),
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 5,
                    children: getSectionsData.map((item) {
                      return LegendTag(
                        color: item['color'] as Color,
                        label: item['title'] as String,
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
