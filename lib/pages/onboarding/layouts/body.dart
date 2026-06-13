import 'package:flutter/material.dart';
import 'package:mono_app/pages/onboarding/layouts/container.dart';
import 'package:mono_app/pages/onboarding/layouts/image.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        const ImageOnboarding(),
        Align(
          alignment: Alignment.bottomCenter,
          child: ContainerOnboarding()
        )
      ],
    );
  }
}
