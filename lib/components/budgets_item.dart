import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/budget_card.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:swipe_to/swipe_to.dart';

class BudgetsItem extends StatelessWidget {
  final Budget budget;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final int index;

  const BudgetsItem({
    super.key,
    required this.budget,
    required this.onDelete,
    required this.onEdit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    double progress = budget.amount > 0 ? (budget.spent / budget.amount) : 0.0;
    if (progress < 0.0) progress = 0.0;

    return SwipeTo(
      key: ValueKey(index),
      offsetDx: 0.25,
      iconOnRightSwipe: Icons.edit,
      leftSwipeWidget: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onRightSwipe: (details) {
        onEdit();
      },
      onLeftSwipe: (details) {
        onDelete();
      },
      child: GestureDetector(
        onTap: onEdit,
        child: BudgetCard(
            title: budget.category.name.capitalizeFirst!,
            icons: categoryIcon[budget.category]!,
            amount: budget.amount,
            progress: progress,
            color: categoryColors[budget.category]!),
      ),
    );
  }
}
