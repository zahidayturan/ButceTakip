import 'package:flutter/material.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';

class AppBarStatistics extends StatelessWidget implements PreferredSizeWidget{
  AppBarStatistics({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  var renkler = CustomColors();

  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: renkler.koyuuRenk,
      toolbarHeight: 65,
      leadingWidth: 70,

      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(100,100),
          )
      ),

      leading: Container( // home butonunun bulunduğu kısım
        decoration: BoxDecoration(
          color: renkler.sariRenk,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: (
              IconButton(
                  onPressed: () {Navigator.of(context).pop();},
                  icon: Icon(
                    Icons.home_outlined,
                    size: 50,
                  )
              )
          ),
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
        const SizedBox(width: 5),
      ],
    );
  }



}