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
      height: getProportionateScreenHeight(60),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(color: Get.theme.shadowColor, blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, '/dashboard', Icons.home, Icons.home_outlined),
          _buildNavItem(
              1, '/budgets', Icons.attach_money, Icons.attach_money_outlined),
          _buildNavItem(
              2, '/statistics', Icons.analytics, Icons.analytics_outlined),
          _buildNavItem(3, '/wallets', Icons.wallet, Icons.wallet_outlined),
          _buildNavItem(4, '/account', Icons.manage_accounts,
              Icons.manage_accounts_outlined),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      int idx, String route, IconData iconActive, IconData iconOutline) {
    final isActive = idx == pageIndex;
    return IconButton(
      onPressed: () => Get.offNamed(route),
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(isActive ? 8 : 4),
        decoration: BoxDecoration(
          color: isActive ? Colors.white24 : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isActive ? iconActive : iconOutline,
          color: isActive ? Colors.white : Color(0xFF969EC2),
          size: isActive ? 30 : 26,
        ),
      ),
    );
  }
}
