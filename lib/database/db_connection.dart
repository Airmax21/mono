import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mono_app/database/DAO/budgets_dao.dart';
import 'package:mono_app/database/DAO/transactions_dao.dart';
import 'package:mono_app/database/DAO/wallet_dao.dart';
import 'package:mono_app/database/entity/transactions.dart';
import 'package:mono_app/database/entity/wallet.dart';
import 'package:mono_app/database/entity/budgets.dart';
import 'package:mono_app/enums/budget_period_enum.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/enums/currency_type_enum.dart';
import 'package:mono_app/enums/transaction_type_enum.dart';
import 'package:mono_app/enums/wallet_type_enum.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'db_connection.g.dart';

@DriftDatabase(tables: [Transactions, Wallet, Budgets], daos: [WalletDao, TransactionsDAO, BudgetsDao])
class DBConnection extends _$DBConnection {
  DBConnection() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (m) async {
        await m.createAll();
      });
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'mono.db'));
    return NativeDatabase(file);
  });
}
