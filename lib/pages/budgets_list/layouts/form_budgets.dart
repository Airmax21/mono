import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:mono_app/pages/budgets_list/controllers/budgets_controller.dart';
import 'package:mono_app/size_config.dart';
import 'package:mono_app/enums/category_enum.dart';

class FormBudgets extends StatelessWidget {
  FormBudgets({super.key});

  final controller = Get.find<BudgetsController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      title: const Text('Buat Budgets Baru'),
      content: SizedBox(
        width: getProportionateScreenWidth(300),
        height: getProportionateScreenHeight(250),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => DropdownButtonFormField<Category>(
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(labelText: 'Category'),
                      value: controller.selectedCategory.value,
                      items: Category.values.map((category) {
                        return DropdownMenuItem(
                            value: category,
                            child: Text(category.name.capitalizeFirst ??
                                category.name));
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
                    controller: controller.amounController,
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
                  
                ],
              ),
            )),
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
          onPressed: () {
            // if (_formKey.currentState!.validate() &&
            //     controller.selectedType.value != null &&
            //     controller.selectedCurrency.value != null) {
            //   controller.addWallet(
            //       name: _nameController.text,
            //       type: controller.selectedType.value!,
            //       currency: controller.selectedCurrency.value!);

            //   _nameController.clear();
            //   controller.selectedType.value = null;
            //   Get.back();
            // }
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
