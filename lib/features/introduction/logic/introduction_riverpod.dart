import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/base_home.dart';
import '../../../riverpod_management.dart';

class IntroductionRiverpod extends ChangeNotifier {
  final Ref ref;
  IntroductionRiverpod(this.ref);

  Future<void> completeIntroAndNavigate(BuildContext context) async {

    final prefs = ref.read(sharedPrefsProvider);
    await prefs.setBool("showBTA", true);
    final firestoreAppInfo = await ref.read(firestoreServiceProvider).getAppInfo();

    if (!context.mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BaseHome(
          showBTA: true,
          appInfo: firestoreAppInfo,
        ),
      ),
    );
  }
}