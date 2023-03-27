import 'package:flutter/material.dart';
import 'base_BKA.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ButceKontrolApp extends StatelessWidget {
  const ButceKontrolApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('zh'),
        const Locale('he'),
        const Locale('ru'),
        const Locale('fr', 'BE'),
        const Locale('fr', 'CA'),
        const Locale('ja'),
        const Locale('de'),
        const Locale('hi'),
        const Locale('ar'),
        const Locale('tr'),
      ],
      locale: const Locale('tr'),
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


