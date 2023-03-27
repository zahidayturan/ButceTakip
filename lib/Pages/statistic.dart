import 'package:butcekontrol/Pages/Home.dart';
import 'package:butcekontrol/classes/appbar.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class statistic extends ConsumerWidget {
  const statistic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var read = ref.read(databaseRiverpod);
    return Scaffold(
      appBar:  appbarCustom(),
      body:  Column(
        children: [
          ElevatedButton(
            onPressed: () => read.insertDataBase("gider", "Giyim", "Nakit", 0 , 20.0, "Zahidin dogum gunu harcamaları","16.08.2023"),
            child: Text("ekle"),
          ),
          ElevatedButton(
            onPressed: () => read.Delete(),
            child: Text("sil"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),)),
            child: Text("don"),
          ),
        ],
      ),
    );
  }
}
