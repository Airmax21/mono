import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';

class TransactionItem extends StatelessWidget {
  final IconData icons;
  final String title;
  final double amount;
  final bool isIncome;
  final DateTime date;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final bool isSwipeAble;

  const TransactionItem({
    super.key,
    required this.icons,
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.date,
    required this.index,
    required this.onDelete,
    required this.onEdit,
    this.isSwipeAble = false,
  });

  Widget _buildTransactionContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icons,
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
                const SizedBox(height: 4),
                Text(DateFormat('dd MMMM yyyy HH:mm').format(date),
                    style: Get.textTheme.bodySmall
                        ?.copyWith(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(
            "Rp. ${NumberFormat('#,##0', 'id_ID').format(amount)}",
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

  @override
  Widget build(BuildContext context) {
    final content = _buildTransactionContent(context);

    if (isSwipeAble) {
      return SwipeTo(
        key: ValueKey(index),
        offsetDx: 0.25,
        iconOnRightSwipe: Icons.edit,
        leftSwipeWidget: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onRightSwipe: (details) => onEdit(),
        onLeftSwipe: (details) => onDelete(),
        child: GestureDetector(
          onTap: onEdit,
          onLongPress: onDelete,
          child: content,
        ),
      );
    }

    return content;
  }
}
