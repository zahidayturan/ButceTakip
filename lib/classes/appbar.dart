import 'package:butcekontrol/UI/registerylistW.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class appbarCustom extends ConsumerWidget  implements  PreferredSizeWidget {
  const appbarCustom({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomColors renkler = CustomColors();
    return AppBar(
      backgroundColor: Color(0xFF0D1C26),
      title: RichText(
        text: const TextSpan(
          text: "Bütçe Kontrol",

          style: TextStyle(
            fontFamily: "Nexa",
            color: Color(0xFFFFFFFF),
            fontSize: 21,
          ),
          children: [
            TextSpan(
              text: "\nUYGULAMASI",
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
            showDialog(
              context: context,
              builder: (context) {
                return registeryListW();
              },
            );
          },
          icon: const Icon(
            Icons.bookmark_outlined,
            color: Color(0xFFFFFFFF),
            size: 30,
          ),
          constraints: BoxConstraints(maxWidth: 40),
          iconSize: 20.0,
        ),
        IconButton(
          onPressed:() => print("?"),
          icon: const Icon(
            Icons.question_mark,
            color: Color(0xFFFFFFFF),
            size: 30,
          ),
          constraints: BoxConstraints(maxWidth: 40),

        ),
        IconButton(
          onPressed:() => print("reset"),
          icon: const Icon(
            Icons.refresh,
            color: Color(0xFFFFFFFF),
            size: 30,
          ),
          constraints: BoxConstraints(maxWidth: 40),
        ),

        IconButton(
          onPressed:() => print("settings"),
          icon: const Icon(
            Icons.settings,
            color: Color(0xFFFFFFFF),
            size: 30,
          ),
          constraints: BoxConstraints(maxWidth: 40),
        ),
        const SizedBox(width: 5,),
      ],
    );
  }

}
/*
Row(   /// her bir kaydın oldugu satır
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children:  [
SizedBox(
height:  40,
width : 40 ,
child: DecoratedBox(
decoration: const BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.all(Radius.circular(40)),
),
child: Center(
child: Icon(
Icons.remove_red_eye,
color: renkler.sariRenk,
),
),
),
),
Text("İşlem kategorisi"),
const Text(
"189 TL",
style: TextStyle(
color:  Colors.green,
),
),
],
),

 */