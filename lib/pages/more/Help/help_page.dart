import 'package:butcekontrol/pages/more/Help/add_update_help.dart';
import 'package:butcekontrol/pages/more/Help/currency_help.dart';
import 'package:butcekontrol/pages/more/Help/help_assets.dart';
import 'package:butcekontrol/pages/more/Help/help_backup.dart';
import 'package:butcekontrol/pages/more/communicate.dart';
import 'package:butcekontrol/pages/more/Help/help_calculator.dart';
import 'package:butcekontrol/pages/more/Help/help_calender.dart';
import 'package:butcekontrol/pages/more/Help/help_footer.dart';
import 'package:butcekontrol/pages/more/Help/help_home_page.dart';
import 'package:butcekontrol/pages/more/Help/help_statistic.dart';
import 'package:butcekontrol/pages/more/Help/versions_help.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
    var readSetting = ref.read(settingsRiverpod);
  var darkMode = readSetting.DarkMode;
    var size = MediaQuery.of(context).size ;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: const Color(0xffF2F2F2),
        appBar: AppBarForPage(title: translation(context).helpTitle),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom:  14.0),
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    color: renkler.koyuuRenk,
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).highlightColor,
                      strokeAlign: BorderSide.strokeAlignOutside
                    ),
                    boxShadow: darkMode == 1 ? [
                      BoxShadow(
                        color: Colors.black54.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      )
                    ] : [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 2,
                          offset: const Offset(0, 2)
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4,left: 18,right: 18),
                        child: Text(
                          translation(context).helpCenter,
                          style: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontFamily: "Nexa4",
                              fontSize: 23
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Image.asset(
                          "assets/image/LogoBkaShort.png",
                          height: 44,
                          width: 44,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).highlightColor,
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 0.5,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ]
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4,left: 8,right: 8),
                              child: Text(
                                translation(context).guideline,
                                style:TextStyle(
                                  height: 1,
                                  fontSize: 22,
                                  fontFamily: "Nexa3",
                                  color: Theme.of(context).canvasColor,
                                ),
                              ),
                            ),
                            Expanded(child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                color: Theme.of(context).highlightColor,
                                boxShadow: darkMode == 1 ? [
                                  BoxShadow(
                                    color: Colors.black54.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  )
                                ] : [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 0.5,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2)
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                        const SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
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
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 36,
                                  width: size.width * .27,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: renkler.koyuuRenk,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:  [
                                          BoxShadow(
                                              color: Theme.of(context).indicatorColor,
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(3, 3)
                                          ),
                                        ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.home_rounded,
                                            color: Color(0xffF2F2F2),
                                            size: 22,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 2),
                                              child: Text(
                                                translation(context).homePage,
                                                style: const TextStyle(
                                                    height: 1,
                                                    color: Color(0xffF2F2F2),
                                                    fontSize: 11
                                                ),
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
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
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 36,
                                  width: size.width * .27,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: renkler.koyuuRenk,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context).indicatorColor,
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(3, 3)
                                          ),
                                        ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.equalizer_rounded,
                                            color: Color(0xffF2F2F2),
                                            size: 22,
                                          ),
                                          FittedBox(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 2),
                                              child: Text(
                                                translation(context).statisticsPage,
                                                style: const TextStyle(
                                                    height: 1,
                                                    color: Color(0xffF2F2F2),
                                                    fontSize: 11
                                                ),
                                                textAlign: TextAlign.center,
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
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 36,
                                  width: size.width * .27,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: renkler.koyuuRenk,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context).indicatorColor,
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(3, 3)
                                          ),
                                        ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.calendar_month_rounded,
                                            color: Color(0xffF2F2F2),
                                            size: 22,
                                          ),
                                          FittedBox(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 2),
                                              child: Text(
                                                translation(context).calendarPage,
                                                style: const TextStyle(
                                                    height: 1,
                                                    color: Color(0xffF2F2F2),
                                                    fontSize: 11
                                                ),
                                                textAlign: TextAlign.center,
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
                        ),
                        const SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(milliseconds: 1),
                                      pageBuilder: (context, animation, nextanim) => const HelpAssets(),
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
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 36,
                                  width: size.width * .27,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: renkler.koyuuRenk,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context).indicatorColor,
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(3, 3)
                                          ),
                                        ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.wallet,
                                            color: Color(0xffF2F2F2),
                                            size: 22,
                                          ),
                                          FittedBox(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 2),
                                              child: Text(
                                                translation(context).assets,
                                                style: const TextStyle(
                                                    height: 1,
                                                    color: Color(0xffF2F2F2),
                                                    fontSize: 11
                                                ),
                                                textAlign: TextAlign.center,
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
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 36,
                                  width: size.width * .27,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: renkler.koyuuRenk,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context).indicatorColor,
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(3, 3)
                                          ),
                                        ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.calculate,
                                            color: Color(0xffF2F2F2),
                                            size: 22,
                                          ),
                                          FittedBox(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 2),
                                              child: Text(
                                                translation(context).calculatorHelp,
                                                style: const TextStyle(
                                                    height: 1,
                                                    color: Color(0xffF2F2F2),
                                                    fontSize: 11
                                                ),
                                                textAlign: TextAlign.center,
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
                                      pageBuilder: (context, animation, nextanim) => const HelpBackup(),
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
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 36,
                                  width: size.width * .28,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: renkler.koyuuRenk,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context).indicatorColor,
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(3, 3)
                                          ),
                                        ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.backup,
                                            color: Color(0xffF2F2F2),
                                            size: 22,
                                          ),
                                          FittedBox(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 2),
                                              child: Text(
                                                translation(context).backupSystem,
                                                style: const TextStyle(
                                                    height: 1,
                                                    color: Color(0xffF2F2F2),
                                                    fontSize: 11
                                                ),
                                                textAlign: TextAlign.center,
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
                        ),
                        const SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(milliseconds: 1),
                                      pageBuilder: (context, animation, nextanim) => const HelpAddUpdate(),
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
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 36,
                                  width: size.width * .27,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: renkler.koyuuRenk,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context).indicatorColor,
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(3, 3)
                                          ),
                                        ]
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.add_rounded,
                                            color: Color(0xffF2F2F2),
                                            size: 22,
                                          ),
                                          FittedBox(
                                            child: Text(
                                              translation(context).addEditHelp,
                                              style: TextStyle(
                                                  height: 1,
                                                  color: Color(0xffF2F2F2),
                                                  fontSize: 11
                                              ),
                                              textAlign: TextAlign.center,
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
                                      pageBuilder: (context, animation, nextanim) => const HelpCurrency(),
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
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 36,
                                  width: size.width * .27,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: renkler.koyuuRenk,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context).indicatorColor,
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(3, 3)
                                          ),
                                        ]
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.currency_exchange_rounded,
                                            color: Color(0xffF2F2F2),
                                            size: 20,
                                          ),
                                          FittedBox(
                                            child: Text(
                                              translation(context).exchangeSystemHelp,
                                              style: TextStyle(
                                                  height: 1,
                                                  color: Color(0xffF2F2F2),
                                                  fontSize: 11
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * .27,)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),//news
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start  ,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).highlightColor,
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 0.5,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ]
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4,left: 8,right: 8),
                              child: Text(
                                translation(context).whatsNew,
                                style: TextStyle(
                                  height: 1,
                                  fontFamily: "Nexa3",
                                  fontSize: 22,
                                  color: Theme.of(context).canvasColor,
                                ),
                              ),
                            ),
                            Expanded(child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  color: Theme.of(context).highlightColor,
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 0.5,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ]
                              ),
                            ))
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
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                    "Android 2.0.0v ${translation(context).version2Title} (15.09.2023)",
                                    textDirection: TextDirection.ltr,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).highlightColor,
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 0.5,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ]
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4,left: 8,right: 8),
                              child: Text(
                                translation(context).faq,
                                style: TextStyle(
                                    fontFamily: "Nexa3",
                                    fontSize: 22,
                                    height: 1,
                                    color: Theme.of(context).canvasColor
                                ),
                              ),
                            ),
                            Expanded(child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  color: Theme.of(context).highlightColor,
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 0.5,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ]
                              ),
                            ))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              boxShadow: darkMode == 1 ? [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-1, 2),
                                )
                              ] : [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Theme.of(context).splashColor)
                          ),
                          child: ListTileTheme(
                              contentPadding: const EdgeInsets.all(0),
                              dense: true,
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Text(
                                  translation(context).question1,
                                  style: const TextStyle(fontSize: 15.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                ),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      translation(context).answer1,
                                      style: const TextStyle(fontSize: 14.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              boxShadow: darkMode == 1 ? [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-1, 2),
                                )
                              ] : [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Theme.of(context).splashColor)
                          ),
                          child: ListTileTheme(
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Text(
                                  translation(context).question2,
                                  style: const TextStyle(fontSize: 15.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                ),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      translation(context).answer2,
                                      style: const TextStyle(fontSize: 14.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  GestureDetector(
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: FittedBox(
                                        child: Container(
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).disabledColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(10))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 2, left: 10, right: 10),
                                            child: Center(
                                              child: Text(
                                                translation(context).contactUs,style: TextStyle(
                                                color: renkler.koyuuRenk,
                                                height: 1,
                                                fontSize: 14
                                              ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              boxShadow: darkMode == 1 ? [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-1, 2),
                                )
                              ] : [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Theme.of(context).splashColor)
                          ),
                          child: ListTileTheme(
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Text(
                                  translation(context).question3,
                                  style: const TextStyle(fontSize: 15.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                ),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      translation(context).answer3,
                                      style: const TextStyle(fontSize: 14.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              boxShadow: darkMode == 1 ? [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-1, 2),
                                )
                              ] : [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Theme.of(context).splashColor)
                          ),
                          child: ListTileTheme(
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Text(
                                  translation(context).question4,
                                  style: const TextStyle(fontSize: 15.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                ),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      translation(context).answer4,
                                      style: const TextStyle(fontSize: 14.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration: const Duration(milliseconds: 1),
                                          pageBuilder: (context, animation, nextanim) => const HelpCurrency(),
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: FittedBox(
                                        child: Container(
                                          height: 24,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).disabledColor,
                                              borderRadius: const BorderRadius.all(Radius.circular(10))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 2, left: 10, right: 10),
                                            child: Center(
                                              child: Text(
                                                translation(context).exchangeSystem,style: TextStyle(
                                                  color: renkler.koyuuRenk,
                                                  height: 1,
                                                  fontSize: 14
                                              ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              boxShadow: darkMode == 1 ? [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-1, 2),
                                )
                              ] : [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Theme.of(context).splashColor)
                          ),
                          child: ListTileTheme(
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Text(
                                  translation(context).question5,
                                  style: const TextStyle(fontSize: 15.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                ),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      translation(context).answer5,
                                      style: const TextStyle(fontSize: 14.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              boxShadow: darkMode == 1 ? [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-1, 2),
                                )
                              ] : [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Theme.of(context).splashColor)
                          ),
                          child: ListTileTheme(
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Text(
                                  translation(context).question6,
                                  style: const TextStyle(fontSize: 15.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                ),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      translation(context).answer6,
                                      style: const TextStyle(fontSize: 14.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              boxShadow: darkMode == 1 ? [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-1, 2),
                                )
                              ] : [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Theme.of(context).splashColor)
                          ),
                          child: ListTileTheme(
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Text(
                                  translation(context).question7,
                                  style: const TextStyle(fontSize: 15.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                ),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      translation(context).answer7,
                                      style: const TextStyle(fontSize: 14.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              boxShadow: darkMode == 1 ? [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-1, 2),
                                )
                              ] : [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Theme.of(context).splashColor)
                          ),
                          child: ListTileTheme(
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Text(
                                  translation(context).question8,
                                  style: const TextStyle(fontSize: 15.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                ),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      translation(context).answer8,
                                      style: const TextStyle(fontSize: 14.0, fontFamily: "Nexa3"),textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8,),



                      ],
                    ), //SSS
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                child: const BannerAds(
                  adSize: AdSize.banner,
                ),
              ),
              const SizedBox(height: 14,),
              helpFooter(context),
            ],
          ),
        ),
      ),
    );
  }
}
/*
Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 3),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 3),
                            decoration: BoxDecoration(
                                color: Theme.of(context).indicatorColor,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ExpansionTile(

                              title: Text(translation(context).recordsGone),
                              trailing: customicom2 ? const Icon(
                                Icons.keyboard_arrow_up,
                                size: 30,
                              )
                                  : Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                                color: Theme.of(context).canvasColor,
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
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 3),
                            decoration: BoxDecoration(
                                color: Theme.of(context).indicatorColor,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: ExpansionTile(
                              title: Text(translation(context).iWantToContactYou),
                              trailing: customicom3 ? const Icon(
                                Icons.keyboard_arrow_up,
                                size: 30,
                              )
                                  : Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                                color: Theme.of(context).canvasColor,
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
                                        borderRadius: BorderRadius.circular(15),
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
 */