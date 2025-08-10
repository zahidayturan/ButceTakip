import 'package:flutter/material.dart';

class TextMod extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;

  const TextMod(this.text, this.color, this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
          text,
          style: TextStyle(
            fontFamily: "FontMedium",
            color: color,
            fontSize: size,
            //fontWeight: FontWeight.w900,
          ),
      );
  }
}
