import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/budget_card.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/size_config.dart';

final List<Map<String, dynamic>> budgets = [
  {
    "category": Category.food,
    "title": "Makan",
    "amount": "Rp. 20k",
    "progress": 0.35,
  },
  {
    "category": Category.shopping,
    "title": "Olshop",
    "amount": "Rp. 200k",
    "progress": 0.65,
  },
  {
    "category": Category.bills,
    "title": "Listrik",
    "amount": "Rp. 50k",
    "progress": 0.35,
  },
  {
    "category": Category.healthcare,
    "title": "Dokter",
    "amount": "Rp. 200k",
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
            child: Row(
              children: budgets.map((budget) {
                   return BudgetCard(
                        icons: categoryIcon[budget["category"]] ?? Icons.help_outline,
                        title: budget["title"],
                        amount: "${budget["amount"]}/month",
                        progress: budget["progress"],
                        color: categoryColors[budget["category"]] ?? Colors.grey);
                  }).toList(),
            ),
          ) 
        ],
      ),
    );
  }
}
