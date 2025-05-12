import 'package:get/get.dart';
import 'package:mono_app/pages/budgets/budgets.dart';
import 'package:mono_app/pages/dashboard/dashboard.dart';
import 'package:mono_app/pages/onboarding/onboarding.dart';
import 'package:mono_app/pages/splash/splash_screen.dart';

final List<GetPage> routes = [
  GetPage(
    name: SplashScreen.routeName,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: Dashboard.routeName,
    page: () => const Dashboard()
  ),
  GetPage(
    name: Onboarding.routeName,
    page: () => const Onboarding()
  ),
  GetPage(
    name: Budgets.routeName, 
    page: () => const Budgets()
  )
];
