// @dart=2.9

import 'package:decapet/helpers/fcm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global/app_colors.dart';
import 'global/app_get_it.dart';
import 'language/language_service.dart';
import 'pages/splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  initFcm();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LanguageService.setLanguage('ko');

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: Brightness.light), // Or Brightness.dark
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Decapet',
      theme: ThemeData(primarySwatch: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity, highlightColor: AppColor_Primary),
      home: SplashPage(),
    );
  }
}
