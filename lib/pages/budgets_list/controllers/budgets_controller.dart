import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as drift;
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/database/repositories/budgets_repository.dart';
import 'package:mono_app/enums/budget_period_enum.dart';
import 'package:mono_app/enums/category_enum.dart';

class BudgetsController extends GetxController {
  final BudgetsRepository repository;

  BudgetsController(this.repository);

  final budgets = <Budget>[].obs;
  final selectedCategory = Rxn<Category>();
  late TextEditingController amounController;

  

  @override
  void onInit() {
    super.onInit();
    fetchBudgets();
    amounController = TextEditingController();
    amounController.text = '0';
  }

  void fetchBudgets() async {
    final result = await repository.getBudgets();
    budgets.assignAll(result);
  }

  void addBudgets({
    String? walletId,
    required double amount,
    required BudgetPeriod period,
    required Category category,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final budget = BudgetsCompanion(
        walletId: drift.Value(walletId),
        amount: drift.Value(amount),
        period: drift.Value(period),
        category: drift.Value(category),
        startDate: drift.Value(startDate!),
        endDate: drift.Value(endDate));
    await repository.addBudgets(budget);
    fetchBudgets();
  }
}
