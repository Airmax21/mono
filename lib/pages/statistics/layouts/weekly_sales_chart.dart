import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeeklySalesChart extends StatelessWidget {
  const WeeklySalesChart({super.key});

  final List<double> weeklyData = const [4050, 2650, 4900, 4400];
  final Color barColor = const Color(0xff5501d5);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          mainBarChartData(),
        ),
      ),
    );
  }

  BarChartData mainBarChartData() {
    return BarChartData(
      maxY: 5000, // Nilai maksimum untuk sumbu Y
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String week;
            switch (group.x.toInt()) {
              case 0:
                week = 'Week 1';
                break;
              case 1:
                week = 'Week 2';
                break;
              case 2:
                week = 'Week 3';
                break;
              case 3:
                week = 'Week 4';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$week\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Rp.${(rod.toY).round()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          // Bisa ditambahkan interaksi di sini
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: getLeftTitles,
            interval: 1000,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1000,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.black12,
            strokeWidth: 1,
            dashArray: [5, 5], // Membuat garis putus-putus
          );
        },
      ),
    );
  }

  // Fungsi untuk membuat data batang
  List<BarChartGroupData> showingGroups() => List.generate(4, (i) {
        return makeGroupData(i, weeklyData[i]);
      });

  // Membuat setiap grup batang
  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: barColor,
          width: 22,
          borderRadius: BorderRadius.circular(6), // Membuat sudut batang melengkung
        ),
      ],
    );
  }

  // Widget untuk label di sumbu bawah (X)
  Widget getBottomTitles(double value, TitleMeta meta) {
    var style = Get.textTheme.labelMedium;
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Week 1', style: style);
        break;
      case 1:
        text = Text('Week 2', style: style);
        break;
      case 2:
        text = Text('Week 3', style: style);
        break;
      case 3:
        text = Text('Week 4', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  // Widget untuk label di sumbu kiri (Y)
  Widget getLeftTitles(double value, TitleMeta meta) {
    var style = Get.textTheme.labelSmall;
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 1000) {
      text = '1000';
    } else if (value == 2000) {
      text = '2000';
    } else if (value == 3000) {
      text = '3000';
    } else if (value == 4000) {
      text = '4000';
    } else if (value == 5000) {
      text = '5000';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(text, style: style),
    );
  }
}