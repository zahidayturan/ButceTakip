import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../classes/appBarForPage.dart';

class backUp extends ConsumerStatefulWidget {
  const backUp({Key? key}) : super(key: key);

  @override
  ConsumerState<backUp> createState() => _backUpState();
}

class _backUpState extends ConsumerState<backUp> {
  CustomColors renkler = CustomColors();
  String choice = "sanana" ;
  bool isopen = false ;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarForPage(title: "YEDEKLE"),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal:18, vertical: 8 ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Container(
                      height: 40,
                      width: size.width,
                      color: Color(0xffD9D9D9),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            const Text(
                              "Yedeklenme Durumu",
                              style: TextStyle(
                                fontFamily: "Nexa3",
                              ),
                            ),
                            Spacer(),
                            isopen ? Text("Açık", style: TextStyle(fontFamily: "Nexa3"),)
                                : Text("Kapalı", style: TextStyle(fontFamily: "Nexa3"),),
                            Switch(
                              value: isopen ,
                              onChanged: (bool value) {
                                setState(() {
                                  isopen = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ), /// Giriş şifresi
                ExpansionTile(
                    title: Text("Google Drive ile Yedekle"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
