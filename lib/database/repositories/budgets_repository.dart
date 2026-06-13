import 'package:mono_app/database/api_client.dart';
import 'package:mono_app/database/models.dart';

class BudgetsRepository {
  final ApiClient _api;

  BudgetsRepository(this._api);

  Future<List<Budget>> getBudgets() async {
    return _api.getBudgets();
  }

  Stream<List<Budget>> watchBudgets() {
    return Stream.fromFuture(getBudgets());
  }

  Future<List<Budget>> getFilteredBudgets({String? category}) async {
    final list = await getBudgets();
    if (category == null || category.isEmpty) return list;
    return list.where((item) => item.category.name == category).toList();
  }

  Stream<List<Budget>> watchFilteredBudgets({
    String? category,
  }) {
    return Stream.fromFuture(getFilteredBudgets(category: category));
  }

  Future<Budget> getBudgetById({required String id}) async {
    return _api.getBudgetById(id: id);
  }

  Future<void> addBudgets(BudgetsCompanion data) async {
    await _api.addBudget(data);
  }

  Future<void> updateBudgets(BudgetsCompanion data) async {
    await _api.updateBudget(data);
  }

  Future<void> deleteBudgets(String id) async {
    await _api.deleteBudget(id);
  }
}
