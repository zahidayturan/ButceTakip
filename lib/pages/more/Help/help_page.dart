import 'package:butcekontrol/pages/more/Help/communicate.dart';
import 'package:butcekontrol/pages/more/Help/help_calculator.dart';
import 'package:butcekontrol/pages/more/Help/help_calender.dart';
import 'package:butcekontrol/pages/more/Help/help_footer.dart';
import 'package:butcekontrol/pages/more/Help/help_home_page.dart';
import 'package:butcekontrol/pages/more/Help/help_statistic.dart';
import 'package:butcekontrol/pages/more/Help/versions_help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../classes/app_bar_for_page.dart';
import '../../../classes/nav_bar.dart';
import '../../../constans/material_color.dart';

class HelpCenter extends ConsumerStatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  ConsumerState<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends ConsumerState<HelpCenter> {
  bool customicom = false ;
  CustomColors renkler = CustomColors();
  double heigthsssfirst = 30;
  double h2 = 30 ;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size ;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        bottomNavigationBar: const NavBar(),
        appBar: const AppBarForPage(title: "YARDIM"),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom:  8.0),
                child: Container(
                  color: renkler.koyuuRenk,
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: size.width/10,),
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
                                    transitionDuration: const Duration(milliseconds: 1),
                                    pageBuilder: (context, animation, nextanim) =>  VersionsHelp(),
                                    reverseTransitionDuration: const Duration(milliseconds: 1),
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
                                  "Android 1.0v Update(21.04.2023)"
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
                          const SizedBox(height: 10,),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) => const HelpHomePage(),
                                  reverseTransitionDuration: const Duration(milliseconds: 1),
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
                          const Divider(color: Colors.black, thickness: 1,),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) => const HelpStatisic(),
                                  reverseTransitionDuration: const Duration(milliseconds: 1),
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
                          const Divider(color: Colors.black, thickness: 1,),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) => const HelpCalender(),
                                  reverseTransitionDuration: const Duration(milliseconds: 1),
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
                          const Divider(color: Colors.black, thickness: 1,),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 1),
                                  pageBuilder: (context, animation, nextanim) => const HelpCalculator(),
                                  reverseTransitionDuration: const Duration(milliseconds: 1),
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
                          const Divider(color: Colors.black, thickness: 1,),
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
                                color: const Color(0xffDDDCDC),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ExpansionTile(

                              title: const Text("Uygulamam aniden kapanıyor."),
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
                              tilePadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                      "Bazı durumlarda beklenmeyen sonuçlarla\nkarşılaşabiliyoruz. Böyle bir "
                                          "durumda yapmanız gereken güncellemeleri kontrol etmektir. Eğer hala "
                                          "sorun devam ediyorsa lütfen geri bildirim bırakınız.\n"
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
                                color: const Color(0xffDDDCDC),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ExpansionTile(

                              title: const Text("Kayıtlarım aniden gitti ne yapmam gerekiyor?"),
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
                              tilePadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    "Uygulama son güncelleme ile gelen bazı yenilikler dolayısıyla "
                                        "veritabanının güncellenmesi noktasında eski sürümün desteklenmemesi "
                                        "bu soruna yol açmış olabilir teknik ekibimiz bu durumla karşılaşmamak "
                                        "için version güncellenmesinde yedekleme işlemini gerçekleştirmektedirler "
                                        "yinede geri bildirim bırakabilirsiniz.\n",
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
                                color: const Color(0xffDDDCDC),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ExpansionTile(
                              title: const Text("Size Ulaşmak istiyorum?"),
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
                              tilePadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                                              transitionDuration: const Duration(milliseconds: 1),
                                              pageBuilder: (context, animation, nextanim) => const Communicate(),
                                              reverseTransitionDuration: const Duration(milliseconds: 1),
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
                                      const SizedBox(height: 10),
                                    ],
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
              SizedBox(height: 20,),
              helpFooter(context),
            ],
          ),
        ),
      ),
    );
  }
}