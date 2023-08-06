import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'base_BKA.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ButceKontrolApp extends ConsumerStatefulWidget {
  const ButceKontrolApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ButceKontrolApp> createState() => _ButceKontrolAppState();
}

class _ButceKontrolAppState extends ConsumerState<ButceKontrolApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        );
      },
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
      title: "Bütçe Takip",
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: "Nexa3",
        unselectedWidgetColor: Colors.orange, // checkbox border rengi için kullandım.
      ),
      home: const base_BKA(),
    );
  }
}



