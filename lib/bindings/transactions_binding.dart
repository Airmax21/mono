import 'package:get/get.dart';
import 'package:mono_app/database/api_client.dart';
import 'package:mono_app/database/repositories/transactions_repository.dart';
import 'package:mono_app/database/repositories/wallet_repository.dart';
import 'package:mono_app/controllers/transactions_controller.dart';

class TransactionsBinding extends Bindings {
  @override
  void dependencies() {
    final api = Get.find<ApiClient>();
    Get.lazyPut(() => TransactionsRepository(api));
    Get.lazyPut(() => WalletRepository(api));
    Get.lazyPut(() => TransactionsController(Get.find(), Get.find()));
  }
}
