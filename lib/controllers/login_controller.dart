import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/database/api_client.dart';

class LoginController extends GetxController {
  final ApiClient api = Get.find<ApiClient>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLogin = true.obs;
  final isLoading = false.obs;
  final obscurePassword = true.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void toggleMode() {
    isLogin.toggle();
    // Clear validation and inputs when switching modes
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  void toggleObscure() {
    obscurePassword.toggle();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    try {
      if (isLogin.value) {
        // Login Flow
        await api.login(
          emailController.text.trim(),
          passwordController.text,
        );
        Get.offAllNamed('/dashboard');
      } else {
        // Registration Flow
        await api.register(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text,
        );
        
        // Auto-login after successful registration
        await api.login(
          emailController.text.trim(),
          passwordController.text,
        );
        Get.offAllNamed('/dashboard');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
