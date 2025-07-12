import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/bottom_navigation_bar.dart';
import 'package:mono_app/pages/wallets/layouts/body.dart';
import 'package:mono_app/pages/wallets/layouts/form_wallet.dart';
import 'package:mono_app/size_config.dart';

class Wallets extends StatelessWidget {
  static String routeName = '/wallets';

  const Wallets({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: const Body(),
      extendBody: true,
      bottomNavigationBar:
          SafeArea(child: CustomBottomNavigationBar(pageIndex: 3)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.dialog(FormWallet()),
        child: Icon(Icons.add),
      ),
    );
  }
}
