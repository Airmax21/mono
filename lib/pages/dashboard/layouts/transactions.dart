import 'package:flutter/material.dart';
import 'package:mono_app/components/transaction_item.dart';
import 'package:get/get.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/size_config.dart';



final List<Map<String, dynamic>> transactions = [
  {
    "category": "food",
    "title": "Makan",
    "amount": "-Rp. 20k",
    "isIncome": false,
    "date": "09/01/24"
  },
  {
    "category": "income",
    "title": "Gaji Bulanan",
    "amount": "+Rp. 2.5m",
    "isIncome": true,
    "date": "09/01/24"
  },
  {
    "category": "shopping",
    "title": "Olshop",
    "amount": "-Rp. 20k",
    "isIncome": false,
    "date": "09/01/24"
  },
  {
    "category": "investment",
    "title": "Investment",
    "amount": "+Rp. 15k",
    "isIncome": true,
    "date": "09/01/24"
  },
];

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transactions',
                style: Get.textTheme.titleSmall,
              ),
              Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 12,
                      color: Get.isDarkMode ? Colors.white70 : Colors.black87),
                  SizedBox(width: getProportionateScreenWidth(5)),
                  Text(
                    "01/03/25",
                    style: Get.textTheme.bodySmall?.copyWith(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Get.theme.canvasColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Get.theme.shadowColor,
                    blurRadius: 5,
                    spreadRadius: 1),
              ],
            ),
            child: Column(
              children: transactions.map((transaction) {
                return Column(
                  children: [
                    TransactionItem(
                      icons: categoryIcon[transaction["category"]] ?? Icons.help_outline,
                      title: transaction["title"],
                      amount: transaction["amount"],
                      isIncome: transaction["isIncome"],
                      date: transaction["date"],
                    ),
                    if (transaction != transactions.last)
                      Divider(thickness: 2, color: Colors.white12),
                  ],
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
