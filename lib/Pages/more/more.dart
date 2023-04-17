import 'package:butcekontrol/Pages/more/Backup.dart';
import 'package:butcekontrol/Pages/more/Help/Communicate.dart';
import 'package:butcekontrol/Pages/more/Help/helpPage.dart';
import 'package:butcekontrol/Pages/more/Password.dart';
import 'package:butcekontrol/Pages/more/settings.dart';
import 'package:butcekontrol/classes/appBarForPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/constans/TextPref.dart';

import '../../riverpod_management.dart';
import 'Help/PasswordSplash.dart';

class More extends ConsumerWidget {
  More({Key? key}) : super(key: key);
  final renkler = CustomColors();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //var readDB = ref.read(databaseRiverpod);
    var readSetting = ref.read(settingsRiverpod);
    var size = MediaQuery.of(context).size;
    //var readNavBar = ref.read(botomNavBarRiverpod);
    ref.watch(settingsRiverpod).isuseinsert;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          appBar: AppBarForPage(title: "DİĞER İŞLEMLER"),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(  // 9 adet butonun bulundugu yer, her uc buton bir Row`a yerlestirildi.
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly, conteınerlar fixed sizes oldukları için bu kodun bir etkisi olmuyor
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) => settings(),
                                  reverseTransitionDuration: Duration(milliseconds: 1),
                                  transitionsBuilder: (context, animation, nexttanim, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  color: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.settings, color: renkler.YaziRenk, size: 35),
                                  Textmod("Ayarlar", renkler.YaziRenk, 10),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: size.width / 15),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) => helpCenter(),
                                  reverseTransitionDuration: Duration(milliseconds: 1),
                                  transitionsBuilder: (context, animation, nexttanim, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  color: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.question_mark, color: renkler.YaziRenk, size: 35),
                                  Textmod("Yardım", renkler.YaziRenk, 10),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: size.width / 15),
                          /*
                          InkWell(
                            onTap: () => print("Theme"),
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  color: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.sunny, color: renkler.YaziRenk, size: 35),
                                  Textmod("Tema", renkler.YaziRenk, 10),
                                ],
                              ),
                            ),
                          ),
                           */
                          InkWell(
                            onTap: () {
                              if(readSetting.isPassword == 1 && readSetting.Password != "null"){
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(milliseconds: 1),
                                    pageBuilder: (context, animation, nextanim) => passwordSplash(mode: "admin"),
                                    reverseTransitionDuration: Duration(milliseconds: 1),
                                    transitionsBuilder: (context, animation, nexttanim, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              }else {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(milliseconds: 1),
                                    pageBuilder: (context, animation, nextanim) =>
                                        passwordPage(),
                                    reverseTransitionDuration:
                                    Duration(milliseconds: 1),
                                    transitionsBuilder:
                                        (context, animation, nexttanim, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  color: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ref.read(settingsRiverpod).isPassword == 1
                                      ? Icon(Icons.lock, color: renkler.YaziRenk, size: 35)
                                      : Icon(Icons.lock_open, color: renkler.YaziRenk, size: 35),
                                  Textmod("Giriş Şifresi", renkler.YaziRenk, 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.width / 15,),

                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) => backUp(),
                                  reverseTransitionDuration: Duration(milliseconds: 1),
                                  transitionsBuilder: (context, animation, nexttanim, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  color: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.download, color: renkler.YaziRenk, size: 35),
                                  Textmod("Verileri İndir", renkler.YaziRenk, 10),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: size.width / 15),
                          InkWell(
                            onTap: () {
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => communicate()));
                              Navigator.push(
                              context,
                              PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1),
                              pageBuilder: (context, animation, nextanim) => communicate(),
                              reverseTransitionDuration: Duration(milliseconds: 1),
                              transitionsBuilder: (context, animation, nexttanim, child) {
                              return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  color: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.message, color: renkler.YaziRenk, size: 35),
                                  Textmod("İletişim", renkler.YaziRenk, 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      /*
                      SizedBox(height: size.width / 15,),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => print("Suggestion"),
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  color: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.lightbulb, color: renkler.YaziRenk, size: 35),
                                  Textmod("Öneri", renkler.YaziRenk, 10),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: size.width / 15),
                          InkWell(
                            onTap: () => print("Evaluation"),
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  color: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.star, color: renkler.YaziRenk, size: 35),
                                  Textmod("Değerlendirme", renkler.YaziRenk, 10),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: size.width / 15),
                          InkWell(
                            onTap: () => print("Recommend"),
                            child: Container(
                              height: size.height / 9,
                              width: size.height / 9,
                              decoration: BoxDecoration(
                                  color: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.recommend, color: renkler.YaziRenk, size: 35),
                                  Textmod("Tavsiye Et", renkler.YaziRenk, 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                       */
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/image/icon_BKA/LOGOBKA-4.png",
                        height: 70,
                      ),
                      SizedBox(height: 2,),
                      Textmod("version 1.0", renkler.koyuuRenk, 13),
                      SizedBox(height: 2,),
                      Textmod("Osmanlı Torunları", renkler.koyuuRenk, 10),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}