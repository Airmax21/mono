import 'package:get/get.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/database/repositories/budgets_repository.dart';
import 'package:mono_app/controllers/budgets_controller.dart';


class BudgetsBinding extends Bindings {
  @override
  void dependencies() {
    final db = Get.find<DBConnection>();
    Get.lazyPut(() => BudgetsRepository(db.budgetsDao));
    Get.lazyPut(() => BudgetsController(Get.find()));
  }
}
