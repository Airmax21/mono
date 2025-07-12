import 'package:drift/drift.dart';

enum WalletType { cash, bank, ewallet }

class WalletTypeConverter extends TypeConverter<WalletType, String> {
  const WalletTypeConverter();

  @override
  WalletType fromSql(String fromDb) =>
      WalletType.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(WalletType value) => value.name;
}