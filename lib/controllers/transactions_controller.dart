import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/delete_dialog.dart';
import 'package:mono_app/components/edit_dialog.dart';
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

  final wallets = <WalletData>[].obs;
  final transactions = <Transaction>[].obs;
  final transactionsType = TransactionType;

  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController priceController;
  final isFormLoading = false.obs;
  final isDataLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
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
  }

  void deleteTransaction(Transaction transaction) {
    Get.dialog(
      DeleteDialog(
        title: 'Konfirmasi Hapus',
        content:
            'Apakah kamu yakin ingin menghapus wallet "${transaction.name}"?',
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
}
