import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/bottom_navigation_bar.dart';
import 'package:mono_app/pages/budgets/layouts/body.dart';
import 'package:mono_app/size_config.dart';

class Budgets extends StatelessWidget {
  static String routeName = '/budgets';

  const Budgets({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: const Body(),
      extendBody: true,
      bottomNavigationBar:
          SafeArea(child: CustomBottomNavigationBar(pageIndex: 1)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/transactions'),
        child: Icon(Icons.add),
      ),
    );
  }
}
