import 'package:butcekontrol/classes/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../UI/Aylikinfo.dart';
import '../UI/Generalinfo.dart';
import '../UI/GunlukInfo.dart';
import '../riverpod_management.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readNavBar = ref.read(botomNavBarRiverpod);
    readNavBar.currentColor = Color(0xffF2F2F2);
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: appbarCustom(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Generalinfo(),
          Aylikinfo(),
          GunlukInfo(),
        ],
      ),
    );
  }
}

