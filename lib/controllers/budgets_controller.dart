import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/delete_dialog.dart';
import 'package:mono_app/database/models.dart' as drift;
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/database/repositories/budgets_repository.dart';
import 'package:mono_app/enums/budget_period_enum.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/enums/transaction_type_enum.dart';

class BudgetsController extends GetxController {
  final BudgetsRepository repository;

  BudgetsController(this.repository);

  final budgets = <Budget>[].obs;
  final selectedCategory = Rxn<Category>();
  final amountController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchBudgets();
    amountController.text = '0';
  }

  void fetchBudgets() async {
    try {
      final result = await repository.getBudgets();
      final api = Get.find<ApiClient>();
      final txList = await api.getTransactions();
      
      final now = DateTime.now();
      final updatedBudgets = result.map((b) {
        final monthlySpent = txList
            .where((tx) =>
                tx.transactionType == TransactionType.expense &&
                tx.category == b.category &&
                tx.createdAt.year == now.year &&
                tx.createdAt.month == now.month)
            .fold<double>(0.0, (sum, tx) => sum + tx.price);

        return Budget(
          id: b.id,
          walletId: b.walletId,
          amount: b.amount,
          spent: monthlySpent,
          period: b.period,
          category: b.category,
          startDate: b.startDate,
          endDate: b.endDate,
          createdAt: b.createdAt,
          updatedAt: b.updatedAt,
        );
      }).toList();

      budgets.assignAll(updatedBudgets);

      final warningBudgets = <String>[];
      for (final b in updatedBudgets) {
        if (b.amount > 0 && b.spent >= b.amount * 0.95) {
          warningBudgets.add(b.category.name.capitalizeFirst!);
        }
      }
      if (warningBudgets.isNotEmpty) {
        Get.snackbar(
          'budget_warning_title'.tr,
          'budget_warning_subtitle'.trParams({'categories': warningBudgets.join(', ')}),
          backgroundColor: Colors.orange.withOpacity(0.9),
          colorText: Colors.white,
          icon: const Icon(Icons.warning, color: Colors.white),
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      debugPrint('Error fetching/calculating budgets: $e');
    }
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
        startDate: drift.Value(startDate ?? DateTime.now()),
        endDate: drift.Value(endDate));
    await repository.addBudgets(budget);
    fetchBudgets();
  }

  void updateBudgets({
    required String id,
    String? walletId,
    required double amount,
    required BudgetPeriod period,
    required Category category,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final budget = BudgetsCompanion(
        id: drift.Value(id),
        walletId: drift.Value(walletId),
        amount: drift.Value(amount),
        period: drift.Value(period),
        category: drift.Value(category),
        startDate: drift.Value(startDate ?? DateTime.now()),
        endDate: drift.Value(endDate));
    await repository.updateBudgets(budget);
    fetchBudgets();
  }

  void deleteBudget(Budget budget) {
    Get.dialog(
      DeleteDialog(
        title: 'Konfirmasi Hapus',
        content:
            'Apakah kamu yakin ingin menghapus budget untuk "${budget.category.name.capitalizeFirst}"?',
        onConfirm: () async {
          await repository.deleteBudgets(budget.id);
          fetchBudgets();
          Get.back();
        },
      ),
      barrierDismissible: false,
    );
  }
}
