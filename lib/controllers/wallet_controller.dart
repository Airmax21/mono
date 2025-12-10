import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as drift;
import 'package:mono_app/components/delete_dialog.dart';
import 'package:mono_app/components/edit_dialog.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/database/repositories/wallet_repository.dart';
import 'package:mono_app/enums/currency_type_enum.dart';
import 'package:mono_app/enums/wallet_type_enum.dart';
import 'package:mono_app/pages/wallets/layouts/form_wallet.dart';

class WalletController extends GetxController {
  final WalletRepository repository;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final selectedType = Rxn<WalletType>();
  final selectedCurrency = Rxn<CurrencyType>();

  WalletController(this.repository);

  final wallets = <WalletData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWallets();
  }

  void fetchWallets() async {
    final result = await repository.getWallets();
    wallets.assignAll(result);
  }

  void addWallet() async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text;
      final type = selectedType.value;
      final currency = selectedCurrency.value;

      if (type == null || currency == null) {
        Get.snackbar('Error', 'Pastikan semua field sudah terisi');
        return;
      }

      final wallet = WalletCompanion(
        name: drift.Value(name),
        type: drift.Value(type!),
        currency: drift.Value(currency),
      );

      nameController.clear();
      selectedType.value = null;
      selectedCurrency.value = null;
      await repository.addWallet(wallet);
      fetchWallets();
      clearFormState();
      Get.back();
    }
  }

  void deleteWallet(WalletData wallet) {
    Get.dialog(
      DeleteDialog(
          title: 'Konfirmasi Hapus',
          content: 'Apakah kamu yakin ingin menghapus wallet "${wallet.name}"?',
          onConfirm: () async {
            await repository.deleteWallet(wallet.id);
            fetchWallets();
            Get.back();
          }),
      barrierDismissible: false,
    );
  }

  void editWallet(WalletData wallet) {
    nameController.text = wallet.name;
    selectedType.value = wallet.type;
    selectedCurrency.value = wallet.currency;

    Get.dialog(
      EditDialog(
        title: 'Edit Wallet',
        content: FormWallet(formKey: formKey),
        onConfirm: () async {
          if (formKey.currentState!.validate() &&
              selectedType.value != null &&
              selectedCurrency.value != null) {
            final updated = WalletCompanion(
                id: drift.Value(wallet.id),
                name: drift.Value(nameController.text),
                type: drift.Value(selectedType.value!),
                currency: drift.Value(selectedCurrency.value!));
            await repository.updateWallet(updated);
            clearFormState();
            fetchWallets();
            Get.back();
          }
        },
      ),
    );
  }

  void clearFormState() {
    nameController.clear();
    selectedType.value = null;
    selectedCurrency.value = null;
  }
}
