import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as drift;
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/database/repositories/wallet_repository.dart';
import 'package:mono_app/enums/currency_type_enum.dart';
import 'package:mono_app/enums/wallet_type_enum.dart';
import 'package:mono_app/size_config.dart';

class WalletController extends GetxController {
  final WalletRepository repository;

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

  void addWallet({
    required String name,
    required WalletType type,
    required CurrencyType currency,
  }) async {
    final wallet = WalletCompanion(
      name: drift.Value(name),
      type: drift.Value(type),
      currency: drift.Value(currency),
    );
    await repository.addWallet(wallet);
    fetchWallets();
  }

  void deleteWallet(WalletData wallet) {
    Get.dialog(
      AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        backgroundColor: Get.theme.dialogBackgroundColor,
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
        contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          'Konfirmasi Hapus',
          style: Get.theme.textTheme.titleLarge,
        ),
        content: Text(
          'Apakah kamu yakin ingin menghapus wallet "${wallet.name}"?',
          style: Get.theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Batal', style: Get.theme.textTheme.labelLarge),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              await repository.deleteWallet(wallet.id);
              fetchWallets();
              Get.back();
            },
            child: Text('Hapus', style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void editWallet(WalletData wallet) {
    final formKey = GlobalKey<FormState>();

    final nameController = TextEditingController(text: wallet.name);
    selectedType.value = wallet.type;
    selectedCurrency.value = wallet.currency;

    Get.dialog(
      AlertDialog(
          scrollable: true,
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
          contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          title: const Text('Edit Wallet'),
          content: SizedBox(
            width: getProportionateScreenWidth(300),
            height: getProportionateScreenHeight(250),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      style: const TextStyle(fontSize: 14),
                      decoration:
                          const InputDecoration(labelText: 'Nama Wallet'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Harus diisi' : null,
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Obx(() => DropdownButtonFormField<WalletType>(
                          value: selectedType.value,
                          decoration:
                              const InputDecoration(labelText: 'Tipe Wallet'),
                          items: WalletType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child:
                                  Text(type.name.capitalizeFirst ?? type.name),
                            );
                          }).toList(),
                          onChanged: (val) => selectedType.value = val,
                        )),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Obx(() => DropdownButtonFormField<CurrencyType>(
                          value: selectedCurrency.value,
                          decoration:
                              const InputDecoration(labelText: 'Tipe Currency'),
                          items: CurrencyType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type.name.toUpperCase()),
                            );
                          }).toList(),
                          onChanged: (val) => selectedCurrency.value = val,
                        )),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                if (formKey.currentState!.validate() &&
                    selectedType.value != null &&
                    selectedCurrency.value != null) {
                  final updated = WalletCompanion(
                      id: drift.Value(wallet.id),
                      name: drift.Value(nameController.text),
                      type: drift.Value(selectedType.value!),
                      currency: drift.Value(selectedCurrency.value!));
                  await repository.updateWallet(updated);
                  fetchWallets();
                  Get.back();
                }
              },
              child: const Text('Simpan'),
            ),
          ]),
    );
  }
}
