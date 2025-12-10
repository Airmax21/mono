import 'package:mono_app/database/DAO/budgets_dao.dart';
import 'package:mono_app/database/db_connection.dart';

class BudgetsRepository {
  final BudgetsDao _dao;

  BudgetsRepository(this._dao);

  Future<List<Budget>> getBudgets() {
    return _dao.getAllBudgets();
  }

  Stream<List<Budget>> watchBudgets() {
    return _dao.watchAllBudgets();
  }

  Future<List<Budget>> getFilteredBudgets({String? category}) {
    return _dao.getBudgetsByFilter(category: category);
  }

  Stream<List<Budget>> watchFilteredBudgets({
    String? category,
  }) {
    return _dao.watchBudgetsByFilter(
      category: category,
    );
  }

  Future<Budget> getBudgetById({required String id}) {
    return _dao.getBudgetByID(id: id);
  }

  Future<void> addBudgets(BudgetsCompanion data) {
    return _dao.insertBudget(data);
  }

  Future<void> updateBudgets(BudgetsCompanion data) {
    return _dao.updateBudget(data);
  }

  Future<void> deleteBudgets(String id) {
    return _dao.deleteBudget(id);
  }
}
