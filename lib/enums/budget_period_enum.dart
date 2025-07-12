import 'package:drift/drift.dart';

enum BudgetPeriod { weekly, monthly, yearly }

class BudgetPeriodConverter extends TypeConverter<BudgetPeriod, String> {
  const BudgetPeriodConverter();

  @override
  BudgetPeriod fromSql(String fromDb) =>
      BudgetPeriod.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(BudgetPeriod value) => value.name;
}