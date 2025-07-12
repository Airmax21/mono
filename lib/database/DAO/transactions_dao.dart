import 'package:drift/drift.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/database/entity/transactions.dart';

part 'transactions_dao.g.dart';

@DriftAccessor(tables: [Transactions])
class TransactionsDAO extends DatabaseAccessor<DBConnection> with _$TransactionsDAOMixin {
  TransactionsDAO(super.db);

  Future<List<Transaction>> getAllTransactions() => select(transactions).get();

  Stream<List<Transaction>> watchAllTransactions() => select(transactions).watch();

  Future<List<Transaction>> getTransactionsByFilter({
    String? name,
    String? category,
  }) {
    final query = select(transactions);

    if (name != null && name.isNotEmpty) {
      query.where((tbl) => tbl.name.like('%$name%'));
    }

    if (category != null && category.isNotEmpty) {
      query.where((tbl) => tbl.category.equals(category));
    }

    return query.get();
  }

  Stream<List<Transaction>> watchTransactionsByFilter({
    String? name,
    String? category,
  }) {
    final query = select(transactions);

    if (name != null && name.isNotEmpty) {
      query.where((tbl) => tbl.name.like('%$name%'));
    }

    if (category != null && category.isNotEmpty) {
      query.where((tbl) => tbl.category.equals(category));
    }

    return query.watch();
  }

  Future<void> insertTransactions(TransactionsCompanion data) => into(transactions).insert(data);

  Future<bool> updateTransactions(TransactionsCompanion data) =>
      update(transactions).replace(data);

  Future<int> deleteTransactions(String id) =>
      (delete(transactions)..where((w) => w.id.equals(id))).go();
}
