import 'package:drift/drift.dart';
import 'package:mono_app/database/entity/base_entity.dart';
import 'package:mono_app/database/entity/wallet.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/enums/transaction_type_enum.dart';
import 'package:uuid/uuid.dart';

class Transactions extends Table with BaseEntity {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  TextColumn get wallet => text().references(Wallet, #id)();
  RealColumn get price => real()();
  TextColumn get transactionType =>
      text().map(const TransactionTypeConverter())();
  TextColumn get category => text().map(const CategoryEnum())();

  @override
  Set<Column> get primaryKey => {id};
}
