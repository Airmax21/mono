import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mono_app/components/wallet_item.dart';
import 'package:mono_app/pages/wallets/controllers/wallet_controller.dart';
import 'package:mono_app/size_config.dart';

class WalletList extends StatelessWidget {
  const WalletList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletController>();
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wallets',
            style: Get.textTheme.titleMedium,
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Obx(() {
            final wallets = controller.wallets;

            if (wallets.isEmpty) {
              return const Center(child: Text('Belum ada wallet'));
            }

            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: wallets.length,
                itemBuilder: (context, index) {
                  final wallet = wallets[index];
                  return WalletItem(
                    index: index,
                    wallet: wallet,
                    onEdit: () {
                      controller.editWallet(wallet);
                    },
                    onDelete: () {
                      controller.deleteWallet(wallet);
                    },
                  );
                });
          })
        ],
      ),
    );
  }
}
