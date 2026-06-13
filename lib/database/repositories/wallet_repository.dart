import 'package:mono_app/database/api_client.dart';
import 'package:mono_app/database/models.dart';

class WalletRepository {
  final ApiClient _api;

  WalletRepository(this._api);

  Future<List<WalletData>> getWallets() {
    return _api.getWallets();
  }

  Stream<List<WalletData>> watchWallets() {
    return Stream.fromFuture(_api.getWallets());
  }

  Future<List<WalletData>> getFilteredWallets({
    String? name,
    String? type,
  }) async {
    final list = await _api.getWallets();
    return list.where((item) {
      final matchName = name == null || name.isEmpty || item.name.toLowerCase().contains(name.toLowerCase());
      final matchType = type == null || type.isEmpty || item.type.name == type;
      return matchName && matchType;
    }).toList();
  }

  Stream<List<WalletData>> watchFilteredWallets({
    String? name,
    String? type,
  }) {
    return Stream.fromFuture(getFilteredWallets(name: name, type: type));
  }

  Future<WalletData> getWalletByID({required String id}) {
    return _api.getWalletByID(id: id);
  }

  Future<void> addWallet(WalletCompanion data) {
    return _api.addWallet(data);
  }

  Future<void> updateWallet(WalletCompanion data) {
    return _api.updateWallet(data);
  }

  Future<void> deleteWallet(String id) {
    return _api.deleteWallet(id);
  }
}
