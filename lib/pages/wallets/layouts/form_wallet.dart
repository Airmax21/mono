import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/enums/currency_type_enum.dart';
import 'package:mono_app/enums/wallet_type_enum.dart';
import 'package:mono_app/pages/wallets/controllers/wallet_controller.dart';
import 'package:mono_app/size_config.dart';

class FormWallet extends StatelessWidget {
  FormWallet({super.key});

  final controller = Get.find<WalletController>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      title: const Text('Buat Wallet Baru'),
      content: SizedBox(
          width: getProportionateScreenWidth(300),
          height: getProportionateScreenHeight(250),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(fontSize: 14),
                      decoration:
                          const InputDecoration(labelText: 'Nama Wallet'),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Harus diisi' : null,
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Obx(() => DropdownButtonFormField<WalletType>(
                          style: const TextStyle(fontSize: 14),
                          decoration:
                              const InputDecoration(labelText: 'Tipe Wallet'),
                          value: controller.selectedType.value,
                          items: WalletType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child:
                                  Text(type.name.capitalizeFirst ?? type.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.selectedType.value = value;
                          },
                          validator: (value) =>
                              value == null ? 'Pilih tipe wallet' : null,
                        )),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Obx(() => DropdownButtonFormField<CurrencyType>(
                          style: const TextStyle(fontSize: 14),
                          decoration:
                              const InputDecoration(labelText: 'Tipe Currency'),
                          value: controller.selectedCurrency.value,
                          items: CurrencyType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type.name.toUpperCase()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.selectedCurrency.value = value;
                          },
                          validator: (value) =>
                              value == null ? 'Pilih tipe wallet' : null,
                        )),
                  ],
                ),
              ))),
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
          onPressed: () {
            if (_formKey.currentState!.validate() &&
                controller.selectedType.value != null &&
                controller.selectedCurrency.value != null) {
              controller.addWallet(
                  name: _nameController.text,
                  type: controller.selectedType.value!,
                  currency: controller.selectedCurrency.value!);

              _nameController.clear();
              controller.selectedType.value = null;
              Get.back();
            }
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
