import 'package:drift/drift.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/database/entity/budgets.dart';

part 'budgets_dao.g.dart';

@DriftAccessor(tables: [Budgets])
class BudgetsDao extends DatabaseAccessor<DBConnection> with _$BudgetsDaoMixin {
  BudgetsDao(super.db);

  Future<List<Budget>> getAllBudgets() => select(budgets).get();

  Stream<List<Budget>> watchAllBudgets() => select(budgets).watch();

  Future<List<Budget>> getBudgetsByFilter(String? category) {
    final query = select(budgets);

    if (category != null && category.isNotEmpty) {
      query.where((tbl) => tbl.category.like('%$category%'));
    }

    return query.get();
  }

  Stream<List<Budget>> watchBudgetsByFilter({
    String? category,
  }) {
    final query = select(budgets);

    if (category != null && category.isNotEmpty) {
      query.where((tbl) => tbl.category.like('%$category%'));
    }

    return query.watch();
  }

  Future<void> insertBudget(BudgetsCompanion data) => into(budgets).insert(data);

  Future<bool> updateBudget(BudgetsCompanion data) =>
      update(budgets).replace(data);

  Future<int> deleteBudget(String id) =>
      (delete(budgets)..where((w) => w.id.equals(id))).go();
}
