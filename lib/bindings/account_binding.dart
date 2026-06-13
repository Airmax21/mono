import 'package:get/get.dart';
import 'package:mono_app/controllers/account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController());
  }
}
