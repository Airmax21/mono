import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/controllers/wallet_controller.dart';
import 'package:mono_app/pages/wallets/layouts/form_wallet.dart';

class CreateDialog extends StatelessWidget {
  CreateDialog({super.key});

  final controller = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    controller.clearFormState();
    return AlertDialog(
      scrollable: true,
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      title: Text('create_new_wallet'.tr),
      content: FormWallet(formKey: controller.formKey),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('cancel'.tr),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            controller.addWallet();
          },
          child: Text('save'.tr),
        ),
      ],
    );
  }
}
