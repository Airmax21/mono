import 'package:flutter/widgets.dart';
import 'package:mono_app/pages/transactions/layouts/transactions_form.dart';
import 'package:mono_app/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        TransactionsForm()
      ],
    ));
  }
}
