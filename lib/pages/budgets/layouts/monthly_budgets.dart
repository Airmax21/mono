import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/budget_card.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/controllers/budgets_controller.dart';
import 'package:mono_app/size_config.dart';

class MonthlyBudgets extends StatelessWidget {
  const MonthlyBudgets({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BudgetsController>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'monthly_budgets'.tr,
            style: Get.textTheme.titleMedium,
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Obx(() {
            final list = controller.budgets;

            if (list.isEmpty) {
              final isDark = Get.isDarkMode;
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 48,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'no_budgets_current_month'.tr,
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: isDark ? Colors.white70 : Colors.black54,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => Get.toNamed('/detail_budgets'),
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: Text(
                        'set_first_budget'.tr,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3757CA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...list.map((budget) {
                    double progress = budget.amount > 0 ? (budget.spent / budget.amount) : 0.0;
                    if (progress > 1.0) progress = 1.0;
                    if (progress < 0.0) progress = 0.0;

                    final catName = budget.category.name;
                    final capitalized = catName.isNotEmpty
                        ? catName[0].toUpperCase() + catName.substring(1)
                        : 'Lainnya';

                    return BudgetCard(
                      icons: categoryIcon[budget.category] ?? Icons.help_outline,
                      title: capitalized,
                      amount: budget.amount,
                      progress: progress,
                      color: categoryColors[budget.category] ?? Colors.grey,
                      width: getProportionateScreenWidth(250),
                      margin: const EdgeInsets.only(right: 15),
                    );
                  }),
                  
                  // "+" button card at the end of the scroll list
                  GestureDetector(
                    onTap: () => Get.toNamed('/detail_budgets'),
                    child: Container(
                      width: getProportionateScreenWidth(70),
                      height: getProportionateScreenHeight(100),
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Get.isDarkMode ? Colors.white24 : Colors.black.withValues(alpha: 0.1), 
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Get.isDarkMode ? Colors.white : Colors.black87,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
