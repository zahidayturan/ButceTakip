import 'package:butcetakip/features/home/widgets/home_header_body.dart';
import 'package:butcetakip/features/home/widgets/home_header_nav.dart';
import 'package:butcetakip/features/introduction/introduction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: null,
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HomeHeaderNav(),
              HomeHeaderBody(),
              SizedBox(height: 14),
              Text("Ana Sayfa"),
              TextButton(onPressed: () {
                goIntroductionPage(context);
              }, child: Text("Karşılama Sayfasına Git"))
            ],
        )),
      ),
    );
  }
}

