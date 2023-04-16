import 'package:butcekontrol/classes/navBar.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';

class versionshelp extends StatelessWidget {
  const versionshelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    return Container(
      color: renkler.koyuuRenk ,
        child: SafeArea(
            child: Scaffold(
              bottomNavigationBar: navBar(),
            )
        )
    );
  }
}
