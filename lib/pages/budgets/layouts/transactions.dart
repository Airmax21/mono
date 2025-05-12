import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/transaction_item.dart';
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
  {
    "category": "food",
    "title": "Makan",
    "amount": "-Rp. 20k",
    "isIncome": false,
    "date": "10/01/24"
  },
  {
    "category": "income",
    "title": "Gaji Bulanan",
    "amount": "+Rp. 2.5m",
    "isIncome": true,
    "date": "10/01/24"
  },
  {
    "category": "shopping",
    "title": "Olshop",
    "amount": "-Rp. 20k",
    "isIncome": false,
    "date": "10/01/24"
  },
  {
    "category": "investment",
    "title": "Investment",
    "amount": "+Rp. 15k",
    "isIncome": true,
    "date": "10/01/24"
  },
  {
    "category": "food",
    "title": "Makan",
    "amount": "-Rp. 20k",
    "isIncome": false,
    "date": "11/01/24"
  },
  {
    "category": "income",
    "title": "Gaji Bulanan",
    "amount": "+Rp. 2.5m",
    "isIncome": true,
    "date": "11/01/24"
  },
  {
    "category": "shopping",
    "title": "Olshop",
    "amount": "-Rp. 20k",
    "isIncome": false,
    "date": "11/01/24"
  },
  {
    "category": "investment",
    "title": "Investment",
    "amount": "+Rp. 15k",
    "isIncome": true,
    "date": "11/01/24"
  },
];

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    final grouped = groupBy(transactions, (tx) => tx['date']);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Transactions',
            style: Get.textTheme.titleSmall,
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          // ListView(
          //   children: grouped.entries.map((entry) {
          //     final date = entry.key;
          //     final txs = entry.value;

          //     return Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Padding(
          //           padding:
          //               EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          //           child: Text(
          //             date,
          //             style: Get.textTheme.titleSmall,
          //           ),
          //         ),
          //         // ...txs.map((tx) {
          //         //   return Column(
          //         //     children: [
          //         //       TransactionItem(
          //         //         icons: categoryIcon[tx["category"]] ??
          //         //             Icons.help_outline,
          //         //         title: tx["title"],
          //         //         amount: tx["amount"],
          //         //         isIncome: tx["isIncome"],
          //         //         date: tx["date"],
          //         //       ),
          //         //     ],
          //         //   );
          //         // }).toList()
          //       ],
          //     );
          //   }).toList(),
          // )
        ],
      ),
    );
  }
}
