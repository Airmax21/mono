import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mono_app/pages/transactions/layouts/body.dart';
import 'package:mono_app/size_config.dart';

class Transactions extends StatelessWidget {
  static String routeName = '/transactions';

  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('form_transactions_title'.tr),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const Body(),
    );
  }
}
