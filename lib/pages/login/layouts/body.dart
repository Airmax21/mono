import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/controllers/login_controller.dart';
import 'package:mono_app/pages/login/layouts/form_login.dart';
import 'package:mono_app/pages/login/layouts/header.dart';
import 'package:mono_app/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: getProportionateScreenHeight(40)),
            
            // Header Section
            const LoginHeader(),

            SizedBox(height: getProportionateScreenHeight(40)),

            // Form Section
            const FormLogin(),

            const SizedBox(height: 24),

            // Toggle Login/Register Mode Option
            Center(
              child: GestureDetector(
                onTap: controller.toggleMode,
                child: Obx(() => Text.rich(
                  TextSpan(
                    text: controller.isLogin.value 
                      ? 'no_account'.tr 
                      : 'have_account'.tr,
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: Get.isDarkMode ? Colors.white60 : Colors.black54,
                    ),
                    children: [
                      TextSpan(
                        text: controller.isLogin.value 
                          ? ' register_now'.tr 
                          : ' login_now'.tr,
                        style: const TextStyle(
                          color: Color(0xFF3757CA),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),

            SizedBox(height: getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );
  }
}
