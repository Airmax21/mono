import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/budget_card.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/size_config.dart';

final List<Map<String, dynamic>> budgets = [
  {
    "category": Category.food,
    "title": "Makan",
    "amount": 20000.0,
    "progress": 0.35,
  },
  {
    "category": Category.shopping,
    "title": "Olshop",
    "amount": 200000.0,
    "progress": 0.65,
  },
  {
    "category": Category.bills,
    "title": "Listrik",
    "amount": 50000.0,
    "progress": 0.35,
  },
  {
    "category": Category.healthcare,
    "title": "Dokter",
    "amount": 200000.0,
    "progress": 0.75,
  },
];

class MonthlyBudgets extends StatelessWidget {
  const MonthlyBudgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Monthly Budgets',
            style: Get.textTheme.titleMedium,
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              ...budgets.map((budget) {
                return BudgetCard(
                    icons:
                        categoryIcon[budget["category"]] ?? Icons.help_outline,
                    title: budget["title"],
                    amount: budget["amount"],
                    progress: budget["progress"],
                    color: categoryColors[budget["category"]] ?? Colors.grey);
              }),
              Container(
                  width: getProportionateScreenWidth(50),
                  height: getProportionateScreenHeight(100),
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => Get.toNamed('detail_budgets'),
                      ),
                    ],
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
