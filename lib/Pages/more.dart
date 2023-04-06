import 'package:butcekontrol/classes/appBarForPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/appbar.dart';

class More extends ConsumerWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Color(0xff0D1C26),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          appBar: AppBarForPage(title: "DİĞER İŞLEMLER"),
          body: Text("Diğer İşlemler"),
        ),
      ),
    );
  }
}
