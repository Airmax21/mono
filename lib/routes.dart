import 'package:get/get.dart';
import 'package:mono_app/bindings/budgets_binding.dart';
import 'package:mono_app/bindings/transactions_binding.dart';
import 'package:mono_app/bindings/wallet_binding.dart';
import 'package:mono_app/pages/budgets/budgets.dart';
import 'package:mono_app/pages/budgets_list/budgets_list.dart';
import 'package:mono_app/pages/dashboard/dashboard.dart';
import 'package:mono_app/pages/onboarding/onboarding.dart';
import 'package:mono_app/pages/splash/splash_screen.dart';
import 'package:mono_app/pages/statistics/statistics.dart';
import 'package:mono_app/pages/transactions/transactions.dart';
import 'package:mono_app/pages/wallets/wallets.dart';

final List<GetPage> routes = [
  GetPage(
    name: SplashScreen.routeName,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: Dashboard.routeName,
    page: () => const Dashboard(),
    bindings: [
      TransactionsBinding()
    ]
  ),
  GetPage(
    name: Onboarding.routeName,
    page: () => const Onboarding(),
  ),
  GetPage(
    name: Budgets.routeName,
    page: () => const Budgets(),
    bindings: [
      TransactionsBinding()
    ]
  ),
  GetPage(
    name: BudgetsList.routeName,
    page: () => const BudgetsList(),
    bindings: [
      BudgetsBinding()
    ]
  ),
  GetPage(
    name: Transactions.routeName,
    page: () => const Transactions(),
    bindings: [
      WalletBinding(),
      TransactionsBinding()
    ]
  ),
  GetPage(
    name: Wallets.routeName,
    page: () => const Wallets(),
    binding: WalletBinding()
  ),
  GetPage(
    name: Statistics.routeName,
    page: () => const Statistics()
  )
];
