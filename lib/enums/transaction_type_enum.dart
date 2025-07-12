import 'package:drift/drift.dart';

enum TransactionType { income, expense }

class TransactionTypeConverter extends TypeConverter<TransactionType, String> {
  const TransactionTypeConverter();

  @override
  TransactionType fromSql(String fromDb) =>
      TransactionType.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(TransactionType value) => value.name;
}