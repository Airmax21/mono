import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/pages/budgets_list/layouts/body.dart';
import 'package:mono_app/pages/budgets_list/layouts/form_budgets.dart';
import 'package:mono_app/size_config.dart';

class BudgetsList extends StatelessWidget {
  static String routeName = '/detail_budgets';

  const BudgetsList({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('budget_list_title'.tr),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const Body(),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.dialog(FormBudgets()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
