import 'package:flutter/material.dart';
import 'package:mono_app/pages/splash/layouts/body.dart';
import 'package:mono_app/size_config.dart';

class SplashScreen extends StatelessWidget{
  static String routeName = '/splash';

  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}