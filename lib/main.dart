import 'dart:io';

import 'package:cashier_app/configs/bindings.dart';
import 'package:cashier_app/languages/locale_provider.dart';
import 'package:cashier_app/views/pages/payment/payment.dart';
import 'package:cashier_app/views/pages/splashscreen/splash_screen.dart';
import 'package:cashier_app/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:cashier_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => LocaleProvider())],
        child: Consumer<LocaleProvider>(
          builder: (context, provider, snapshot) => GetMaterialApp(
            title: "Cashier App",
            debugShowCheckedModeBanner: false,
            theme: Themes.lightTheme(context),
            darkTheme: Themes.darkTheme(context),
            themeMode: ThemeMode.system,
            home: const SplashScreen(),
            locale: provider.locale,
            initialBinding: InitialBindings(),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        ));
    //     home: const SplashScreen());5yk
  }
}
