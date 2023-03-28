import 'package:butcekontrol/classes/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../UI/Aylikinfo.dart';
import '../UI/Generalinfo.dart';
import '../UI/GunlukInfo.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: appbarCustom(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Generalinfo(),
          Aylikinfo(),
          GunlukInfo(),
        ],
      ),
    );
  }
}

