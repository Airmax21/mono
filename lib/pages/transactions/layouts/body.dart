import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mono_app/pages/transactions/layouts/transactions_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final String? transactionId = Get.arguments as String?;
    return SafeArea(
        child: Column(
      children: [Expanded(child: TransactionsForm(id: transactionId))],
    ));
  }
}
