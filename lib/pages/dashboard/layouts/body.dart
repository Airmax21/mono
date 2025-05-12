import 'package:flutter/material.dart';
import 'package:mono_app/pages/dashboard/layouts/greeting.dart';
import 'package:mono_app/pages/dashboard/layouts/summary.dart';
import 'package:mono_app/pages/dashboard/layouts/transactions.dart';
import 'package:mono_app/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
        child: SafeArea(
            child: Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(30),),
        Greeting(), 
        Summary(),
        SizedBox(height: getProportionateScreenHeight(40)), 
        Transactions()],
    )));
  }
}
