import 'package:butcekontrol/App/butce_kontrol_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //Widgetlerin önceden yüklendiğine emin olmak için kullandık
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,  // Sadece Dikeyde çalışması için .
  ]);
  await Future.delayed(const Duration(milliseconds: 100));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF03111A), // navigation bar color
    statusBarColor: Color(0xFF03111A), // status bar color
  ));

  await Firebase.initializeApp();
  runApp( const ProviderScope(child: ButceKontrolApp()));
}
