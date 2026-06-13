import 'package:flutter/material.dart';
import 'package:mono_app/pages/login/layouts/body.dart';
import 'package:mono_app/size_config.dart';

class LoginPage extends StatelessWidget {
  static String routeName = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
