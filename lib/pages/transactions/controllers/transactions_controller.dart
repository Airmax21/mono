import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/database/repositories/transactions_repository.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/enums/transaction_type_enum.dart';

class TransactionsController extends GetxController {
  final TransactionsRepository repository;

  TransactionsController(this.repository);

  final selectedWallet = Rxn<WalletData>();
  final selectedTransactionType = Rxn<TransactionType>();
  final selectedCategory = Rxn<Category>();

  final wallets = <WalletData>[].obs;
  final transactions = <Transaction>[].obs;
  final transactionsType = TransactionType;

  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController priceController;

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
      final price = _cleanNumber(priceController.text);
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

      nameController.clear();
      priceController.clear();
      Get.back();
    }
  }

  double _cleanNumber(String formattedText) {
    String cleanText = formattedText.replaceAll('.', '');

    double? parsedValue = double.tryParse(cleanText);
    if (parsedValue != null) {
      return parsedValue;
    } else {
      return 0.0;
    }
  }
}
