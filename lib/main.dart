import 'package:all_in_one_game/internet_connection/connection_manager_controller.dart';
import 'package:all_in_one_game/splash/splash.dart';
import 'package:all_in_one_game/utils/colors.dart';
import 'package:all_in_one_game/utils/preferences/preference_manager.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

bool isInitialized = false;

Future<void> main() async {
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference().initialAppPreference();

  bool? isInit = await AppLovinMAX.isInitialized();
  if (isInit == false) {
    Map? sdkConfiguration = await AppLovinMAX.initialize(
        "EWTkTpVn6CVVOwTUcN_3yNn1_5heLMmFCkaByOrwvUzdi1XEqoveMqKqKwsMblfvVwIL1HQ1SZSDt8kkGbtAQK");
    if (sdkConfiguration != null) {
      isInitialized = true;
      await AppPreference().setBool("sdk", true);
    }
  }
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Kanit',
          scaffoldBackgroundColor: ColorUtils.primaryColor),
      home: const SplashPage(),
    );
  }
}
