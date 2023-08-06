import 'package:butcekontrol/App/butce_kontrol_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:butcekontrol/utils/notification_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //Widgetlerin önceden yüklendiğine emin olmak için kullandık
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,  // Sadece Dikeyde çalışması için .
  ]);
  //await Future.delayed(const Duration(milliseconds: 750));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF03111A), // navigation bar color
    statusBarColor: Color(0xFF03111A), // status bar color
  ));

  await Firebase.initializeApp();
  //LocalNotificationService().initNotification();
  FirebaseMessaging.onBackgroundMessage(FirebaseNotificationService.backgroundMessage);
  runApp( const ProviderScope(child: ButceKontrolApp()));
  print("Device Token: ${await FirebaseMessaging.instance.getToken()}  son");
}
