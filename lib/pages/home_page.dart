import 'package:butcekontrol/classes/app_bar.dart';
import 'package:butcekontrol/classes/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../UI/monthly_info.dart';
import '../UI/general_info.dart';
import '../UI/daily_info.dart';
import '../riverpod_management.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readNavBar = ref.read(botomNavBarRiverpod);
    readNavBar.currentColor = const Color(0xffF2F2F2);
    return Scaffold(
      //backgroundColor: Color(0xffF2F2F2),
      appBar: AppBarCustom(),
      bottomNavigationBar: null,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Generalinfo(),
          Aylikinfo(),
          SizedBox(height: 4),
          GunlukInfo(),
        ],
      ),
    );
  }
}

