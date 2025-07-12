import 'package:flutter/widgets.dart';
import 'package:mono_app/pages/wallets/layouts/wallet_list.dart';
import 'package:mono_app/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            const WalletList()
          ],
        ),
      ),
    );
  }
}
