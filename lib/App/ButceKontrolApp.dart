import 'package:flutter/material.dart';
import 'base_BKA.dart';

class ButceKontrolApp extends StatelessWidget {
  const ButceKontrolApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bütçe Kontrol Uygulaması",
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: "Nexa",
      ),
      home: base_BKA(),
    );
  }
}


