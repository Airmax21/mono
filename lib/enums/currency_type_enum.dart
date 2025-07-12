import 'package:drift/drift.dart';

enum CurrencyType { usd, idr }

class CurrencyTypeConverter extends TypeConverter<CurrencyType, String> {
  const CurrencyTypeConverter();

  @override
  CurrencyType fromSql(String fromDb) =>
      CurrencyType.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(CurrencyType value) => value.name;
}
