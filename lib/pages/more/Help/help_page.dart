import 'package:butcekontrol/pages/more/Help/help_backup.dart';
import 'package:butcekontrol/pages/more/communicate.dart';
import 'package:butcekontrol/pages/more/Help/help_calculator.dart';
import 'package:butcekontrol/pages/more/Help/help_calender.dart';
import 'package:butcekontrol/pages/more/Help/help_footer.dart';
import 'package:butcekontrol/pages/more/Help/help_home_page.dart';
import 'package:butcekontrol/pages/more/Help/help_statistic.dart';
import 'package:butcekontrol/pages/more/Help/versions_help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../classes/app_bar_for_page.dart';
  import '../../../classes/language.dart';
import '../../../constans/material_color.dart';

class HelpCenter extends ConsumerStatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  ConsumerState<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends ConsumerState<HelpCenter> {
  bool customicom1 = false ;
  bool customicom2 = false ;
  bool customicom3 = false ;

  CustomColors renkler = CustomColors();
  double heigthsssfirst = 30;
  double h2 = 30 ;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size ;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        appBar: AppBarForPage(title: translation(context).helpTitle),
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
                      Text(
                        translation(context).helpCenter,
                        style: const TextStyle(
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
                padding: const EdgeInsets.symmetric(horizontal:20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start  ,
                          children: [
                            Text(
                              translation(context).whatsNew,
                              style: const TextStyle(
                                height: 1,
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
                                    pageBuilder: (context, animation, nextanim) =>  const VersionsHelp(),
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
                                  "Android 1.1.1v Update(3.06.2023)"
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
                    Row(
                      children: [
                        Text(
                          translation(context).guideline,
                          style:const TextStyle(
                            height: 1,
                            fontSize: 25,
                            fontFamily: "Nexa3",
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20.0, vertical:  10.0),
                      child: SizedBox(
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                  child: SizedBox(
                                    height: 45,
                                    width: (size.width - 100) / 3,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: renkler.koyuuRenk,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 3,
                                                blurRadius: 7,
                                                offset: Offset(3, 3)
                                            ),
                                          ]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(bottom: 8.0),
                                              child: Icon(
                                                Icons.home,
                                                color: Color(0xffF2F2F2),
                                                size: 22,
                                              ),
                                            ),
                                            const SizedBox(width: 1),
                                            FittedBox(
                                              child: Text(
                                                translation(context).homePage,
                                                style: const TextStyle(
                                                  height: 1,
                                                    color: Color(0xffF2F2F2),
                                                    fontSize: 11
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
                                  child: SizedBox(
                                    height: 45,
                                    width: (size.width - 100) / 3,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: renkler.koyuuRenk,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 3,
                                                blurRadius: 7,
                                                offset: Offset(3, 3)
                                            ),
                                          ]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(bottom: 8.0),
                                              child: Icon(
                                                Icons.pie_chart_rounded,
                                                color: Color(0xffF2F2F2),
                                                size: 22,
                                              ),
                                            ),
                                            const SizedBox(width: 1),
                                            FittedBox(
                                              child: Text(
                                                translation(context).statisticsPage,
                                                style: const TextStyle(
                                                  height: 1,
                                                    color: Color(0xffF2F2F2),
                                                    fontSize: 11
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
                                  child: SizedBox(
                                    height: 45,
                                    width: (size.width - 100) / 3,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: renkler.koyuuRenk,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 3,
                                                blurRadius: 7,
                                                offset: Offset(3, 3)
                                            ),
                                          ]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(bottom: 8.0),
                                              child: Icon(
                                                Icons.calendar_today,
                                                color: Color(0xffF2F2F2),
                                                size: 22,
                                              ),
                                            ),
                                            FittedBox(
                                              child: Text(
                                                translation(context).calendarPage,
                                                style: const TextStyle(
                                                  height: 1,
                                                    color: Color(0xffF2F2F2),
                                                    fontSize: 11
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
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
                                  child: SizedBox(
                                    height: 45,
                                    width: (size.width - 80) / 3,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: renkler.koyuuRenk,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 3,
                                                blurRadius: 7,
                                                offset: Offset(3, 3)
                                            ),
                                          ]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(bottom: 8.0),
                                              child: Icon(
                                                Icons.calculate,
                                                color: Color(0xffF2F2F2),
                                                size: 22,
                                              ),
                                            ),
                                            const SizedBox(width: 7),
                                            FittedBox(
                                              child: Text(
                                                translation(context).calculatorHelp,
                                                style: const TextStyle(
                                                  height: 1,
                                                    color: Color(0xffF2F2F2),
                                                    fontSize: 11
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration: const Duration(milliseconds: 1),
                                        pageBuilder: (context, animation, nextanim) => const HelpBacup(),
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
                                    height: 45,
                                    width: (size.width - 70) / 3,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: renkler.koyuuRenk,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: Offset(3, 3)
                                          ),
                                        ]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(bottom: 8.0),
                                              child: Icon(
                                                Icons.backup,
                                                color: Color(0xffF2F2F2),
                                                size: 22,
                                              ),
                                            ),
                                            const SizedBox(width: 7),
                                            FittedBox(
                                              child: Text(
                                                translation(context).backupSystem,
                                                style: const TextStyle(
                                                  height: 1,
                                                    color: Color(0xffF2F2F2),
                                                    fontSize: 11
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          translation(context).faq,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "Nexa3",
                              fontSize: 25
                          ),
                        ),
                      ],
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

                              title: Text(translation(context).appShutdown),
                              trailing: customicom1 ? const Icon(
                                Icons.keyboard_arrow_up,
                                size: 30,
                              )
                                  : const Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                              ),
                              onExpansionChanged: (bool expanded) {
                                setState(() => customicom1 = expanded);
                              },
                              tilePadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                      translation(context).answerOne
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

                              title: Text(translation(context).recordsGone),
                              trailing: customicom2 ? const Icon(
                                Icons.keyboard_arrow_up,
                                size: 30,
                              )
                                  : const Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                              ),
                              onExpansionChanged: (bool expanded) {
                                setState(() => customicom2 = expanded);
                              },
                              tilePadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    translation(context).answerTwo
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
                              title: Text(translation(context).iWantToContactYou),
                              trailing: customicom3 ? const Icon(
                                Icons.keyboard_arrow_up,
                                size: 30,
                              )
                                  : const Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                              ),
                              onExpansionChanged: (bool expanded) {
                                setState(() => customicom3 = expanded);
                              },
                              tilePadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          translation(context).answerThree,
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
                                          width: 120,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: renkler.koyuuRenk,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                translation(context).contactUsTitle,
                                                style: const TextStyle(
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
                    ), //SSS
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              helpFooter(context),
            ],
          ),
        ),
      ),
    );
  }
}