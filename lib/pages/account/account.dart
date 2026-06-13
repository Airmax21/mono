import 'package:flutter/material.dart';
import 'package:mono_app/components/bottom_navigation_bar.dart';
import 'package:mono_app/pages/account/layouts/body.dart';
import 'package:mono_app/size_config.dart';

class AccountPage extends StatelessWidget {
  static String routeName = '/account';

  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Akun'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: const Body(),
      extendBody: true,
      bottomNavigationBar: const SafeArea(
        child: CustomBottomNavigationBar(pageIndex: 4),
      ),
    );
  }
}
