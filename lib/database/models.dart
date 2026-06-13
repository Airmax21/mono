import 'package:mono_app/enums/wallet_type_enum.dart';
import 'package:mono_app/enums/currency_type_enum.dart';
import 'package:mono_app/enums/transaction_type_enum.dart';
import 'package:mono_app/enums/category_enum.dart';
import 'package:mono_app/enums/budget_period_enum.dart';

class Value<T> {
  final T value;
  const Value(this.value);
}

class WalletData {
  final String id;
  final String name;
  final WalletType type;
  final double balance;
  final CurrencyType currency;
  final DateTime createdAt;
  final DateTime? updatedAt;

  WalletData({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.currency,
    required this.createdAt,
    this.updatedAt,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) {
    final rawName = json['name'] ?? '';
    final parts = rawName.split('|');
    final name = parts[0];
    
    WalletType type = WalletType.cash;
    if (parts.length > 1) {
      type = WalletType.values.firstWhere((e) => e.name == parts[1], orElse: () => WalletType.cash);
    }
    
    CurrencyType currency = CurrencyType.idr;
    if (parts.length > 2) {
      currency = CurrencyType.values.firstWhere((e) => e.name == parts[2], orElse: () => CurrencyType.idr);
    }

    return WalletData(
      id: json['id'] ?? '',
      name: name,
      type: type,
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      currency: currency,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': '$name|${type.name}|${currency.name}',
      'balance': balance,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class WalletCompanion {
  final Value<String>? id;
  final Value<String>? name;
  final Value<WalletType>? type;
  final Value<CurrencyType>? currency;

  const WalletCompanion({
    this.id,
    this.name,
    this.type,
    this.currency,
  });
}

class Transaction {
  final String id;
  final String name; 
  final String wallet; 
  final double price; 
  final TransactionType transactionType; 
  final Category category;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Transaction({
    required this.id,
    required this.name,
    required this.wallet,
    required this.price,
    required this.transactionType,
    required this.category,
    required this.createdAt,
    this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? '',
      name: json['description'] ?? '',
      wallet: json['wallet_id'] ?? '',
      price: (json['amount'] as num?)?.toDouble() ?? 0.0,
      transactionType: (json['type'] == 'INCOME') ? TransactionType.income : TransactionType.expense,
      category: Category.values.firstWhere((e) => e.name == json['category'], orElse: () => Category.others),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': name,
      'wallet_id': wallet,
      'amount': price,
      'type': (transactionType == TransactionType.income) ? 'INCOME' : 'EXPENSE',
      'category': category.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class TransactionsCompanion {
  final Value<String>? id;
  final Value<String>? name;
  final Value<TransactionType>? transactionType;
  final Value<String>? wallet;
  final Value<double>? price;
  final Value<Category>? category;

  const TransactionsCompanion({
    this.id,
    this.name,
    this.transactionType,
    this.wallet,
    this.price,
    this.category,
  });
}

class Budget {
  final String id;
  final String? walletId;
  final double amount;
  final double spent;
  final BudgetPeriod period;
  final Category category;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Budget({
    required this.id,
    this.walletId,
    required this.amount,
    required this.spent,
    required this.period,
    required this.category,
    required this.startDate,
    this.endDate,
    required this.createdAt,
    this.updatedAt,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'] ?? '',
      walletId: json['wallet_id'],
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      spent: (json['spent'] as num?)?.toDouble() ?? 0.0,
      period: BudgetPeriod.values.firstWhere((e) => e.name == json['period'], orElse: () => BudgetPeriod.monthly),
      category: Category.values.firstWhere((e) => e.name == json['category'], orElse: () => Category.others),
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : DateTime.now(),
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wallet_id': walletId,
      'amount': amount,
      'spent': spent,
      'period': period.name,
      'category': category.name,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class BudgetsCompanion {
  final Value<String>? id;
  final Value<String?>? walletId;
  final Value<double>? amount;
  final Value<BudgetPeriod>? period;
  final Value<Category>? category;
  final Value<DateTime>? startDate;
  final Value<DateTime?>? endDate;

  const BudgetsCompanion({
    this.id,
    this.walletId,
    this.amount,
    this.period,
    this.category,
    this.startDate,
    this.endDate,
  });
}

class ChatSession {
  final String id;
  final String userId;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatSession({
    required this.id,
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      title: json['title'] ?? '',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class ChatMessage {
  final String id;
  final String sessionId;
  final String role; // user or assistant
  final String content;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.sessionId,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] ?? '',
      sessionId: json['session_id'] ?? '',
      role: json['role'] ?? '',
      content: json['content'] ?? '',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'session_id': sessionId,
      'role': role,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class LLMResponseChunk {
  final String content;
  final bool done;
  final String? sessionId;

  LLMResponseChunk({
    required this.content,
    required this.done,
    this.sessionId,
  });

  factory LLMResponseChunk.fromJson(Map<String, dynamic> json) {
    return LLMResponseChunk(
      content: json['content'] ?? '',
      done: json['done'] ?? false,
      sessionId: json['session_id'],
    );
  }
}

class TransactionStatistics {
  final double totalRevenue;
  final double revenueChange;
  final double revenuePercentageChange;
  final double totalExpenditure;
  final double expenditureChange;
  final double expenditurePercentageChange;
  final List<double> weeklyExpenses;
  final List<double> weeklyRevenue;

  TransactionStatistics({
    required this.totalRevenue,
    required this.revenueChange,
    required this.revenuePercentageChange,
    required this.totalExpenditure,
    required this.expenditureChange,
    required this.expenditurePercentageChange,
    required this.weeklyExpenses,
    required this.weeklyRevenue,
  });

  factory TransactionStatistics.fromJson(Map<String, dynamic> json) {
    final expenseList = json['weekly_expenses'] as List<dynamic>? ?? [];
    final weeklyExp = expenseList.map((item) => (item as num).toDouble()).toList();

    final revenueList = json['weekly_revenue'] as List<dynamic>? ?? [];
    final weeklyRev = revenueList.map((item) => (item as num).toDouble()).toList();

    return TransactionStatistics(
      totalRevenue: (json['total_revenue'] as num?)?.toDouble() ?? 0.0,
      revenueChange: (json['revenue_change'] as num?)?.toDouble() ?? 0.0,
      revenuePercentageChange: (json['revenue_percentage_change'] as num?)?.toDouble() ?? 0.0,
      totalExpenditure: (json['total_expenditure'] as num?)?.toDouble() ?? 0.0,
      expenditureChange: (json['expenditure_change'] as num?)?.toDouble() ?? 0.0,
      expenditurePercentageChange: (json['expenditure_percentage_change'] as num?)?.toDouble() ?? 0.0,
      weeklyExpenses: weeklyExp,
      weeklyRevenue: weeklyRev,
    );
  }
}
