import 'package:flutter/material.dart';
import 'package:mono_app/components/bottom_navigation_bar.dart';
import 'package:mono_app/pages/dashboard/layouts/body.dart';
import 'package:mono_app/size_config.dart';

class Dashboard extends StatelessWidget{
  static String routeName = '/dashboard';

  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 0),
    );
  }
}