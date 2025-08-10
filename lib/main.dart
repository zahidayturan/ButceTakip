import 'package:butcetakip/App/butce_kontrol_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:butcetakip/utils/notification_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/app_info_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF03111A),
    statusBarColor: Color(0xFF03111A),
  ));

  await Firebase.initializeApp();

  final container = ProviderContainer();
  final appInfoService = container.read(appInfoServiceProvider);
  Map<String, String> appInfoData = await appInfoService.getAppInfo();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool showBTA = prefs.getBool("showBTA") ?? false;
  FirebaseMessaging.onBackgroundMessage(FirebaseNotificationService.backgroundMessage);
  debugPrint("Device Token: ${await FirebaseMessaging.instance.getToken()}  son");

  runApp( ProviderScope(child: ButceKontrolApp(showBTA: showBTA, appInfo: appInfoData)));
}
