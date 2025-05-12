import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AnimationControllerX extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController textController;
  late Animation<Offset> textAnimation;
  late Animation<double> textOpacity;
  final GetStorage box = GetStorage();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          bool onboardingRead = false;
          onboardingRead = box.read('onboarding_read') ?? false;
          onboardingRead
              ? Get.offNamed('/dashboard')
              : Get.offNamed('/onboarding');
        }
      });

    textController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    textAnimation =
        Tween<Offset>(begin: const Offset(-1, 0.0), end: Offset.zero).animate(
            CurvedAnimation(parent: textController, curve: Curves.easeInOut));

    textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: textController, curve: Curves.easeInOut));

    animationController.forward();
    textController.forward();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    animationController.dispose();
    textController.dispose();
  }
}
