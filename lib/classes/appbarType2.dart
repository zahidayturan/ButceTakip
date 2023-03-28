import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/constans/TextPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod_management.dart';

class appbarType2 extends ConsumerWidget implements PreferredSizeWidget {
  const appbarType2({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(80);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readNavBar = ref.read(botomNavBarRiverpod);
    var readDB = ref.read(databaseRiverpod);
    var read = ref.read(AppBarTypeProvider) ;
    var size = MediaQuery.of(context).size ;
    CustomColors renkler = CustomColors();
    ref.watch(databaseRiverpod).status;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 0,bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height:55,
              width: size.width - 80,
              child: DecoratedBox(
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                    color: readDB.status == "+"
                        ? Colors.green
                        : Colors.red
                  ) ,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Textmod("${readDB.Date}", renkler.YaziRenk, 30),
                    Textmod("İŞLEM DETAYLARI", renkler.YaziRenk, 13 ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: renkler.koyuuRenk,
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                    ),
                    onPressed:() {
                     readNavBar.setCurrentindex(0);
                     Navigator.of(context).pop();
                      },
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
