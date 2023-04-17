import 'package:butcekontrol/Pages/more/Help/Communicate.dart';
import 'package:butcekontrol/Pages/more/Help/HelpCalculator.dart';
import 'package:butcekontrol/Pages/more/Help/HelpCalender.dart';
import 'package:butcekontrol/Pages/more/Help/HelpHomePage.dart';
import 'package:butcekontrol/Pages/more/Help/HelpStatistic.dart';
import 'package:butcekontrol/Pages/more/Help/VersionsHelp.dart';
import 'package:butcekontrol/classes/appBarForPage.dart';
import 'package:butcekontrol/classes/navBar.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class helpCenter extends ConsumerStatefulWidget {
  const helpCenter({Key? key}) : super(key: key);

  @override
  ConsumerState<helpCenter> createState() => _helpCenterState();
}

class _helpCenterState extends ConsumerState<helpCenter> {
  bool customicom = false ;
  CustomColors renkler = CustomColors();
  double heigthsssfirst = 30;
  double h2 = 30 ;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size ;
    var readNavBar = ref.read(botomNavBarRiverpod);
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffF2F2F2),
          bottomNavigationBar: navBar(),
          appBar: AppBarForPage(title: "YARDIM"),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Container(
                    color: renkler.koyuuRenk,
                    height: 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: size.width/10),
                        Image.asset(
                          "assets/image/LogoBkaShort.png",
                          height: 60,
                          width: 60,
                        ),
                        const Text(
                          "Help Center",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Nexa3",
                              fontSize: 25
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start  ,
                            children: const [
                              Text(
                                "Yenilikler",
                                style: TextStyle(
                                  fontFamily: "Nexa3",
                                  fontSize: 26,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: Duration(milliseconds: 1),
                                      pageBuilder: (context, animation, nextanim) => versionshelp(),
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
                                child: const Text(
                                    "Android 1.0v Update(17.04.2023)"
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Divider(
                              color: Colors.black,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),//news
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Başlarken",
                          style:TextStyle(
                            fontSize: 25,
                            fontFamily: "Nexa3",
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 1.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(milliseconds: 1),
                                    pageBuilder: (context, animation, nextanim) => helpHomePage(),
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
                              child: const Text(
                                "Ana Sayfa",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontFamily: "Nexa3",
                                ),
                              ),
                            ),
                            Divider(color: Colors.black, thickness: 1,),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(milliseconds: 1),
                                    pageBuilder: (context, animation, nextanim) => helpStatisic(),
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
                              child: const Text(
                                "İstatistik Sayfası",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontFamily: "Nexa3",
                                ),
                              ),
                            ),
                            Divider(color: Colors.black, thickness: 1,),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(milliseconds: 1),
                                    pageBuilder: (context, animation, nextanim) => helpCalender(),
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
                              child: const Text(
                                "Takvim Sayfası",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontFamily: "Nexa3",
                                ),
                              ),
                            ),
                            Divider(color: Colors.black, thickness: 1,),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(milliseconds: 1),
                                    pageBuilder: (context, animation, nextanim) => helpCalculator(),
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
                              child: const Text(
                                "Hesap Makinesi",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontFamily: "Nexa3",
                                ),
                              ),
                            ),
                            Divider(color: Colors.black, thickness: 1,),
                          ],
                        ),
                      ), //get started
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sıkça Sorulan Sorular",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nexa3",
                              fontSize: 25
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 3),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color(0xffDDDCDC),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: ExpansionTile(

                                title: Text("Uygulamam aniden kapanıyor."),
                                trailing: customicom ? const Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 30,
                                )
                                    : const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 30,
                                ),
                                onExpansionChanged: (bool expanded) {
                                  setState(() => customicom = expanded);
                                },
                                tilePadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Container(
                                        child: const Text(
                                            "Bazı durumlarda beklenmeyen sonuçlarla\nkarşılaşabiliyoruz. Böyle bir"
                                                "durumda yapmanız gereken güncellemeleri kontrol etmektir. Eğer hala "
                                                "sorun devam ediyorsa lütfen geri bildirim bırakınız.\n"
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color(0xffDDDCDC),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: ExpansionTile(

                                title: Text("Kayıtlarım aniden gitti ne yapmam gerekiyor?"),
                                trailing: customicom ? const Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 30,
                                )
                                    : const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 30,
                                ),
                                onExpansionChanged: (bool expanded) {
                                  setState(() => customicom = expanded);
                                },
                                tilePadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Container(
                                        child: const Text(
                                          "Uygulama son güncelleme ile gelen bazı yenilikler dolayısıyla "
                                              "veritabanının güncellenmesi noktasında eski sürümün desteklenmemesi "
                                              "bu soruna yol açmış olabilir teknik ekibimiz bu durumla karşılaşmamak"
                                              "için version güncellenmesinde yedekleme işlemini gerçekleştirmektedirler "
                                              "yinede geri bildirim bırakabilirsiniz.\n",
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 3),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color(0xffDDDCDC),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: ExpansionTile(
                                title: Text("Size Ulaşmak istiyorum?"),
                                trailing: customicom ? const Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 30,
                                )
                                    : const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 30,
                                ),
                                onExpansionChanged: (bool expanded) {
                                  setState(() => customicom = expanded);
                                },
                                tilePadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Uygulamamızda iletişim kısmındaki mail veya Linkedin adreslerimiz üzerinden bizlere ulaşabilirsiniz.\n",
                                            ),
                                            InkWell(
                                              onTap: () {
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
                                              child: SizedBox(
                                                height: 30,
                                                width: 100,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: renkler.koyuuRenk,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "İLETİŞİM",
                                                      style: TextStyle(
                                                          fontFamily: "Nexa2",
                                                          fontSize: 16,
                                                          color: Colors.amber
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )// SSS
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}