import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/pages/splash/layouts/animations.dart';

class TextSplash extends StatelessWidget {
  final AnimationControllerX animationControllerX =
      Get.put(AnimationControllerX());

  TextSplash({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: animationControllerX.textController,
      builder: (context, child) {
        return SlideTransition(
          position: animationControllerX.textAnimation,
          child: AnimatedOpacity(
            opacity: animationControllerX.textOpacity.value,
            duration: const Duration(seconds: 1),
            child: Text(
              'MoNo',
              style: Get.textTheme.displaySmall,
            ),
          ),
        );
      },
    );
  }
}
