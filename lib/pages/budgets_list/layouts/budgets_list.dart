import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/budgets_item.dart';
import 'package:mono_app/controllers/budgets_controller.dart';

class BudgetsList extends StatelessWidget {
  const BudgetsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BudgetsController>();
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            final budgets = controller.budgets;

            if (budgets.isEmpty) {
              return const Center(child: Text('Belum ada wallet'));
            }

            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: budgets.length,
                itemBuilder: (context, index) {
                  final budget = budgets[index];
                  return BudgetsItem(
                    index: index,
                    budget: budget,
                    onEdit: () {
                      // controller.editWallet(budget);
                    },
                    onDelete: () {
                      // controller.deleteWallet(budget);
                    },
                  );
                });
          })
        ],
      ),
    );
  }
}
