import 'package:drift/drift.dart';
import 'package:mono_app/database/entity/base_entity.dart';
import 'package:mono_app/enums/currency_type_enum.dart';
import 'package:mono_app/enums/wallet_type_enum.dart';
import 'package:uuid/uuid.dart';

class Wallet extends Table with BaseEntity {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  TextColumn get type => text().map(const WalletTypeConverter())();
  RealColumn get balance => real().withDefault(const Constant(0))();
  TextColumn get currency => text().map(const CurrencyTypeConverter())();

  @override
  Set<Column> get primaryKey => {id};
}
