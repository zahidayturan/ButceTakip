import 'package:flutter/material.dart';

class TextMod extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;

  const TextMod(this.text, this.color, this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
          text,
          style: TextStyle(
            fontFamily: "Nexa3",
            color: color,
            fontSize: size,
            //fontWeight: FontWeight.w900,
          ),
      );
  }
}
/*
  Arkadaşlar bu class tamamen kod fazlalığını ortadan kaldırmak için yazılmıştır text parametrelini oto olarak bunu kulanabilirsiniz.

 */