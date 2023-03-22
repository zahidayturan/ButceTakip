import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/constans/TextPref.dart';
import 'package:flutter/material.dart';

class appbarType2 extends StatelessWidget implements PreferredSizeWidget {
  const appbarType2({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(80);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size ;
    CustomColors renkler = CustomColors();
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height:55,
            width: size.width - 80,
            child: DecoratedBox(
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                  color: Colors.green,
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Textmod("24 MART 2023", renkler.YaziRenk, 30),
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
                   Navigator.of(context).pop();

                    },
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
