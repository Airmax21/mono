import 'package:flutter/material.dart';

class ImageOnboarding extends StatelessWidget {
  const ImageOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Positioned.fill(
        child: Image.asset(
      'assets/img/onboarding.png',
      fit: BoxFit.contain,
      alignment: Alignment.topCenter,
    ));
  }
}
