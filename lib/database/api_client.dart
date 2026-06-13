import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:mono_app/database/models.dart';
import 'package:mono_app/enums/wallet_type_enum.dart';
import 'package:mono_app/enums/currency_type_enum.dart';
import 'package:mono_app/enums/transaction_type_enum.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/enums/budget_period_enum.dart';import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ApiClient {
  final GetStorage _box = GetStorage('MoNo');

  String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:8080/api/v1';
    }
    if (Platform.isAndroid) {
      return 'http://192.168.101.74:8080/api/v1';
    }
    return 'http://localhost:8080/api/v1';
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await getOrRegisterDefaultUser();
    return {
      'Content-Type': 'application/json',
      'X-App-Version': '1.0.0+1',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<String?> getOrRegisterDefaultUser() async {
    final token = _box.read<String>('jwt_token');
    if (token != null && !_isTokenExpired(token)) {
      return token;
    }

    final refreshToken = _box.read<String>('refresh_token');
    if (refreshToken != null) {
      try {
        final newAccessToken = await refreshAccessToken(refreshToken);
        if (newAccessToken != null) {
          _box.write('jwt_token', newAccessToken);
          return newAccessToken;
        }
      } catch (e) {
        debugPrint('Failed to auto refresh access token: $e');
        _box.remove('jwt_token');
        _box.remove('refresh_token');
      }
    }
    return null;
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final Map<String, dynamic> claims = jsonDecode(decoded);

      if (claims.containsKey('exp')) {
        final exp = claims['exp'] as int;
        final expiryTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
        return DateTime.now().add(const Duration(seconds: 10)).isAfter(expiryTime);
      }
      return true;
    } catch (e) {
      debugPrint('Error parsing token expiry: $e');
      return true;
    }
  }

  Future<String?> refreshAccessToken(String refreshToken) async {
    final url = Uri.parse('$baseUrl/auth/refresh');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-App-Version': '1.0.0+1',
      },
      body: jsonEncode({'refresh_token': refreshToken}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['success'] == true && body['data'] != null) {
        return body['data']['access_token'];
      }
    }
    return null;
  }

  String get serverHost {
    return baseUrl.replaceAll('/api/v1', '');
  }

  Future<String> syncProfilePhoto(String? remotePhotoPath, String email) async {
    if (remotePhotoPath == null || remotePhotoPath.isEmpty) {
      _box.remove('user_profile_photo_$email');
      _box.remove('user_profile_photo_url_$email');
      if (_box.read<String>('user_email') == email) {
        _box.remove('user_profile_photo');
      }
      return '';
    }

    final cachedUrl = _box.read<String>('user_profile_photo_url_$email') ?? '';
    final cachedLocalPath = _box.read<String>('user_profile_photo_$email') ?? '';

    if (cachedUrl == remotePhotoPath && cachedLocalPath.isNotEmpty && File(cachedLocalPath).existsSync()) {
      return cachedLocalPath;
    }

    try {
      final fullUrl = '$serverHost$remotePhotoPath';
      final token = await getOrRegisterDefaultUser();
      final response = await http.get(
        Uri.parse(fullUrl),
        headers: {
          'X-App-Version': '1.0.0+1',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        final ext = p.extension(remotePhotoPath);
        final String newPath = p.join(appDocDir.path, 'profile_photo_${email}_cached$ext');
        
        final File file = File(newPath);
        await file.writeAsBytes(response.bodyBytes);

        _box.write('user_profile_photo_url_$email', remotePhotoPath);
        _box.write('user_profile_photo_$email', newPath);
        if (_box.read<String>('user_email') == email) {
          _box.write('user_profile_photo', newPath);
        }
        return newPath;
      }
    } catch (e) {
      debugPrint('Failed to download profile photo: $e');
    }

    if (cachedLocalPath.isNotEmpty && File(cachedLocalPath).existsSync()) {
      return cachedLocalPath;
    }
    return '';
  }

  Future<Map<String, dynamic>?> getProfile() async {
    final url = Uri.parse('$baseUrl/auth/profile');
    final response = await http.get(url, headers: await _getHeaders());

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['success'] == true && body['data'] != null) {
        return body['data'];
      }
    }
    return null;
  }

  Future<String?> uploadProfilePhoto(File imageFile) async {
    final token = await getOrRegisterDefaultUser();
    final url = Uri.parse('$baseUrl/auth/profile-photo');
    final request = http.MultipartRequest('POST', url)
      ..headers.addAll({
        if (token != null) 'Authorization': 'Bearer $token',
        'X-App-Version': '1.0.0+1',
      })
      ..files.add(await http.MultipartFile.fromPath('photo', imageFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['success'] == true && body['data'] != null) {
        final profilePhoto = body['data']['profile_photo'] as String?;
        return profilePhoto;
      }
    }
    final body = jsonDecode(response.body);
    throw Exception(body['error'] ?? 'Upload foto profil gagal');
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-App-Version': '1.0.0+1',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['success'] == true && body['data'] != null) {
        final data = body['data'];
        final accessToken = data['access_token'];
        final refreshToken = data['refresh_token'];
        _box.write('jwt_token', accessToken);
        _box.write('refresh_token', refreshToken);
        
        if (data['user'] != null) {
          if (data['user']['name'] != null) {
            _box.write('user_name', data['user']['name'] as String);
          }
          if (data['user']['email'] != null) {
            final email = data['user']['email'] as String;
            _box.write('user_email', email);
            
            final remotePhoto = data['user']['profile_photo'] as String?;
            final localPhotoPath = await syncProfilePhoto(remotePhoto, email);
            _box.write('user_profile_photo', localPhotoPath);
          }
        }
        return data;
      }
    }
    final body = jsonDecode(response.body);
    throw Exception(body['error'] ?? 'Login gagal');
  }

  Future<void> register(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-App-Version': '1.0.0+1',
      },
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode != 201) {
      final body = jsonDecode(response.body);
      throw Exception(body['error'] ?? 'Registrasi gagal');
    }
  }

  // --- Wallets Endpoints ---

  Future<List<WalletData>> getWallets() async {
    try {
      final url = Uri.parse('$baseUrl/wallets');
      final response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> list = body['data'] ?? [];
        return list.map((item) => WalletData.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting wallets: $e');
      return [];
    }
  }

  Future<WalletData> getWalletByID({required String id}) async {
    final url = Uri.parse('$baseUrl/wallets/$id');
    final response = await http.get(url, headers: await _getHeaders());

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return WalletData.fromJson(body['data']);
    }
    throw Exception('Wallet not found');
  }

  Future<void> addWallet(WalletCompanion companion) async {
    final name = companion.name?.value ?? '';
    final type = companion.type?.value ?? WalletType.cash;
    final currency = companion.currency?.value ?? CurrencyType.idr;

    final url = Uri.parse('$baseUrl/wallets');
    final response = await http.post(
      url,
      headers: await _getHeaders(),
      body: jsonEncode({
        'name': '$name|${type.name}|${currency.name}',
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create wallet: ${response.body}');
    }
  }

  Future<void> updateWallet(WalletCompanion companion) async {
    final id = companion.id?.value;
    if (id == null) return;

    final name = companion.name?.value ?? '';
    final type = companion.type?.value ?? WalletType.cash;
    final currency = companion.currency?.value ?? CurrencyType.idr;

    final url = Uri.parse('$baseUrl/wallets/$id');
    final response = await http.put(
      url,
      headers: await _getHeaders(),
      body: jsonEncode({
        'name': '$name|${type.name}|${currency.name}',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update wallet: ${response.body}');
    }
  }

  Future<void> deleteWallet(String id) async {
    final url = Uri.parse('$baseUrl/wallets/$id');
    final response = await http.delete(url, headers: await _getHeaders());

    if (response.statusCode != 200) {
      throw Exception('Failed to delete wallet: ${response.body}');
    }
  }

  // --- Transactions Endpoints ---

  Future<List<Transaction>> getTransactions() async {
    try {
      final url = Uri.parse('$baseUrl/transactions?limit=100');
      final response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> list = body['data'] ?? [];
        return list.map((item) => Transaction.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting transactions: $e');
      return [];
    }
  }

  Future<Transaction> getTransactionById({required String id}) async {
    // Backend doesn't have a direct GET /transactions/:id endpoint, but we can search in list
    final list = await getTransactions();
    return list.firstWhere((tx) => tx.id == id, orElse: () => throw Exception('Transaction not found'));
  }

  Future<void> addTransaction(TransactionsCompanion companion) async {
    final name = companion.name?.value ?? '';
    final walletId = companion.wallet?.value ?? '';
    final amount = companion.price?.value ?? 0.0;
    final type = companion.transactionType?.value ?? TransactionType.expense;
    final category = companion.category?.value ?? Category.others;

    final url = Uri.parse('$baseUrl/transactions/manual');
    final response = await http.post(
      url,
      headers: await _getHeaders(),
      body: jsonEncode({
        'wallet_id': walletId,
        'amount': amount,
        'category': category.name,
        'description': name,
        'type': type == TransactionType.income ? 'INCOME' : 'EXPENSE',
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create transaction: ${response.body}');
    }
  }

  Future<void> updateTransaction(TransactionsCompanion companion) async {
    final id = companion.id?.value;
    if (id == null) return;

    final name = companion.name?.value ?? '';
    final walletId = companion.wallet?.value ?? '';
    final amount = companion.price?.value ?? 0.0;
    final type = companion.transactionType?.value ?? TransactionType.expense;
    final category = companion.category?.value ?? Category.others;

    final url = Uri.parse('$baseUrl/transactions/$id');
    final response = await http.put(
      url,
      headers: await _getHeaders(),
      body: jsonEncode({
        'wallet_id': walletId,
        'amount': amount,
        'category': category.name,
        'description': name,
        'type': type == TransactionType.income ? 'INCOME' : 'EXPENSE',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update transaction: ${response.body}');
    }
  }

  Future<void> deleteTransaction(String id) async {
    final url = Uri.parse('$baseUrl/transactions/$id');
    final response = await http.delete(url, headers: await _getHeaders());

    if (response.statusCode != 200) {
      throw Exception('Failed to delete transaction: ${response.body}');
    }
  }

  Future<TransactionStatistics?> getTransactionStatistics({String? month}) async {
    try {
      final queryParam = (month != null && month.isNotEmpty) ? '?month=$month' : '';
      final url = Uri.parse('$baseUrl/transactions/statistics$queryParam');
      final response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['success'] == true && body['data'] != null) {
          return TransactionStatistics.fromJson(body['data']);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error getting transaction statistics: $e');
      return null;
    }
  }

  // --- Budgets (Backend Synchronized) ---

  Future<List<Budget>> getBudgets() async {
    try {
      final url = Uri.parse('$baseUrl/budgets');
      final response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> list = body['data'] ?? [];
        return list.map((item) => Budget.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting budgets: $e');
      return [];
    }
  }

  Future<Budget> getBudgetById({required String id}) async {
    final url = Uri.parse('$baseUrl/budgets/$id');
    final response = await http.get(url, headers: await _getHeaders());

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Budget.fromJson(body['data']);
    }
    throw Exception('Budget not found');
  }

  Future<void> addBudget(BudgetsCompanion companion) async {
    final walletId = companion.walletId?.value;
    final amount = companion.amount?.value ?? 0.0;
    final period = companion.period?.value ?? BudgetPeriod.monthly;
    final category = companion.category?.value ?? Category.others;
    final startDate = companion.startDate?.value ?? DateTime.now();
    final endDate = companion.endDate?.value;

    final url = Uri.parse('$baseUrl/budgets');
    final response = await http.post(
      url,
      headers: await _getHeaders(),
      body: jsonEncode({
        'wallet_id': (walletId != null && walletId.isNotEmpty) ? walletId : null,
        'amount': amount,
        'period': period.name,
        'category': category.name,
        'start_date': startDate.toUtc().toIso8601String(),
        'end_date': endDate?.toUtc().toIso8601String(),
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create budget: ${response.body}');
    }
  }

  Future<void> updateBudget(BudgetsCompanion companion) async {
    final id = companion.id?.value;
    if (id == null) return;

    final walletId = companion.walletId?.value;
    final amount = companion.amount?.value ?? 0.0;
    final period = companion.period?.value ?? BudgetPeriod.monthly;
    final category = companion.category?.value ?? Category.others;
    final startDate = companion.startDate?.value ?? DateTime.now();
    final endDate = companion.endDate?.value;

    final url = Uri.parse('$baseUrl/budgets/$id');
    final response = await http.put(
      url,
      headers: await _getHeaders(),
      body: jsonEncode({
        'wallet_id': (walletId != null && walletId.isNotEmpty) ? walletId : null,
        'amount': amount,
        'period': period.name,
        'category': category.name,
        'start_date': startDate.toUtc().toIso8601String(),
        'end_date': endDate?.toUtc().toIso8601String(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update budget: ${response.body}');
    }
  }

  Future<void> deleteBudget(String id) async {
    final url = Uri.parse('$baseUrl/budgets/$id');
    final response = await http.delete(url, headers: await _getHeaders());

    if (response.statusCode != 200) {
      throw Exception('Failed to delete budget: ${response.body}');
    }
  }

  // --- LLM Chat Endpoints ---

  Future<List<ChatSession>> getChatSessions() async {
    try {
      final url = Uri.parse('$baseUrl/llm/sessions');
      final response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((item) => ChatSession.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting chat sessions: $e');
      return [];
    }
  }

  Future<ChatSession> createChatSession(String title) async {
    final url = Uri.parse('$baseUrl/llm/sessions');
    final response = await http.post(
      url,
      headers: await _getHeaders(),
      body: jsonEncode({'title': title}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return ChatSession.fromJson(body);
    }
    throw Exception('Failed to create chat session: ${response.body}');
  }

  Future<List<ChatMessage>> getChatMessages(String sessionId) async {
    try {
      final url = Uri.parse('$baseUrl/llm/sessions/$sessionId/messages');
      final response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((item) => ChatMessage.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting chat messages: $e');
      return [];
    }
  }

  Future<void> deleteChatSession(String sessionId) async {
    final url = Uri.parse('$baseUrl/llm/sessions/$sessionId');
    final response = await http.delete(url, headers: await _getHeaders());

    if (response.statusCode != 200) {
      throw Exception('Failed to delete chat session: ${response.body}');
    }
  }

  Future<void> chatStream({
    String? sessionId,
    required String message,
    required Function(LLMResponseChunk) onChunk,
  }) async {
    final url = Uri.parse('$baseUrl/llm/chat');
    final client = http.Client();

    try {
      final request = http.Request('POST', url)
        ..headers.addAll(await _getHeaders())
        ..body = jsonEncode({
          if (sessionId != null && sessionId.isNotEmpty) 'session_id': sessionId,
          'message': message,
        });

      final response = await client.send(request);

      if (response.statusCode != 200) {
        throw Exception('Failed to send message: ${response.statusCode}');
      }

      final stream = response.stream.transform(utf8.decoder).transform(const LineSplitter());
      await for (final line in stream) {
        if (line.startsWith('data: ')) {
          final jsonStr = line.substring(6).trim();
          if (jsonStr.isNotEmpty) {
            try {
              final jsonMap = jsonDecode(jsonStr);
              final chunk = LLMResponseChunk.fromJson(jsonMap);
              onChunk(chunk);
            } catch (e) {
              debugPrint('Error decoding chunk: $e');
            }
          }
        } else if (line.startsWith('event: error')) {
          throw Exception('Server error in chat stream');
        }
      }
    } finally {
      client.close();
    }
  }
}
