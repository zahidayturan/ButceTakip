import 'package:butcekontrol/Pages/Home.dart';
import 'package:butcekontrol/classes/appbar.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class statistic extends ConsumerWidget {
  const statistic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readdb = ref.read(databaseRiverpod);
    var readnvbar = ref.read(botomNavBarRiverpod);
    return Scaffold(
      appBar:  appbarCustom(),
      body:  Column(
        children: [
          ElevatedButton(
            onPressed: () => readdb.insertDataBase("Gelir", "Giyim", "Nakit", 0 , 30.0, "Zahidin dogum gunu harcamaları","16.02.2023"),
            child: Text("ekle"),
          ),
          ElevatedButton(
            onPressed: () => readdb.Delete(),
            child: Text("sil"),
          ),
          ElevatedButton(
            onPressed: () {
              readnvbar.setCurrentindex(0);
            },
            child: Text("don"),
          ),
        ],
      ),
    );
  }
}
