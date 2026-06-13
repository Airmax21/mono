import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/enums/wallet_type_enum.dart';
import 'package:mono_app/size_config.dart';
import 'package:swipe_to/swipe_to.dart';

IconData iconForWalletType(WalletType type) {
  switch (type) {
    case WalletType.cash:
      return Icons.money;
    case WalletType.bank:
      return Icons.account_balance;
    case WalletType.ewallet:
      return Icons.account_balance_wallet;
  }
}

Color colorForWalletType(WalletType type) {
  switch (type) {
    case WalletType.cash:
      return Colors.green;
    case WalletType.bank:
      return Colors.blue;
    case WalletType.ewallet:
      return Colors.orange;
  }
}

class WalletItem extends StatelessWidget {
  final WalletData wallet;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final int index;

  const WalletItem({
    super.key,
    required this.wallet,
    required this.onDelete,
    required this.onEdit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
        key: ValueKey(index),
        offsetDx: 0.25,
        iconOnRightSwipe: Icons.edit,
        leftSwipeWidget: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onRightSwipe: (details) {
          onEdit();
        },
        onLeftSwipe: (details) {
          onDelete();
        },
        child: Card(
          color: Get.theme.primaryColor,
          shadowColor: Get.theme.shadowColor,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: colorForWalletType(wallet.type),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Icon(iconForWalletType(wallet.type)),
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wallet.name,
                        style: Get.textTheme.titleMedium,
                      ),
                      Text(
                        'Rp ${NumberFormat('#,##0', 'id_ID').format(wallet.balance)}',
                        style: Get.textTheme.bodySmall,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
