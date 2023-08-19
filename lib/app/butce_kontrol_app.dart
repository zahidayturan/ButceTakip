import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';
import 'base_BKA.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButceKontrolApp extends ConsumerStatefulWidget {
  const ButceKontrolApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ButceKontrolApp> createState() => _ButceKontrolAppState();
}

class _ButceKontrolAppState extends ConsumerState<ButceKontrolApp> {

  @override
  Widget build(BuildContext context) {
    ref.watch(settingsRiverpod).isuseinsert;
    var readSettings = ref.read(settingsRiverpod);
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: readSettings.localChanger(), ///Dil ayarlama

      debugShowCheckedModeBanner: false,
      title: "Bütçe Takip",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFE9E9E9),
        canvasColor: Color(0xFF0D1C26),
        secondaryHeaderColor: Color(0xFF0D1C26),
        indicatorColor: Color(0xFFE9E9E9),
        splashColor: Color(0xffF2F2F2),
        cardColor: Color(0xFFF2CB05),
        shadowColor: Color(0xFFF2CB05),
        dialogBackgroundColor: Color(0xFFF2CB05),
        highlightColor: Color(0xFF0D1C26),
        dividerColor: Colors.white,
        focusColor: Colors.white,
        scaffoldBackgroundColor: Color(0xffF2F2F2),
        hintColor: Color(0xFF1A8E58),
        hoverColor: Color(0xFFD91A2A),

        fontFamily: "Nexa3",
        unselectedWidgetColor: Colors.white, // checkbox border rengi için kullandım.
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF0D1C26),
        canvasColor: Color(0xffF2F2F2),
        secondaryHeaderColor: Color(0xFFF2CB05),
        indicatorColor: Color(0xFF1C2B35),
        splashColor: Color(0xFF1C2B35),
        cardColor:  Color(0xFF0D1C26),
        shadowColor: Color(0xFF1C2B35),
        dialogBackgroundColor: Color(0xffF2F2F2),
        highlightColor: Color(0xFF1C2B35),
        focusColor: Color(0xFF1C2B35),
        scaffoldBackgroundColor: Color(0xFF0D1C26),
        dividerColor: Color(0xFF0D1C26),
        hintColor: Color(0xFF1C2B35),
        hoverColor: Color(0xFF1C2B35),
        fontFamily: "Nexa3",
      ),
      themeMode: readSettings.DarkMode == 0 ? ThemeMode.light : ThemeMode.dark,
      home: const base_BKA(),
    );
  }
}



