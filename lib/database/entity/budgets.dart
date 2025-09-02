import 'package:drift/drift.dart';
import 'package:mono_app/database/entity/base_entity.dart';
import 'package:mono_app/enums/budget_period_enum.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:uuid/uuid.dart';

class Budgets extends Table with BaseEntity {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get walletId => text().nullable()();
  RealColumn get amount => real()();
  RealColumn get spent => real()();
  TextColumn get period => text().map(const BudgetPeriodConverter())();
  TextColumn get category => text().map(const CategoryEnum())();
  DateTimeColumn get startDate => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get endDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
