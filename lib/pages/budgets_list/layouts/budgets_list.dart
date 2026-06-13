import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/budgets_item.dart';
import 'package:mono_app/controllers/budgets_controller.dart';
import 'package:mono_app/pages/budgets_list/layouts/form_budgets.dart';

class BudgetsList extends StatelessWidget {
  const BudgetsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BudgetsController>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(() {
            final budgets = controller.budgets;

            if (budgets.isEmpty) {
              return Center(child: Text('no_budgets'.tr));
            }

            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: budgets.length,
                itemBuilder: (context, index) {
                  final budget = budgets[index];
                  return BudgetsItem(
                    index: index,
                    budget: budget,
                    onEdit: () {
                      Get.dialog(FormBudgets(budgetToEdit: budget));
                    },
                    onDelete: () {
                      controller.deleteBudget(budget);
                    },
                  );
                });
          })
        ],
      ),
    );
  }
}
