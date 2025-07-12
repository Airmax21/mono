import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mono_app/components/transaction_item.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/enums/transaction_type_enum.dart';
import 'package:mono_app/pages/transactions/controllers/transactions_controller.dart';
import 'package:mono_app/size_config.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionsController = Get.find<TransactionsController>();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Transactions',
            style: Get.textTheme.titleMedium,
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          Obx(() {
            final grouped = groupBy(
                transactionsController.transactions, (tx) => DateFormat('dd MMMM yyyy').format(tx.createdAt));
            return ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: grouped.entries.map((entry) {
                final date = entry.key;
                final txs = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        date,
                        style: Get.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w200),
                      ),
                    ),
                    ...txs.map((tx) {
                      return Column(
                        children: [
                          TransactionItem(
                            icons:
                                categoryIcon[tx.category] ?? Icons.help_outline,
                            title: tx.name,
                            amount: tx.price,
                            isIncome:
                                tx.transactionType == TransactionType.income,
                            date: tx.createdAt,
                          ),
                        ],
                      );
                    })
                  ],
                );
              }).toList(),
            );
          })
        ],
      ),
    );
  }
}
