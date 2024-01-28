import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAppBar extends ConsumerWidget implements PreferredSizeWidget {
  late int addDataMode;
  AddAppBar({Key? key,required this.addDataMode}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);
  CustomColors renkler = CustomColors();
  Widget build(BuildContext context, WidgetRef ref) {
    var read = ref.read(botomNavBarRiverpod);
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
                        fontFamily: 'Nexa4',
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
              right: 30,
              top: 0,
              child: SizedBox(
                height: 42,
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) async {
                    await _showPopupMenu(details.globalPosition,context,ref);
                  },
                  child: Container(
                    width: 72,
                    decoration: BoxDecoration(
                        color: Theme.of(context).focusColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(1),
                              spreadRadius: 0.8,
                              blurRadius: 1,
                              offset: const Offset(-2, 0)
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                          topLeft: Radius.circular(100),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Icon(
                        Icons.swap_vert_rounded,
                        color: Theme.of(context).canvasColor,
                        size: 38,
                      ),
                    ),
              ),
                ),
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
                      read.setCurrentindex(addDataMode == 0 ? read.current! : 0);
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

  _showPopupMenu(Offset offset,BuildContext context,WidgetRef ref) async {
    double left = offset.dx;
    double top = offset.dy;
    var readSettings = ref.read(settingsRiverpod);
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top+12, 12, 0),
      color: Theme.of(context).primaryColor,
      shadowColor: Theme.of(context).primaryColor,
      items: [
        PopupMenuItem<String>(
          child: const Text('Tablo Görünümü'), value: 'Tablo',onTap: (){
          readSettings.setAddDataType(0);
          readSettings.setisuseinsert();
          ref.read(addDataRiverpod).pageViewController.animateToPage(readSettings.addDataType!, duration: Duration(milliseconds: 500), curve: Curves.linear);
          },),
        PopupMenuItem<String>(
          child: const Text('Liste Görünümü'), value: 'Liste',onTap: (){
          readSettings.setAddDataType(1);
          readSettings.setisuseinsert();
          ref.read(addDataRiverpod).pageViewController.animateToPage(readSettings.addDataType!, duration: Duration(milliseconds: 500), curve: Curves.linear);
        },),
      ],
      elevation: 8.0,
    );
  }
}