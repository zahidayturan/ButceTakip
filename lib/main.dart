import 'package:butcekontrol/App/ButceKontrolApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //Widgetlerin önceden yüklendiğine emin olmak için kullandık
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,  // Sadece Dikeyde çalışması için .
  ]);
  runApp(ButceKontrolApp());
}
