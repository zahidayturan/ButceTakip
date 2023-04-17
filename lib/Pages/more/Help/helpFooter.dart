import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';



Widget HelpFooter(BuildContext context) {
  var renkler = CustomColors();
  var size = MediaQuery.of(context).size ;
  print(size.height);
  return Container(
    color: renkler.koyuuRenk,
    height: size.height / 5.44,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            thickness: 2.5,
            color: renkler.sariRenk,
          ),
        ), // Dividerin bulundugu kisim
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "FezaiTech Help Center",
                style: TextStyle(
                  color: renkler.YaziRenk,
                  fontFamily: 'Nexa3',
                  fontSize: 16,
                ),

              ),
              Image.asset(
                "assets/image/LogoBkaShort.png",
                height: 40,
                width: 40,
              ),
            ],
          ),
        ), // fezai tech help center ve logo
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Copyright ©2023",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Nexa3',
                  color: renkler.YaziRenk,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
