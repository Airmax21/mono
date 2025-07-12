import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/enums/wallet_type_enum.dart';

IconData iconForWalletType(WalletType type) {
  switch (type) {
    case WalletType.cash:
      return Icons.money;
    case WalletType.bank:
      return Icons.account_balance;
    case WalletType.ewallet:
      return Icons.account_balance_wallet;
    default:
      return Icons.wallet;
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
    default:
      return Colors.grey;
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
    return Dismissible(
      key: ValueKey(index),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onEdit();
        } else if (direction == DismissDirection.endToStart) {
          onDelete();
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: colorForWalletType(wallet.type),
                child: Icon(iconForWalletType(wallet.type)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wallet.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Rp ${wallet.balance.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
                tooltip: 'Delete',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
