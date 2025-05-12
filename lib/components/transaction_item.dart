import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionItem extends StatelessWidget {
  final IconData icons;
  final String title;
  final String amount;
  final bool isIncome;
  final String date;

  const TransactionItem({
    super.key,
    required this.icons,
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            this.icons,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Get.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500)),
                SizedBox(height: 4),
                Text(date,
                    style: Get.textTheme.bodySmall
                        ?.copyWith(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(
            amount,
            style: Get.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),
          Icon(
            isIncome ? Icons.arrow_upward : Icons.arrow_downward,
            color: isIncome ? Colors.green : Colors.red,
            size: 14,
          ),
        ],
      ),
    );
  }
}
