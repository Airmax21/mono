import 'package:flutter/material.dart';
import 'package:mono_app/components/bottom_navigation_bar.dart';
import 'package:mono_app/pages/statistics/layouts/body.dart';
import 'package:mono_app/size_config.dart';

class Statistics extends StatelessWidget {
  static String routeName = '/statistics';

  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
      extendBody: true,
      bottomNavigationBar:
          SafeArea(child: CustomBottomNavigationBar(pageIndex: 2))
    );
  }
}
