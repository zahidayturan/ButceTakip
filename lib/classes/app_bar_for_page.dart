import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constans/text_pref.dart';
import '../riverpod_management.dart';

class AppBarForPage extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  const AppBarForPage({Key? key, required this.title}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var read2 = ref.read(botomNavBarRiverpod);
    var readsetting = ref.read(settingsRiverpod);
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return SizedBox(
      width: size.width,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              height: 60,
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                    color: Color(0xff0D1C26),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                    )),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              height: 60,
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100),
                      topRight: Radius.circular(100),
                    )),
              ),
            ),
          ),
          Positioned(
            left: 2,
            top: 5,
            child: IconButton(
              padding: const EdgeInsets.only(right: 0),
              iconSize: 48,
              icon: title == translation(context).helpTitle
                  || title == translation(context).helpTitle2
                  || title == translation(context).settingsTitle
                  || title == translation(context).contactUsTitle
                  || title == translation(context).backupTitle
                  || title == translation(context).loginPasswordTitle
                  || title == translation(context).myAssets
              ?Directionality(
                textDirection: TextDirection.ltr,
                child: Icon(
                  Icons.arrow_circle_left_outlined,
                  color: renkler.yaziRenk,
                  size: 40,
                ),
              )
                  :Icon(
                Icons.home_rounded,
                color : renkler.yaziRenk,
                size: 40,
              ),
              highlightColor: Theme.of(context).indicatorColor,
              onPressed: () async {
                if(title == translation(context).helpTitle || title == translation(context).settingsTitle || title == translation(context).contactUsTitle || title == translation(context).backupTitle || title == translation(context).helpTitle2 || title == translation(context).myAssets){
                  Navigator.of(context).pop();
                }else if(title == translation(context).loginPasswordTitle) {
                  if(readsetting.isPassword == 1 && readsetting.Password == "null") {
                    bool confirm = await showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(
                            backgroundColor: renkler.koyuuRenk,
                            shadowColor: Theme.of(context).highlightColor,
                            title: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber,
                                  color: Theme.of(context).disabledColor,
                                  size: 35,
                                ),
                                const SizedBox(width: 20),
                                TextMod(translation(context).warning, Colors.white, 18),
                              ],
                            ),
                            content: TextMod(translation(context).youHaveNotCreatedAnyPasswordWarning, Colors.white, 15),
                            actions: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20) ,
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  color: Theme.of(context).disabledColor,
                                  margin: const EdgeInsets.all(5),
                                  child:  InkWell(
                                      onTap: () => Navigator.pop(context, false),
                                      child: SizedBox(
                                          child: Center(
                                              child: TextMod(translation(context).yes, renkler.koyuuRenk, 16)
                                          )
                                      )
                                  ) ,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20) ,
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  color: Theme.of(context).disabledColor,
                                  margin: const EdgeInsets.all(5),
                                  child:  InkWell(
                                      onTap: () {
                                        Navigator.pop(context, true);
                                        readsetting.setPasswordMode(false);
                                        readsetting.setisuseinsert();
                                      },
                                      child: SizedBox(
                                          child: Center(
                                              child: TextMod(translation(context).no, renkler.koyuuRenk, 16)
                                          )
                                      )
                                  ) ,
                                ),
                              ),

                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                    );
                    // Onaylandıysa sayfadan çık
                    if (confirm == true) {
                      Navigator.pop(context);
                    }
                  }else{
                    Navigator.pop(context, true);
                  }
                }
                else{
                  read2.setCurrentindex(0);
                }
                //Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'NEXA4',
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*
Positioned(
              right: 20,
              top: 20,
              child: Text(
                title,
                style: const TextStyle(
                  height: 1,
                  color: Colors.white,
                  fontFamily: 'NEXA4',
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
 */

/*
icon: title == translation(context).helpTitle
                    || title == translation(context).helpTitle2
                    || title == translation(context).settingsTitle
                    || title == translation(context).contactUsTitle
                    || title == translation(context).backupTitle
                    || title == translation(context).loginPasswordTitle
                  if(title == translation(context).helpTitle || title == translation(context).settingsTitle || title == translation(context).contactUsTitle || title == translation(context).backupTitle || title == translation(context).helpTitle2){
                  }else if(title == translation(context).loginPasswordTitle) {
                    if(readsetting.isPassword == 1 && readsetting.Password == "null") {
                              content:  TextMod(translation(context).youHaveNotCreatedAnyPasswordWarning, Colors.white, 15),
                                                child: TextMod(translation(context).yes, renkler.koyuuRenk, 16)
                                ),
 */