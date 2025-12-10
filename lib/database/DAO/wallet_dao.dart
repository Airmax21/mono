import 'package:drift/drift.dart';
import 'package:mono_app/database/db_connection.dart';
import 'package:mono_app/database/entity/wallet.dart';

part 'wallet_dao.g.dart';

@DriftAccessor(tables: [Wallet])
class WalletDao extends DatabaseAccessor<DBConnection> with _$WalletDaoMixin {
  WalletDao(super.db);

  Future<List<WalletData>> getAllWallets() => select(wallet).get();

  Stream<List<WalletData>> watchAllWallets() => select(wallet).watch();

  Future<List<WalletData>> getWalletsByFilter({
    String? name,
    String? type,
  }) {
    final query = select(wallet);

    if (name != null && name.isNotEmpty) {
      query.where((tbl) => tbl.name.like('%$name%'));
    }

    if (type != null && type.isNotEmpty) {
      query.where((tbl) => tbl.type.equals(type));
    }

    return query.get();
  }

  Stream<List<WalletData>> watchWalletsByFilter({
    String? name,
    String? type,
  }) {
    final query = select(wallet);

    if (name != null && name.isNotEmpty) {
      query.where((tbl) => tbl.name.like('%$name%'));
    }

    if (type != null && type.isNotEmpty) {
      query.where((tbl) => tbl.type.equals(type));
    }

    return query.watch();
  }

  Future<WalletData> getWalletByID({required String id}) =>
      (select(wallet)..where((t) => t.id.equals(id))).getSingle();

  Future<void> insertWallet(WalletCompanion data) => into(wallet).insert(data);

  Future<bool> updateWallet(WalletCompanion data) =>
      update(wallet).replace(data);

  Future<int> deleteWallet(String id) =>
      (delete(wallet)..where((w) => w.id.equals(id))).go();
}
