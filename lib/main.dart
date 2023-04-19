import 'package:butcekontrol/App/butce_kontrol_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //Widgetlerin önceden yüklendiğine emin olmak için kullandık
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,  // Sadece Dikeyde çalışması için .
  ]);
  await Future.delayed(const Duration(seconds: 2));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF03111A), // navigation bar color
    statusBarColor: Color(0xFF03111A), // status bar color
  ));

  runApp( const ProviderScope(child: ButceKontrolApp()));
}
