import 'package:get/get.dart';
import 'package:mono_app/database/api_client.dart';
import 'package:mono_app/database/repositories/wallet_repository.dart';
import 'package:mono_app/controllers/wallet_controller.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    final api = Get.find<ApiClient>();
    Get.lazyPut(() => WalletRepository(api));
    Get.lazyPut(() => WalletController(Get.find()));
  }
}
