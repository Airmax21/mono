import 'package:flutter/material.dart';
import 'package:mono_app/pages/onboarding/layouts/body.dart';
import 'package:mono_app/size_config.dart';

class Onboarding extends StatelessWidget{
  static String routeName = '/onboarding';
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}