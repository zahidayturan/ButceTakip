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
            color: this.color,
            fontSize: this.size
          ),
      );
  }
}
/*
  Arkadaşlar bu class tamamen kod fazlalığını ortadan kaldırmak için yazılmıştır text parametrelini oto olarak bunu kulanabilirsiniz.

 */