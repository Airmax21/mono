import 'package:flutter/material.dart';
import 'package:mono_app/pages/budgets/layouts/monthly_budgets.dart';
import 'package:mono_app/pages/budgets/layouts/summary_spending.dart';
import 'package:mono_app/pages/budgets/layouts/transactions.dart';
import 'package:mono_app/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(10),),
            const MonthlyBudgets(),
            SizedBox(height: getProportionateScreenHeight(10),),
            const SummarySpending(),
            SizedBox(height: getProportionateScreenHeight(10),),
            const Transactions()
          ],
        ),
      ),
    );
  }
}
