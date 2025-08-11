import 'package:butcetakip/classes/language.dart';

import 'package:butcetakip/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/material_color.dart';

class AddAppBar extends ConsumerWidget implements PreferredSizeWidget {
  late int addDataMode;
  AddAppBar({Key? key,required this.addDataMode}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);
  CustomColors renkler = CustomColors();
  Widget build(BuildContext context, WidgetRef ref) {
    var read = ref.read(bottomNavBarRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    var size = MediaQuery.of(context).size;
    String getTitleText(){
      if(addDataMode == 0){
        return translation(context).addIncomeExpensesTitle;
      }else if(addDataMode == 1){
          return translation(context).editTitle;
      }else{
        return translation(context).addAgainTitle;
      }
    }
    String getIconPath(){
      if(addDataMode == 0){
        return "assets/icons/add.png";
      }else if(addDataMode == 1){
        return "assets/icons/pencil.png";
      }else{
        return "assets/icons/swap.png";
      }
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: size.width,
        height: 60,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                height: 59,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: const Color(0xff0D1C26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(100),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 22),
                    child: Text(
                      getTitleText(),
                      style: const TextStyle(
                        height: 1,
                        fontFamily: 'FontBold',
                        fontSize: 20,
                        color: Color(0xFFE9E9E9),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 4,
              top: -4,
              child: Image.asset(
                getIconPath(),
                height: 48,
                width: 48,
                color: renkler.yaziRenk.withOpacity(0.1),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: SizedBox(
                height: 60,
                child: Container(
                  width: 60,
                  decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.2,
                            blurRadius: 1,
                            offset: const Offset(-1, -1)
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                        topLeft: Radius.circular(100),
                      )),
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 1.0),
                    iconSize: 60,
                    icon: Image.asset(
                      "assets/icons/remove.png",
                      height: 26,
                      width: 26,
                      color: renkler.arkaPlanRenk,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      if(addDataMode == 0){
                        // aynı sayfayı tekrar setle
                        return;
                      }
                      read.goToHome();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}