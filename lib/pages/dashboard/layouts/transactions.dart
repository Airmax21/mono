import 'package:flutter/material.dart';
import 'package:mono_app/components/transaction_item.dart';
import 'package:get/get.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/enums/transaction_type_enum.dart';
import 'package:mono_app/controllers/transactions_controller.dart';
import 'package:mono_app/size_config.dart';

class Transactions extends StatelessWidget {
  Transactions({super.key});

  final transactionsController = Get.find<TransactionsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: Get.textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Get.theme.shadowColor,
                      blurRadius: 5,
                      spreadRadius: 1),
                ],
              ),
              child: Obx(() {
                final transactions = transactionsController.transactions;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];

                    return Column(
                      children: [
                        TransactionItem(
                          icons: categoryIcon[transaction.category] ??
                              Icons.help_outline,
                          title: transaction.name,
                          amount: transaction.price,
                          isIncome: transaction.transactionType ==
                              TransactionType.income,
                          date: transaction.createdAt,
                          index: index,
                          onDelete: () {},
                          onEdit: () {},
                        ),
                        if (transaction != transactions.last)
                          const Divider(thickness: 2, color: Colors.white12),
                      ],
                    );
                  },
                );
              }))
        ],
      ),
    );
  }
}
