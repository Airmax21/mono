import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mono_app/size_config.dart';

class BudgetCard extends StatelessWidget {
  final String title;
  final IconData icons;
  final double amount;
  final double progress;
  final Color color;
  final double? width;
  final EdgeInsetsGeometry? margin;

  const BudgetCard({
    super.key,
    required this.title,
    required this.icons,
    required this.amount,
    required this.progress,
    required this.color,
    this.width,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress > 1.0 ? 1.0 : progress;
    final progressColor = progress >= 1.0
        ? Colors.red
        : (progress >= 0.95 ? Colors.orange : color);

    return Container(
      width: width ?? double.infinity,
      height: getProportionateScreenHeight(100),
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icons,
            size: 30,
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Get.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text("Rp. ${NumberFormat('#,##0', 'id_ID').format(amount)}",
                        style: Get.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                    if (progress >= 0.95) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: progress >= 1.0 ? Colors.red : Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          progress >= 1.0 ? "100%+" : "95%+",
                          style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: getProportionateScreenHeight(13),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final fullWidth = constraints.maxWidth;
                      return Stack(
                        children: [
                          Container(
                            height: getProportionateScreenHeight(13),
                            width: fullWidth,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Container(
                            height: getProportionateScreenHeight(13),
                            width: fullWidth * clampedProgress,
                            decoration: BoxDecoration(
                              color: progressColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${(progress * 100).toInt()}%",
                                    style: Get.textTheme.bodySmall?.copyWith(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
