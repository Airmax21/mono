import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/size_config.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int pageIndex;

  const CustomBottomNavigationBar({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: getProportionateScreenHeight(55),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () => Get.offNamed('/dashboard'),
              icon: pageIndex == 0
                  ? Icon(Icons.home, color: Colors.white70, size: 30)
                  : Icon(Icons.home_outlined, color: Colors.white70, size: 30)),
          IconButton(
              onPressed: () => Get.offNamed('/budgets'),
              icon: pageIndex == 1
                  ? Icon(Icons.account_balance_wallet,
                      color: Colors.white70, size: 30)
                  : Icon(Icons.account_balance_wallet_outlined,
                      color: Colors.white70, size: 30)),
          IconButton(
              onPressed: () => Get.offNamed('/dashboard'),
              icon: pageIndex == 2
                  ? Icon(Icons.analytics, color: Colors.white70, size: 30)
                  : Icon(Icons.analytics_outlined,
                      color: Colors.white70, size: 30)),
          IconButton(
              onPressed: () => Get.offNamed('/dashboard'),
              icon: pageIndex == 3
                  ? Icon(Icons.manage_accounts, color: Colors.white70, size: 30)
                  : Icon(Icons.manage_accounts_outlined,
                      color: Colors.white70, size: 30)),
        ],
      ),
    );
  }
}
