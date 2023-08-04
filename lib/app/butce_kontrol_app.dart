import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';
import 'base_BKA.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButceKontrolApp extends ConsumerWidget {
  const ButceKontrolApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      locale: readSettings.localChanger(),

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



