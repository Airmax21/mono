import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mono_app/size_config.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage('MoNo');
    final userName = box.read<String>('user_name') ?? 'Customer';
    final photoPath = box.read<String>('user_profile_photo') ?? '';
    final hasPhoto = photoPath.isNotEmpty && File(photoPath).existsSync();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: hasPhoto
                ? FileImage(File(photoPath)) as ImageProvider
                : const AssetImage('assets/icons/Icon.png'),
          ),
          SizedBox(width: getProportionateScreenWidth(15)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("good_morning".tr, style: Get.textTheme.bodySmall),
              Text(userName, style: Get.textTheme.titleSmall),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, size: 24),
            tooltip: 'chat_tooltip'.tr,
            onPressed: () => Get.toNamed('/chat'),
          ),
        ],
      ),
    );
  }
}
