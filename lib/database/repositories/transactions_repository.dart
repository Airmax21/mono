import 'package:mono_app/database/api_client.dart';
import 'package:mono_app/database/models.dart';

class TransactionsRepository {
  final ApiClient _api;

  TransactionsRepository(this._api);

  Future<List<Transaction>> getTransactions() {
    return _api.getTransactions();
  }

  Stream<List<Transaction>> watchTransactions() {
    return Stream.fromFuture(_api.getTransactions());
  }

  Future<List<Transaction>> getFilteredTransactions({
    String? name,
    String? category,
  }) async {
    final list = await _api.getTransactions();
    return list.where((item) {
      final matchName = name == null || name.isEmpty || item.name.toLowerCase().contains(name.toLowerCase());
      final matchCategory = category == null || category.isEmpty || item.category.name == category;
      return matchName && matchCategory;
    }).toList();
  }

  Stream<List<Transaction>> watchFilteredTransactions({
    String? name,
    String? category,
  }) {
    return Stream.fromFuture(getFilteredTransactions(name: name, category: category));
  }

  Future<Transaction> getTransactionById({required String id}) {
    return _api.getTransactionById(id: id);
  }

  Future<void> addTransactions(TransactionsCompanion data) {
    return _api.addTransaction(data);
  }

  Future<void> updateTransactions(TransactionsCompanion data) {
    return _api.updateTransaction(data);
  }

  Future<void> deleteTransactions(String id) {
    return _api.deleteTransaction(id);
  }

  Future<TransactionStatistics?> getTransactionStatistics({String? month}) {
    return _api.getTransactionStatistics(month: month);
  }
}
