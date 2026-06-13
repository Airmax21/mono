import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mono_app/database/api_client.dart';
import 'package:mono_app/lang/lang.dart';
import 'package:get/get.dart';
import 'package:mono_app/pages/splash/splash_screen.dart';
import 'package:mono_app/routes.dart';
import 'package:mono_app/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init('MoNo');
  Get.put(ApiClient());
  debugPrint('Booting MoNo App Version: 1.0.0+1');

  final box = GetStorage('MoNo');
  final String savedLanguage = box.read<String>('language') ?? 'id';
  final bool? savedIsDark = box.read<bool>('is_dark');

  runApp(GetMaterialApp(
    title: 'Mono',
    debugShowCheckedModeBanner: false,
    initialRoute: SplashScreen.routeName,
    getPages: routes,
    translations: Lang(),
    defaultTransition: Transition.noTransition,
    locale: savedLanguage == 'en' ? const Locale('en','US') : const Locale('id','ID'),
    fallbackLocale: const Locale('en','US'),
    theme: Themes.lightTheme,
    darkTheme: Themes.darkTheme,
    themeMode: savedIsDark == null 
        ? ThemeMode.system 
        : (savedIsDark ? ThemeMode.dark : ThemeMode.light),
  ));
}
