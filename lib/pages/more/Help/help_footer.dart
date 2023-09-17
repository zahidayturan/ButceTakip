import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';


Widget helpFooter(BuildContext context) {
  var renkler = CustomColors();
  var size = MediaQuery.of(context).size;
  return Container(
    height: size.height / 8,
    decoration: BoxDecoration(
        color: renkler.koyuuRenk,
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: Offset(0, -2)
        )
      ]
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Divider(
            thickness: 2.5,
            color: Theme.of(context).disabledColor,
          ),
        ), // Dividerin bulundugu kisim
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "FezaiTech ${translation(context).helpCenter}",
                style: TextStyle(
                  color: renkler.yaziRenk,
                  fontFamily: 'Nexa3',
                  fontSize: 15,
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
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Copyright ©2023",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Nexa3',
                  color: renkler.yaziRenk,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
