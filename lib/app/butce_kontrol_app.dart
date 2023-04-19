import 'package:flutter/material.dart';
import 'base_BKA.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ButceKontrolApp extends StatelessWidget {
  const ButceKontrolApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr'),
      ],
      locale: const Locale('tr'),
      debugShowCheckedModeBanner: false,
      title: "Bütçe Kontrol Uygulaması",
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: "Nexa",
        unselectedWidgetColor: Colors.orange // checkbox border rengi için kullandım.
      ),
      home: const base_BKA(),
    );
  }
}


