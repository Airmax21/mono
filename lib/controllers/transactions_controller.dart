import 'package:mono_app/database/models.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/delete_dialog.dart';
import 'package:mono_app/components/warning_dialog.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/database/repositories/transactions_repository.dart';
import 'package:mono_app/database/repositories/wallet_repository.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/enums/transaction_type_enum.dart';
import 'package:mono_app/utils/parser.dart';

class TransactionsController extends GetxController {
  final TransactionsRepository repository;
  final WalletRepository walletRepository;

  TransactionsController(this.repository, this.walletRepository);

  final selectedWallet = Rxn<WalletData>();
  final selectedTransactionType = Rxn<TransactionType>();
  final selectedCategory = Rxn<Category>();
  final filterDate = Rxn<DateTime>();

  final wallets = <WalletData>[].obs;
  final transactions = <Transaction>[].obs;

  List<Transaction> get filteredTransactions {
    if (filterDate.value == null) {
      return transactions;
    }
    final target = filterDate.value!;
    return transactions.where((tx) {
      return tx.createdAt.year == target.year &&
          tx.createdAt.month == target.month &&
          tx.createdAt.day == target.day;
    }).toList();
  }
  final transactionsType = TransactionType;

  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController priceController;
  final isFormLoading = false.obs;
  final isDataLoaded = false.obs;

  final totalBalance = 0.0.obs;
  final dashboardStatistics = Rxn<TransactionStatistics>();
  final isLoadingDashboard = false.obs;

  @override
  void onInit() {
    super.onInit();
    filterDate.value = null;
    fetchTransactions();

    nameController = TextEditingController();
    priceController = TextEditingController();
    priceController.text = '0';
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    priceController.dispose();
  }

  void fetchTransactions() async {
    final result = await repository.getTransactions();
    transactions.assignAll(result);
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    isLoadingDashboard.value = true;
    try {
      final walletList = await walletRepository.getWallets();
      wallets.assignAll(walletList);
      double balanceSum = 0.0;
      for (final w in walletList) {
        balanceSum += w.balance;
      }
      totalBalance.value = balanceSum;

      final now = DateTime.now();
      final monthStr = '${now.year}-${now.month.toString().padLeft(2, '0')}';
      final stats = await repository.getTransactionStatistics(month: monthStr);
      if (stats != null) {
        dashboardStatistics.value = stats;
      }
    } catch (e) {
      debugPrint('Error fetching dashboard data: $e');
    } finally {
      isLoadingDashboard.value = false;
    }
  }

  void addTransaction() async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text;
      final price = Parser.cleanNumber(priceController.text);
      final type = selectedTransactionType.value;
      final wallet = selectedWallet.value;
      final category = selectedCategory.value;

      if (type == null || wallet == null || category == null) {
        Get.snackbar('Error', 'Pastikan semua field sudah terisi');
        return;
      }

      Future<void> saveOperation() async {
        final transaction = TransactionsCompanion(
          name: drift.Value(name),
          transactionType: drift.Value(type),
          wallet: drift.Value(wallet.id),
          price: drift.Value(price),
          category: drift.Value(category),
        );
        await repository.addTransactions(transaction);
        fetchTransactions();
        clearFormState();
        Get.back();
      }

      if (type == TransactionType.expense) {
        final exceed = await _willExceedBudget(category, price);
        if (exceed) {
          Get.dialog(
            WarningDialog(
              title: 'Batas Anggaran Terlewati',
              content: 'Transaksi ini akan membuat pengeluaran untuk kategori "${category.name.capitalizeFirst}" melebihi anggaran bulanan Anda. Apakah Anda yakin ingin melanjutkan?',
              onConfirm: saveOperation,
            ),
            barrierDismissible: false,
          );
          return;
        }
      }

      await saveOperation();
    }
  }

  void deleteTransaction(Transaction transaction) {
    Get.dialog(
      DeleteDialog(
        title: 'Konfirmasi Hapus',
        content:
            'Apakah kamu yakin ingin menghapus transaksi "${transaction.name}"?',
        onConfirm: () async {
          await repository.deleteTransactions(transaction.id);
          fetchTransactions();
          clearFormState();
          Get.back();
        },
      ),
      barrierDismissible: false,
    );
  }

  void editTransaction(String id) async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text;
      final price = Parser.cleanNumber(priceController.text);
      final type = selectedTransactionType.value;
      final wallet = selectedWallet.value;
      final category = selectedCategory.value;

      if (type == null || wallet == null || category == null) {
        Get.snackbar('Error', 'Pastikan semua field sudah terisi');
        return;
      }

      Future<void> saveOperation() async {
        final transaction = TransactionsCompanion(
          id: drift.Value(id),
          name: drift.Value(name),
          transactionType: drift.Value(type),
          wallet: drift.Value(wallet.id),
          price: drift.Value(price),
          category: drift.Value(category),
        );
        await repository.updateTransactions(transaction);
        fetchTransactions();
        clearFormState();
        Get.back();
      }

      if (type == TransactionType.expense) {
        final exceed = await _willExceedBudget(category, price, excludeTxId: id);
        if (exceed) {
          Get.dialog(
            WarningDialog(
              title: 'Batas Anggaran Terlewati',
              content: 'Transaksi ini akan membuat pengeluaran untuk kategori "${category.name.capitalizeFirst}" melebihi anggaran bulanan Anda. Apakah Anda yakin ingin melanjutkan?',
              onConfirm: saveOperation,
            ),
            barrierDismissible: false,
          );
          return;
        }
      }

      await saveOperation();
    }
  }

  Future<Transaction> findTransaction(String id) async {
    final transaction = await repository.getTransactionById(id: id);
    nameController.text = transaction.name;
    priceController.text = transaction.price.toString();
    selectedCategory.value = transaction.category;
    selectedTransactionType.value = transaction.transactionType;

    final wallet = await walletRepository.getWalletByID(id: transaction.wallet);
    selectedWallet.value = wallet;

    return transaction;
  }

  Future<void> initializeForm(String id) async {
    if (isDataLoaded.isTrue) return;
    isFormLoading.value = true;
    isDataLoaded.value = false;
    update();
    await findTransaction(id);
    isFormLoading.value = false;
    isDataLoaded.value = true;
    update();
  }

  void clearFormState() {
    nameController.clear();
    priceController.clear();
    selectedCategory.value = null;
    selectedTransactionType.value = null;
    selectedWallet.value = null;
  }

  Future<bool> _willExceedBudget(Category category, double newAmount, {String? excludeTxId}) async {
    try {
      final api = Get.find<ApiClient>();
      final budgetsList = await api.getBudgets();
      
      // Find budget for this category
      final budget = budgetsList.firstWhereOrNull((b) => b.category == category);
      if (budget == null) return false;
      
      final now = DateTime.now();
      var currentSpent = transactions
          .where((tx) =>
              tx.transactionType == TransactionType.expense &&
              tx.category == category &&
              tx.createdAt.year == now.year &&
              tx.createdAt.month == now.month &&
              tx.id != excludeTxId)
          .fold<double>(0.0, (sum, tx) => sum + tx.price);
          
      return (currentSpent + newAmount) > budget.amount;
    } catch (e) {
      debugPrint('Error checking budget exceedance: $e');
      return false;
    }
  }
}
