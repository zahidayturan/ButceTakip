import 'package:butcetakip/riverpod_management.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/base_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();

  final container = ProviderContainer();
  final firestoreAppInfo = await container.read(firestoreServiceProvider).getAppInfo();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
      ],
      child: BaseApp(
        showBTA: prefs.getBool("showBTA") ?? false,
        appInfo: firestoreAppInfo,
      ),
    ),
  );
}