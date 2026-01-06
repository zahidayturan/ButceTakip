import 'package:butcetakip/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/text_pref.dart';

class IntroductionPage extends ConsumerWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextMod("Hoş Geldiniz", level: 'xl'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(introductionRiverpod).completeIntroAndNavigate(context);
              },
              child: const Text("Başla"),
            ),
          ],
        ),
      ),
    );
  }
}