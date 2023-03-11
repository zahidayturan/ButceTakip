import 'package:flutter/material.dart';

class appbarCustom extends StatelessWidget  implements  PreferredSizeWidget {
  const appbarCustom({Key? key}) : super(key: key);
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF0D1C26),
      title: RichText(
        text: const TextSpan(
            text: "Aylık Durum",
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 21,
            ),
            children: [
              TextSpan(
                text: "\n+248.40 ₺",
                style: TextStyle(
                    color: Color(0xFFF2CB05),
                ),
              ),
            ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              print("Kaydedilenler");
            },
            icon: const Icon(
              Icons.bookmark_outlined,
              color: Color(0xFFFFFFFF),
            ),
          iconSize: 20.0,
        ),
        IconButton(
            onPressed:() => print("?"),
            icon: const Icon(
              Icons.question_mark,
              color: Color(0xFFFFFFFF),
            )
        ),
        IconButton(
            onPressed:() => print("reset"),
            icon: const Icon(
              Icons.refresh,
              color: Color(0xFFFFFFFF),
            )
        ),

        IconButton(
            onPressed:() => print("settings"),
            icon: const Icon(
              Icons.settings,
              color: Color(0xFFFFFFFF),
            )
        ),
      ],
    );
  }

}
