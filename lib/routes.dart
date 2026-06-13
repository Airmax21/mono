import 'package:get/get.dart';
import 'package:mono_app/bindings/budgets_binding.dart';
import 'package:mono_app/bindings/transactions_binding.dart';
import 'package:mono_app/bindings/wallet_binding.dart';
import 'package:mono_app/bindings/login_binding.dart';
import 'package:mono_app/bindings/chat_binding.dart';
import 'package:mono_app/bindings/statistics_binding.dart';
import 'package:mono_app/bindings/account_binding.dart';
import 'package:mono_app/pages/budgets/budgets.dart';
import 'package:mono_app/pages/budgets_list/budgets_list.dart';
import 'package:mono_app/pages/dashboard/dashboard.dart';
import 'package:mono_app/pages/onboarding/onboarding.dart';
import 'package:mono_app/pages/splash/splash_screen.dart';
import 'package:mono_app/pages/statistics/statistics.dart';
import 'package:mono_app/pages/transactions/transactions.dart';
import 'package:mono_app/pages/wallets/wallets.dart';
import 'package:mono_app/pages/login/login.dart';
import 'package:mono_app/pages/chat/chat.dart';
import 'package:mono_app/pages/account/account.dart';

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
    name: LoginPage.routeName,
    page: () => const LoginPage(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: Budgets.routeName,
    page: () => const Budgets(),
    bindings: [
      TransactionsBinding(),
      BudgetsBinding()
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
    page: () => const Statistics(),
    binding: StatisticsBinding(),
  ),
  GetPage(
    name: ChatPage.routeName,
    page: () => const ChatPage(),
    binding: ChatBinding(),
  ),
  GetPage(
    name: AccountPage.routeName,
    page: () => const AccountPage(),
    binding: AccountBinding(),
  )
];
