import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';

class pageAppbar extends StatelessWidget implements PreferredSizeWidget {
  const pageAppbar({Key? key}) : super(key: key);
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    return SizedBox(
      height: 70,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: renkler.koyuuRenk
        ),
      ),
    );
  }


}
