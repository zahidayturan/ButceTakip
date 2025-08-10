import 'package:butcetakip/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/theme.dart';
import '../l10n/app_localizations.dart';
import 'base_home.dart';

class BaseApp extends ConsumerStatefulWidget {
  final bool showBTA;
  final Map<String, String>? appInfo;
  const BaseApp({super.key, required this.showBTA, required this.appInfo});

  @override
  ConsumerState<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends ConsumerState<BaseApp> {

  @override
  Widget build(BuildContext context) {
    ref.watch(settingsRiverpod).isuseinsert;
    var readSettings = ref.read(settingsRiverpod);
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1)),
          child: child!,
        );
      },

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: readSettings.localChanger(),

      debugShowCheckedModeBanner: false,
      title: "Bütçe Takip",

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: readSettings.DarkMode == 0 ? ThemeMode.light : ThemeMode.dark,

      home: BaseHome(showBTA: widget.showBTA,appInfo:widget.appInfo),
    );
  }
}



