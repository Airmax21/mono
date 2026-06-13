import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/enums/currency_type_enum.dart';
import 'package:mono_app/enums/wallet_type_enum.dart';
import 'package:mono_app/controllers/wallet_controller.dart';
import 'package:mono_app/size_config.dart';

class FormWallet extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  FormWallet({super.key, required this.formKey});

  final controller = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(300),
      height: getProportionateScreenHeight(250),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller.nameController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(labelText: 'wallet_name'.tr),
                validator: (value) =>
                    value == null || value.isEmpty ? 'field_required'.tr : null,
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              Obx(() => DropdownButtonFormField<WalletType>(
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(labelText: 'wallet_type'.tr),
                    initialValue: controller.selectedType.value,
                    items: WalletType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.name.capitalizeFirst ?? type.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedType.value = value;
                    },
                    validator: (value) =>
                        value == null ? 'select_wallet_type'.tr : null,
                  )),
              SizedBox(height: getProportionateScreenHeight(30)),
              Obx(() => DropdownButtonFormField<CurrencyType>(
                    style: const TextStyle(fontSize: 14),
                    decoration:
                        InputDecoration(labelText: 'currency_type'.tr),
                    initialValue: controller.selectedCurrency.value,
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
                        value == null ? 'select_currency_type'.tr : null,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
