import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/size_config.dart';

class BudgetCard extends StatelessWidget {
  final String title;
  final IconData icons;
  final String amount;
  final double progress;
  final Color color;

  BudgetCard(
      {super.key,
      required this.title,
      required this.icons,
      required this.amount,
      required this.progress,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(250),
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.canvasColor,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icons,
            size: 30,
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: Get.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(amount, style: Get.textTheme.bodySmall
                        ?.copyWith(color: Colors.grey)),
              SizedBox(height: 12),
              Stack(
                children: [
                  Container(
                    height: getProportionateScreenHeight(13),
                    width: getProportionateScreenWidth(150),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    height: getProportionateScreenHeight(13),
                    width: getProportionateScreenWidth(150) *
                        progress, // Panjang progres
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${(progress * 100).toInt()}%",
                            style:
                                Get.textTheme.bodySmall?.copyWith(fontSize: 10),
                          )
                        ]),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
