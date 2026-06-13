import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/controllers/login_controller.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    final isDark = Get.isDarkMode;

    final cardColor = isDark ? const Color(0xFF1C1F30).withValues(alpha: 0.9) : Colors.white;
    final cardBorderColor = isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.08);
    final shadowColor = isDark ? Colors.black.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.05);

    final inputFillColor = isDark ? Colors.white.withValues(alpha: 0.04) : Colors.black.withValues(alpha: 0.03);
    final inputTextColor = isDark ? Colors.white : Colors.black87;
    final inputLabelColor = isDark ? Colors.white70 : Colors.black54;
    final inputFloatingLabelColor = isDark ? Colors.white : const Color(0xFF3757CA);
    final inputBorderColor = isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.08);
    final inputPrefixIconColor = isDark ? Colors.white54 : Colors.black54;
    final inputSuffixIconColor = isDark ? Colors.white54 : Colors.black54;

    final inputDecorationTheme = InputDecoration(
      filled: true,
      fillColor: inputFillColor,
      labelStyle: TextStyle(color: inputLabelColor, fontSize: 14),
      floatingLabelStyle: TextStyle(color: inputFloatingLabelColor, fontWeight: FontWeight.bold),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: inputBorderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3757CA), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cardBorderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Name Input (Only visible during Register)
            Obx(() => Visibility(
              visible: !controller.isLogin.value,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.nameController,
                    style: TextStyle(color: inputTextColor, fontSize: 15),
                    decoration: inputDecorationTheme.copyWith(
                      labelText: 'name_label'.tr,
                      prefixIcon: Icon(Icons.person_outline, color: inputPrefixIconColor),
                    ),
                    validator: (value) {
                      if (!controller.isLogin.value && (value == null || value.trim().isEmpty)) {
                        return 'name_error'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )),

            // Email Input
            TextFormField(
              controller: controller.emailController,
              style: TextStyle(color: inputTextColor, fontSize: 15),
              keyboardType: TextInputType.emailAddress,
              decoration: inputDecorationTheme.copyWith(
                labelText: 'email_label'.tr,
                prefixIcon: Icon(Icons.mail_outline, color: inputPrefixIconColor),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'email_error_empty'.tr;
                }
                if (!GetUtils.isEmail(value.trim())) {
                  return 'email_error_invalid'.tr;
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Password Input
            Obx(() => TextFormField(
              controller: controller.passwordController,
              style: TextStyle(color: inputTextColor, fontSize: 15),
              obscureText: controller.obscurePassword.value,
              decoration: inputDecorationTheme.copyWith(
                labelText: 'password_label'.tr,
                prefixIcon: Icon(Icons.lock_outline, color: inputPrefixIconColor),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscurePassword.value 
                      ? Icons.visibility_off_outlined 
                      : Icons.visibility_outlined,
                    color: inputSuffixIconColor,
                    size: 20,
                  ),
                  onPressed: controller.toggleObscure,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'password_error_empty'.tr;
                }
                if (value.length < 6) {
                  return 'password_error_length'.tr;
                }
                return null;
              },
            )),

            const SizedBox(height: 32),

            // Submit Button
            Obx(() => Container(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3757CA).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3757CA),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: controller.isLoading.value
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      controller.isLogin.value ? 'login_btn'.tr : 'register_btn'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
