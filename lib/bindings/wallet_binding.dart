import 'package:get/get.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/database/repositories/wallet_repository.dart';
import 'package:mono_app/controllers/wallet_controller.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    final db = Get.find<DBConnection>();
    Get.lazyPut(() => WalletRepository(db.walletDao));
    Get.lazyPut(() => WalletController(Get.find()));
  }
}
