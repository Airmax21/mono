import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WarningDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const WarningDialog(
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
      title: Row(
        children: [
          const Icon(Icons.warning, color: Colors.orange, size: 28),
          const SizedBox(width: 8),
          Text(
            title,
            style: Get.theme.textTheme.titleLarge,
          ),
        ],
      ),
      content: Text(
        content,
        style: Get.theme.textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Batal', style: Get.theme.textTheme.labelLarge),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            Get.back(); // close dialog
            onConfirm();
          },
          child: const Text(
            'Lanjutkan',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
