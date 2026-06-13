import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback onConfirm;

  const EditDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      backgroundColor: Get.theme.colorScheme.surface,
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(
        title,
        style: Get.theme.textTheme.titleLarge,
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Batal', style: Get.theme.textTheme.labelLarge),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onConfirm,
          child: const Text(
            'Simpan',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
