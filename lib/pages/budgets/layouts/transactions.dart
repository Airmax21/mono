import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mono_app/components/transaction_item.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/enums/transaction_type_enum.dart';
import 'package:mono_app/controllers/transactions_controller.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transactions',
                style: Get.textTheme.titleMedium,
              ),
              Obx(() {
                final date = transactionsController.filterDate.value;
                return Row(
                  children: [
                    if (date != null)
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.clear, size: 16),
                        onPressed: () => transactionsController.filterDate.value = null,
                        tooltip: 'Clear Filter',
                      ),
                    if (date != null) const SizedBox(width: 8),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: date ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          transactionsController.filterDate.value = picked;
                        }
                      },
                      icon: const Icon(Icons.date_range, size: 14),
                      label: Text(
                        date != null
                            ? DateFormat('dd/MM/yyyy').format(date)
                            : 'date_filter'.tr,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          Obx(() {
            final grouped = groupBy(transactionsController.filteredTransactions,
                (tx) => DateFormat('dd MMMM yyyy').format(tx.createdAt));
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: grouped.length,
              itemBuilder: (BuildContext context, int index) {
                final entry = grouped.entries.elementAt(index);
                final date = entry.key;
                final txs = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        date,
                        style: Get.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w200),
                      ),
                    ),
                    ...txs.map((tx) {
                      return TransactionItem(
                        icons: categoryIcon[tx.category] ?? Icons.help_outline,
                        title: tx.name,
                        amount: tx.price,
                        isIncome: tx.transactionType == TransactionType.income,
                        date: tx.createdAt,
                        index: index,
                        onDelete: () =>
                            transactionsController.deleteTransaction(tx),
                        onEdit: () =>
                            Get.toNamed('/transactions', arguments: tx.id),
                        isSwipeAble: true,
                      );
                    })
                  ],
                );
              },
            );
          })
        ],
      ),
    );
  }
}
