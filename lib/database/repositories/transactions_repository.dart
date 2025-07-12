import 'package:mono_app/database/DAO/transactions_dao.dart';
import 'package:mono_app/database/db_connection.dart';

class TransactionsRepository {
  final TransactionsDAO _dao;

  TransactionsRepository(this._dao);

  Future<List<Transaction>> getTransactions() {
    return _dao.getAllTransactions();
  }

  Stream<List<Transaction>> watchTransactions() {
    return _dao.watchAllTransactions();
  }

  Future<List<Transaction>> getFilteredTransactions({
    String? name,
    String? category,
  }) {
    return _dao.getTransactionsByFilter(
      name: name,
      category: category,
    );
  }

  Stream<List<Transaction>> watchFilteredTransactions({
    String? name,
    String? category,
  }) {
    return _dao.watchTransactionsByFilter(
      name: name,
      category: category,
    );
  }

  Future<void> addTransactions(TransactionsCompanion data) {
    return _dao.insertTransactions(data);
  }

  Future<void> updateTransactions(TransactionsCompanion data) {
    return _dao.updateTransactions(data);
  }

  Future<void> deleteTransactions(String id) {
    return _dao.deleteTransactions(id);
  }
}
