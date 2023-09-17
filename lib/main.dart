import 'package:butcekontrol/App/butce_kontrol_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:butcekontrol/utils/notification_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Map<String, String>? appInfoData = await getAppInfo();
  Map<String, String>? controllerAppInfoData = {"appInfoString": "normal", "version": "1.0.0"};
  String? appInfo = appInfoData!["appInfoString"];
  String? appInfoString = appInfoData!["appInfoString"];
  if (appInfo != null && appInfoString != null) {
    controllerAppInfoData = appInfoData;
  } else {
    print("App Info alınamadı.");
  }
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool showBTA = prefs.getBool("showBTA") ?? false;
  FirebaseMessaging.onBackgroundMessage(FirebaseNotificationService.backgroundMessage);
  runApp( ProviderScope(child: ButceKontrolApp(showBTA: showBTA!, appInfo: controllerAppInfoData)));
  print("Device Token: ${await FirebaseMessaging.instance.getToken()}  son");
}

Future<Map<String, String>?> getAppInfo() async {
  try {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("appInfo").doc("security").get();
    Map<String, dynamic>? data = querySnapshot.data();

    if (data != null) {
      String? appInfoString = data["appStatus"];
      String? appVersionInfoString = data["version"];
      return {"appInfoString": appInfoString ?? "normal", "version": appVersionInfoString ?? "1.0.0"};
    } else {
      print("Not found.");
      return {"appInfoString": "normal", "version": "1.0.0"};
    }
  } catch (e) {
    print("Error $e");
    return {"appInfoString": "normal", "version": "1.0.0"};
  }
}

