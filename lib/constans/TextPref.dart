import 'package:flutter/material.dart';

class Textmod extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;

  const Textmod(this.text, this.color, this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
          text,
          style: TextStyle(
            fontFamily: "Nexa4",
            color: this.color,
            fontSize: this.size,
            fontWeight: FontWeight.w900,
          ),
      );
  }
}
/*
  Arkadaşlar bu class tamamen kod fazlalığını ortadan kaldırmak için yazılmıştır text parametrelini oto olarak bunu kulanabilirsiniz.

 */