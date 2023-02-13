import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:to_do/core/shared/app_theme.dart';
import 'package:to_do/locator.dart';

import 'core/routes/app_pages.dart';
import 'feature/startup/startup_binding.dart';
import 'feature/startup/startup_page.dart';
import 'firebase_options.dart';
import 'locale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    //init service controllers
    initControllers();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppLocale(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale(
        'en_US',
      ),
      getPages: AppPages.pages,
      darkTheme: AppTheme().themeDataDark,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      theme: AppTheme().themeData,
      initialBinding: StartUpBinding(),
      home: const StartUpPage(),
    );
  }
}
