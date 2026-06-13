import 'package:get/get.dart';
import 'package:mono_app/database/api_client.dart';
import 'package:mono_app/database/repositories/budgets_repository.dart';
import 'package:mono_app/controllers/budgets_controller.dart';

class BudgetsBinding extends Bindings {
  @override
  void dependencies() {
    final api = Get.find<ApiClient>();
    Get.lazyPut(() => BudgetsRepository(api));
    Get.lazyPut(() => BudgetsController(Get.find()));
  }
}
