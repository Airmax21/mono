import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/enums/transaction_type_enum.dart';
import 'package:mono_app/controllers/transactions_controller.dart';
import 'package:mono_app/controllers/wallet_controller.dart';
import 'package:mono_app/size_config.dart';

class TransactionsForm extends GetView<TransactionsController> {
  final String? id;

  TransactionsForm({super.key, this.id});

  final walletController = Get.find<WalletController>();

  // Fungsi yang membangun konten Form utama
  Widget _buildFormContent() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.nameController,
                  style: const TextStyle(fontSize: 14),
                  decoration:
                      const InputDecoration(labelText: 'Nama Transaksi'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Wajib diisi' : null,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Obx(
                  () => DropdownButtonFormField<TransactionType>(
                    style: const TextStyle(fontSize: 14),
                    decoration:
                        const InputDecoration(labelText: 'Type Transaksi'),
                    value: controller.selectedTransactionType.value,
                    items: TransactionType.values.map((transactionsType) {
                      return DropdownMenuItem(
                          value: transactionsType,
                          child: Text(transactionsType.name.capitalizeFirst ??
                              transactionsType.name));
                    }).toList(),
                    onChanged: (value) =>
                        controller.selectedTransactionType.value = value,
                    validator: (value) =>
                        value == null ? 'Pilih type wallet' : null,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Obx(
                  () => DropdownButtonFormField<WalletData>(
                    style: const TextStyle(fontSize: 14),
                    decoration:
                        const InputDecoration(labelText: 'Jenis Wallet'),
                    value: controller.selectedWallet.value,
                    items: walletController.wallets.map((wallet) {
                      return DropdownMenuItem(
                          value: wallet,
                          child:
                              Text(wallet.name.capitalizeFirst ?? wallet.name));
                    }).toList(),
                    onChanged: (value) =>
                        controller.selectedWallet.value = value,
                    validator: (value) =>
                        value == null ? 'Pilih jenis wallet' : null,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Obx(
                  () => DropdownButtonFormField<Category>(
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(labelText: 'Category'),
                    value: controller.selectedCategory.value,
                    items: Category.values.map((category) {
                      return DropdownMenuItem(
                          value: category,
                          child: Text(
                              category.name.capitalizeFirst ?? category.name));
                    }).toList(),
                    onChanged: (value) =>
                        controller.selectedCategory.value = value,
                    validator: (value) =>
                        value == null ? 'Pilih category' : null,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                TextFormField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: controller.priceController,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: 'Jumlah',
                    prefixText: 'Rp. ',
                  ),
                  inputFormatters: [
                    CurrencyInputFormatter(
                        thousandSeparator: ThousandSeparator.Period,
                        mantissaLength: 0),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Wajib diisi';
                    final parsed = double.tryParse(value.replaceAll('.', ''));
                    if (parsed == null) return 'Harus berupa angka';
                    return null;
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      if (id != null) {
                        controller.editTransaction(id!);
                      } else {
                        controller.addTransaction();
                      }
                    },
                    child: Text(
                        id != null ? 'Update Transaksi' : 'Simpan Transaksi'),
                  ),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (id != null) {
        controller.initializeForm(id!);
    }
    return SafeArea(
      child: Column(children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        Expanded(
            child: GetBuilder<TransactionsController>(
          init: controller,
          builder: (c) {
            if (id != null && c.isFormLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildFormContent();
          },
        )),
      ]),
    );
  }
}
