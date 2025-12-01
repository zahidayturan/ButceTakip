import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/base_app.dart';
import 'core/services/app_info_service.dart';
import 'core/utils/notification_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(FirebaseNotificationService.backgroundMessage);

  final container = ProviderContainer();
  final appInfoService = container.read(appInfoServiceProvider);
  Map<String, String> appInfoData = await appInfoService.getAppInfo();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool showBTA = prefs.getBool("showBTA") ?? false;

  runApp( ProviderScope(child: BaseApp(showBTA: showBTA, appInfo: appInfoData)));
}
