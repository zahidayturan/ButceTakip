import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';


Widget helpFooter(BuildContext context) {
  var renkler = CustomColors();
  var size = MediaQuery.of(context).size;
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
                  color: renkler.yaziRenk,
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
