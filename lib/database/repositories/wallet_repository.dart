import 'package:mono_app/database/DAO/wallet_dao.dart';
import 'package:mono_app/database/db_connection.dart';

class WalletRepository {
  final WalletDao _dao;

  WalletRepository(this._dao);

  Future<List<WalletData>> getWallets() {
    return _dao.getAllWallets();
  }

  Stream<List<WalletData>> watchWallets() {
    return _dao.watchAllWallets();
  }

  Future<List<WalletData>> getFilteredWallets({
    String? name,
    String? type,
  }) {
    return _dao.getWalletsByFilter(
      name: name,
      type: type,
    );
  }

  Stream<List<WalletData>> watchFilteredWallets({
    String? name,
    String? type,
  }) {
    return _dao.watchWalletsByFilter(
      name: name,
      type: type,
    );
  }

  Future<void> addWallet(WalletCompanion data) {
    return _dao.insertWallet(data);
  }

  Future<void> updateWallet(WalletCompanion data) {
    return _dao.updateWallet(data);
  }

  Future<void> deleteWallet(String id) {
    return _dao.deleteWallet(id);
  }
}
