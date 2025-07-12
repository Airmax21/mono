import 'package:get/get.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/database/repositories/transactions_repository.dart';
import 'package:mono_app/pages/transactions/controllers/transactions_controller.dart';

class TransactionsBinding extends Bindings {
  @override
  void dependencies() {
    final db = Get.find<DBConnection>();
    Get.lazyPut(() => TransactionsRepository(db.transactionsDAO));
    Get.lazyPut(() => TransactionsController(Get.find()));
  }
}
