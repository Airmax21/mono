import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mono_app/database/db_connection.dart';
// import 'package:mono_app/analytics_service.dart';
import 'package:mono_app/lang/lang.dart';
// import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:mono_app/pages/splash/splash_screen.dart';
import 'package:mono_app/routes.dart';
import 'package:mono_app/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init('MoNo');
  Get.put(DBConnection());
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(GetMaterialApp(
    title: 'Mono',
    debugShowCheckedModeBanner: false,
    initialRoute: SplashScreen.routeName,
    getPages: routes,
    translations: Lang(),
    defaultTransition: Transition.noTransition,
    locale: const Locale('id','ID'),
    fallbackLocale: const Locale('en','US'),
    theme: Themes.lightTheme,
    darkTheme: Themes.darkTheme,
    themeMode: ThemeMode.system,
    // navigatorObservers: [
    //   // AnalyticsService().getAnalyticsObserver()
    // ],
  ));
}
