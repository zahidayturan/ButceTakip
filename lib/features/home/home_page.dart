import 'package:butcetakip/features/introduction/introduction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_icons.dart';
import '../../core/constants/icon_mod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void goIntroductionPage(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("showBTA", false);

    if (!context.mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const IntroductionPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: null,
      resizeToAvoidBottomInset: false,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconMod(AppIcons.user),
          Text("Ana Sayfa"),
          TextButton(onPressed: () {
            goIntroductionPage(context);
          }, child: Text("Karşılama Sayfasına Git"))
        ],
      )),
    );
  }
}

