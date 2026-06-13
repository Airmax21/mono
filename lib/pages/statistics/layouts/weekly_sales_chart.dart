import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/controllers/statistics_controller.dart';

class WeeklySalesChart extends StatelessWidget {
  const WeeklySalesChart({super.key});

  final Color barColor = const Color(0xff5501d5);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StatisticsController>();

    return Obx(() {
      final stats = controller.statistics.value;
      if (controller.isLoading.value && stats == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final rawWeeklyData = stats?.weeklyExpenses ?? [];
      final List<double> weeklyData = List.generate(4, (index) {
        if (index < rawWeeklyData.length) {
          return rawWeeklyData[index];
        }
        return 0.0;
      });

      // Find the maximum value to scale the Y axis properly
      double maxVal = 1000.0;
      for (final val in weeklyData) {
        if (val > maxVal) {
          maxVal = val;
        }
      }
      
      // Scale max Y nicely
      double maxY = 1000.0;
      if (maxVal > 1000) {
        maxY = ((maxVal / 1000).ceil() * 1000).toDouble();
      } else if (maxVal > 100) {
        maxY = ((maxVal / 100).ceil() * 100).toDouble();
      }

      return AspectRatio(
        aspectRatio: 1.6,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarChart(
            mainBarChartData(weeklyData, maxY),
          ),
        ),
      );
    });
  }

  BarChartData mainBarChartData(List<double> weeklyData, double maxY) {
    double interval = maxY / 5;
    if (interval <= 0) interval = 200;

    return BarChartData(
      maxY: maxY,
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
            final val = rod.toY;
            String formattedValue;
            if (val >= 1000000) {
              formattedValue = 'Rp. ${(val / 1000000).toStringAsFixed(1)}M';
            } else if (val >= 1000) {
              formattedValue = 'Rp. ${(val / 1000).toStringAsFixed(0)}K';
            } else {
              formattedValue = 'Rp. ${val.round()}';
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
                  text: formattedValue,
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
            reservedSize: 45,
            getTitlesWidget: (val, meta) => getLeftTitles(val, meta, maxY),
            interval: interval,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(weeklyData),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: interval,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.black12,
            strokeWidth: 1,
            dashArray: [5, 5],
          );
        },
      ),
    );
  }

  List<BarChartGroupData> showingGroups(List<double> weeklyData) => List.generate(4, (i) {
        return makeGroupData(i, weeklyData[i]);
      });

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: barColor,
          width: 22,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }

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

  Widget getLeftTitles(double value, TitleMeta meta, double maxY) {
    var style = Get.textTheme.labelSmall;
    String text = value.round().toString();
    if (value >= 1000000) {
      text = '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      text = '${(value / 1000).toStringAsFixed(0)}K';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(text, style: style),
    );
  }
}