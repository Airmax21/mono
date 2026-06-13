import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/controllers/account_controller.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountController>();

    final isDark = Get.isDarkMode;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.08), 
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Obx(() {
            final path = controller.profilePhotoPath.value;
            final hasPhoto = path.isNotEmpty && File(path).existsSync();
            
            return GestureDetector(
              onTap: controller.pickProfilePhoto,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: hasPhoto
                        ? FileImage(File(path)) as ImageProvider
                        : const AssetImage('assets/icons/Icon.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFF3757CA),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
          Obx(() => Text(
            controller.userName.value,
            style: Get.textTheme.titleMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
          const SizedBox(height: 6),
          Obx(() => Text(
            controller.userEmail.value,
            style: Get.textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.white60 : Colors.black54,
              fontSize: 14,
            ),
          )),
        ],
      ),
    );
  }
}
