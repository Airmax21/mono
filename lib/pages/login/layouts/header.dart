import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/controllers/login_controller.dart';
import 'package:mono_app/size_config.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/icons/Icon.png',
            width: getProportionateScreenWidth(70),
          ),
          const SizedBox(height: 16),
          Text(
            'MoNo',
            style: Get.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() => Text(
            controller.isLogin.value 
              ? 'login_welcome'.tr 
              : 'register_welcome'.tr,
            style: Get.textTheme.bodyMedium?.copyWith(
              color: Get.isDarkMode ? Colors.white60 : Colors.black54,
            ),
          )),
        ],
      ),
    );
  }
}
