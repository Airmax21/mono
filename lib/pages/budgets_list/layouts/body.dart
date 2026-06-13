import 'package:flutter/material.dart';
import 'package:mono_app/pages/budgets_list/layouts/budgets_list.dart';
import 'package:mono_app/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            const BudgetsList()
          ],
        ),
      ),
    );
  }
}
