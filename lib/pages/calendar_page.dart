import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/pages/daily_info_page.dart';
import 'package:butcekontrol/pages/more/settings.dart';
import 'package:butcekontrol/utils/interstitial_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';
import 'package:butcekontrol/classes/language.dart';

class Calendar extends ConsumerWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readNavBar = ref.read(botomNavBarRiverpod);
    readNavBar.currentColor = const Color(0xffF2F2F2);
    return  SafeArea(
      bottom: false,
      child: Scaffold(
        body: CalendarBody(),
        appBar: AppBarForPage(title: translation(context).activityCalendarTitle),
        //backgroundColor: Color(0xffF2F2F2),
      ),
    );
  }
}

class CalendarBody extends ConsumerStatefulWidget {
  const CalendarBody({Key? key}) : super(key: key);
  @override
  ConsumerState<CalendarBody> createState() => _CalendarBody();
}

class _CalendarBody extends ConsumerState<CalendarBody> {

  final InterstitialAdManager _interstitialAdManager = InterstitialAdManager();

  @override
  void initState() {
    var readSettings = ref.read(settingsRiverpod);
    var adEventCounter = readSettings.adEventCounter;
    if (adEventCounter! < 6) {
      _interstitialAdManager.loadInterstitialAd();
    } else {
    }
    super.initState();
  }
  void _showInterstitialAd(BuildContext context) {
    _interstitialAdManager.showInterstitialAd(context);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: size.height*0.78,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            calendarDesign(context, ref),
          ],

        ),
      ),
    );
  }

  Widget calendarDesign(BuildContext context, WidgetRef ref) {
    ref.listen(databaseRiverpod, (previous, next) {
      ref.watch(databaseRiverpod).isuseinsert ;
      ref.watch(databaseRiverpod).updatest;
      return ref.watch(databaseRiverpod);
    }
    );
    var read = ref.read(calendarRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    int selectedValueDay = readSettings.monthStartDay!;
    var size = MediaQuery.of(context).size;
    var year = read.yearIndex;
    var month = read.monthIndex;

    var previousYear = read.indexCalculator(read.currentIndex-1)[1] ;
    var previousMonth = read.indexCalculator(read.currentIndex-1)[0] ;
    var nextYear = read.indexCalculator(read.currentIndex+1)[1] ;
    var nextMonth = read.indexCalculator(read.currentIndex+1)[0] ;

    List<String> dateMap = read.getCalendarDays(year, month,selectedValueDay);
    List<String> dateMapPrevious = read.getCalendarDays(previousYear, previousMonth,selectedValueDay);
    List<String> dateMapNext = read.getCalendarDays(nextYear, nextMonth,selectedValueDay);
    var days = [];
    var months = [];
    var years = [];
    var daysPrevious = [];
    var monthsPrevious = [];
    var yearsPrevious = [];
    var daysNext = [];
    var monthsNext = [];
    var yearsNext = [];

    for (var i = 0; i < dateMap.length; i++) {
      var datePiece = dateMap[i].split('.');
      var day = int.parse(datePiece[0]);
      var month = int.parse(datePiece[1]);
      var year = int.parse(datePiece[2]);

      days.add(day);
      months.add(month);
      years.add(year);
    }
    for (var i = 0; i < dateMapPrevious.length; i++) {
      var datePiece = dateMapPrevious[i].split('.');
      var day = int.parse(datePiece[0]);
      var month = int.parse(datePiece[1]);
      var year = int.parse(datePiece[2]);

      daysPrevious.add(day);
      monthsPrevious.add(month);
      yearsPrevious.add(year);
    }
    for (var i = 0; i < dateMapNext.length; i++) {
      var datePiece = dateMapNext[i].split('.');
      var day = int.parse(datePiece[0]);
      var month = int.parse(datePiece[1]);
      var year = int.parse(datePiece[2]);

      daysNext.add(day);
      monthsNext.add(month);
      yearsNext.add(year);
    }
    var intDays = days.map((gun) => int.parse(gun.toString())).toList();
    var intMonths = months.map((ay) => int.parse(ay.toString())).toList();
    var intYears = years.map((yil) => int.parse(yil.toString())).toList();

    var intDaysPrevious = daysPrevious.map((gun) => int.parse(gun.toString())).toList();
    var intMonthsPrevious = monthsPrevious.map((ay) => int.parse(ay.toString())).toList();
    var intYearsPrevious = yearsPrevious.map((yil) => int.parse(yil.toString())).toList();

    var intDaysNext = daysNext.map((gun) => int.parse(gun.toString())).toList();
    var intMonthsNext = monthsNext.map((ay) => int.parse(ay.toString())).toList();
    var intYearsNext = yearsNext.map((yil) => int.parse(yil.toString())).toList();

    final PageController pageController =  PageController(initialPage: 1);


    List monthName = read.getMonths(context);
    List yearName = read.getYears();
    read.startDate = DateTime(read.yearIndex,read.monthIndex,selectedValueDay);
    read.endDate = DateTime(read.yearIndex,read.monthIndex+1,selectedValueDay-1);
    var readSetting = ref.read(settingsRiverpod);
    var adEventCounter = readSettings.adEventCounter;
    var darkMode = readSetting.DarkMode;
    return Center(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: size.height * 0.05,
                decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: darkMode == 1 ? [
                      BoxShadow(
                        color: Colors.black54.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(-1, 2),
                      )
                    ] : [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0.5,
                          blurRadius: 2,
                          offset: const Offset(0, 2)
                      )]
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: IconButton(
                    icon: const Icon(Icons
                        .refresh_rounded),
                    padding:
                    EdgeInsets.zero,
                    alignment: Alignment
                        .center,
                    color: renkler
                        .arkaRenk,
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        read.setIndex(0, 3,ref);
                        read.pageMonthController.jumpToPage(read.monthIndex-1);
                        read.pageYearController.jumpToPage(read.yearIndex-2020);
                        if (adEventCounter! <= 0) {
                          print("object");
                          _showInterstitialAd(context);
                          readSettings.resetAdEventCounter();
                        } else {
                          readSettings.useAdEventCounter();
                        }
                        print(readSettings.adEventCounter);
                      });
                    },
                  ),
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    width: size.width * 0.52,
                    height: size.height * 0.074,
                    child: Stack(
                      children: [
                        Positioned(
                          top: size.height * 0.007,
                          child: Container(
                            height: size.height * 0.060,
                            width: size.width * 0.50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              color: Theme.of(context).disabledColor,
                                boxShadow: darkMode == 1 ? [
                                  BoxShadow(
                                    color: Colors.black54.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(-1, 2),
                                  )
                                ] : [
                                BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                              offset: const Offset(0, 2)
                          )]
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: size.height * 0.060,
                              width: size.width * 0.32,
                              child: PageView(
                                controller: read.pageMonthController,
                                onPageChanged: (index) {
                                  setState(() {
                                    read.setIndex(index,0,ref);
                                  });
                                },
                                children: monthName
                                    .map(
                                      (month) => Center(
                                    widthFactor: 1.5,
                                    child: Text(
                                      month,
                                      style: const TextStyle(
                                        color: Color(0xff0D1C26),
                                        fontSize: 19,
                                        fontFamily: 'Nexa4',
                                        fontWeight: FontWeight.w600,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                )
                                    .toList(),
                              ),
                            ),
                            Container(
                              height: size.height * 0.074,
                              width: size.width * 0.20,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                                color: Theme.of(context).highlightColor,
                                  boxShadow: darkMode == 1 ? [
                                    BoxShadow(
                                      color: Colors.black54.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(-1, 2),
                                    )
                                  ] : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0.5,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )]
                              ),
                              child: PageView(
                                controller: read.pageYearController,
                                onPageChanged: (index) {
                                  setState(() {
                                    print(index);
                                    read.setIndex(index,1,ref);
                                  });
                                },
                                children: yearName
                                    .map(
                                      (year) => Center(
                                    child: Text(
                                      year,
                                      style: TextStyle(
                                        color: Theme.of(context).dialogBackgroundColor,
                                        fontSize: 18,
                                        fontFamily: 'Nexa4',
                                        fontWeight: FontWeight.w600,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onLongPress: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 1),
                      pageBuilder: (context, animation, nextanim) => const Settings(),
                      reverseTransitionDuration: const Duration(milliseconds: 1),
                      transitionsBuilder: (context, animation, nexttanim, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  ).then((value) => ref.read(botomNavBarRiverpod).setCurrentindex(4));
                },
                child: Tooltip(
                  message: translation(context).calendarMonthStartDayButton,
                  triggerMode: TooltipTriggerMode.tap,
                  showDuration: const Duration(seconds: 5),
                  textStyle: TextStyle(
                      fontSize: 14,
                      color: renkler.arkaRenk,
                      height: 1),
                  textAlign: TextAlign.center,
                  decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                      boxShadow: darkMode == 1 ? [
                        BoxShadow(
                          color: Colors.black54.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(-1, 2),
                        )
                      ] : [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.5,
                            blurRadius: 2,
                            offset: const Offset(0, 2)
                        )],
                      color: Theme.of(context).highlightColor),
                  child: Container(
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: darkMode == 1 ? [
                          BoxShadow(
                            color: Colors.black54.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(-1, 2),
                          )
                        ] : [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                              offset: const Offset(0, 2)
                          )]
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            selectedValueDay.toString(),style: TextStyle(color: renkler.koyuuRenk,fontSize: 20,height: 1,fontFamily: 'Nexa4'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          monthGuide(context),
          SizedBox(
            width: size.width * 0.92,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                containerDayAdd(context, translation(context).calendarMonday),
                containerDayAdd(context, translation(context).calendarTuesday),
                containerDayAdd(context, translation(context).calendarWednesday),
                containerDayAdd(context, translation(context).calendarThursday),
                containerDayAdd(context, translation(context).calendarFriday),
                containerDayAdd(context, translation(context).calendarSaturday),
                containerDayAdd(context, translation(context).calendarSunday),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: size.width * 0.92,
            height: size.height * 0.44,
            child: PageView(
              controller: pageController,
              physics: const PageScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  print(index);
                  read.setIndex(index, 2,ref);
                  pageController.jumpToPage(1);
                  read.pageMonthController.jumpToPage(read.monthIndex-1);
                  read.pageYearController.jumpToPage(read.yearIndex-2020);
                });
              },
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var x = 0; x < 6; x++)
                      SizedBox(
                        width: size.width * 0.92,
                        height: size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (var y = 0; y < 7; y++)
                              containerAdd(context, intDaysPrevious[x * 7 + y],intMonthsPrevious[x * 7 + y], intYearsPrevious[x * 7 + y]),
                          ],
                        ),
                      ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var x = 0; x < 6; x++)
                      SizedBox(
                        width: size.width * 0.92,
                        height: size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (var y = 0; y < 7; y++)
                              containerAdd(context, intDays[x * 7 + y],intMonths[x * 7 + y], intYears[x * 7 + y]),
                          ],
                        ),
                      ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var x = 0; x < 6; x++)
                      SizedBox(
                        width: size.width * 0.92,
                        height: size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (var y = 0; y < 7; y++)
                              containerAdd(context, intDaysNext[x * 7 + y],intMonthsNext[x * 7 + y], intYearsNext[x * 7 + y]),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Directionality(
            textDirection: TextDirection.ltr,
              child: monthDetailsGuide(context)
          ),
        ],
      ),
    );
  }


  CustomColors renkler = CustomColors();
  int initialLabelIndex = 0;
  List<String> dayList = ["1","8","15","22","29"];




  Widget monthDetailsGuide(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(calendarRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    var darkMode = readSettings.DarkMode;
    int selectedValueDay = readSettings.monthStartDay!;
    return FutureBuilder<List>(
      future: read.getMonthAmount(read.monthIndex, read.yearIndex,selectedValueDay),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Veri henüz gelmediğinde veya gecikme yaşandığında
          return SizedBox(
            width: size.width * 0.90,
            height: size.height * 0.05,
            child: Stack(
              children: [
                Positioned(
                  top: 3,
                  child: SizedBox(
                    height: size.height * 0.04,
                    width: size.width * 0.90,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        boxShadow: darkMode == 1 ? [
                          BoxShadow(
                            color: Colors.black54.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(-1, 2),
                          )
                        ] : [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                              offset: const Offset(0, 2)
                          )],
                        gradient: LinearGradient(
                          colors: [Theme.of(context).hintColor, Theme.of(context).hoverColor],
                          stops: [0.5, 0.5],
                        ),
                        borderRadius:
                        const BorderRadius.vertical(bottom: Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "  +0.0",
                            style: TextStyle(
                              color:  Colors.white,
                              fontSize: 16,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w900,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.15,
                          ),
                          const Text(
                            "-0.0  ",
                            style: TextStyle(
                              color:  Colors.white,
                              fontSize: 16,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w900,
                              height: 1.4,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //gelir bilgisi
                Center(
                  child: SizedBox(
                    height: size.height * 0.05,
                    width: size.width / 3.5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Theme.of(context).disabledColor,
                      ),
                      child: Center(
                        child: Text(
                          "0.0",
                          style: TextStyle(
                            color: Color(0xff0D1C26),
                            fontSize: 16,
                            fontFamily: 'Nexa3',
                            fontWeight: FontWeight.w900,
                            height: 1.4,
                          ),
                        ),
                      ), //Toplam değişim.
                    ),
                  ),
                ),
                //Gider bilgisi
              ],
            ),
          );
        }
        if (snapshot.hasData) {
          List data = snapshot.data!;
          return SizedBox(
            width: size.width * 0.90,
            height: size.height * 0.05,
            child: Stack(
              children: [
                Positioned(
                  top: 3,
                  child: SizedBox(
                    height: size.height * 0.04,
                    width: size.width * 0.90,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        boxShadow: darkMode == 1 ? [
                          BoxShadow(
                            color: Colors.black54.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(-1, 2),
                          )
                        ] : [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                              offset: const Offset(0, 2)
                          )],
                        gradient: LinearGradient(
                          colors: [Theme.of(context).hintColor, Theme.of(context).hoverColor],
                          stops: [0.5, 0.5],
                        ),
                        borderRadius:
                            const BorderRadius.vertical(bottom: Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "  +${data[0]}",
                            style: const TextStyle(
                              color:  Colors.white,
                              fontSize: 15,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w900,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.15,
                          ),
                          Text(
                            "-${data[1]}  ",
                            style: const TextStyle(
                              color:  Colors.white,
                              fontSize: 15,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w900,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //gelir bilgisi
                Center(
                  child: SizedBox(
                    height: size.height * 0.05,
                    width: size.width / 3.5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Theme.of(context).disabledColor,
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            "${data[2]}",
                            style: const TextStyle(
                              color: Color(0xff0D1C26),
                              fontSize: 17,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w900,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ), //Toplam değişim.
                    ),
                  ),
                ),
                //Gider bilgisi
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).disabledColor,
              backgroundColor: Color(0xFF0D1C26),
            ),
          );
        }
      },
    );
  }

  Widget monthGuide(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(calendarRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    int selectedValueDay = readSettings.monthStartDay!;
    return FutureBuilder<List>(
      future: read.getMonthAmountCount(read.monthIndex, read.yearIndex,selectedValueDay),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Veri henüz gelmediğinde veya gecikme yaşandığında
          return SizedBox(
            width: size.width * 0.90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "0 ${translation(context).incomeInfo}",
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: 17,
                    fontFamily: 'Nexa3',
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                Text(
                  "0 ${translation(context).expenseInfo}",
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: 17,
                    fontFamily: 'Nexa3',
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          );
        }
        if (snapshot.hasData) {
          List data = snapshot.data!;
          return SizedBox(
            width: size.width * 0.90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${data[0]} ${translation(context).incomeInfo}",
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: 17,
                    fontFamily: 'Nexa3',
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                Text(
                  "${data[1]} ${translation(context).expenseInfo}",
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontSize: 17,
                    fontFamily: 'Nexa3',
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          );
        }
        else {
          return Center(
            child:  CircularProgressIndicator(
              color: Theme.of(context).disabledColor,
              backgroundColor: Color(0xFF0D1C26),
            ),
          );
        }
      },
    );
  }

  Widget containerAdd(BuildContext context, int days, int months, int years) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(calendarRiverpod);
    var total = read.getDateColor(days,months,years);
    return SizedBox(
      height: size.height * 0.055, //45
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          //height: size.height * 0.065,
          //width: size.width * 0.12,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Theme.of(context).dividerColor,
            border: Border.all(color: Theme.of(context).focusColor,width: 1,strokeAlign: BorderSide.strokeAlignOutside),
          ),
          child: Stack(children:[
          containerColorChange(context,total,years,months,days),
          dateText(context, days,months, days,years,total)]),
        ),
      ),
    );
  }

  Widget containerDayAdd(BuildContext context, String day) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.056,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Theme.of(context).highlightColor,
          ),
          child: Center(
            child: Text(
              day,
              style: const TextStyle(
                color: Color(0xFFE9E9E9),
                fontSize: 18,
                fontFamily: 'Nexa3',
                fontWeight: FontWeight.w900,
                height: 1.4,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dateText(BuildContext context, int date, int month,int day, int year, Future<double> total) {
    var size = MediaQuery.of(context).size;
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    var read = ref.read(calendarRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    int selectedValueDay = readSettings.monthStartDay!;

    DateTime startDate = DateTime(read.yearIndex, read.monthIndex, selectedValueDay-1);
    DateTime endDate = DateTime(read.yearIndex, read.monthIndex+1, selectedValueDay);

    var controllerDate = DateTime(year,month,day);
    bool isInRange = isDateInRange(controllerDate, startDate, endDate);
    return SizedBox(
      height: size.height * 0.065,
      width: size.height * 0.065,
      child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            double totalAmount = await total;
            if (totalAmount == 0) {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 40,
                      color: const Color(0xFF0D1C26),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            translation(context).dataForTheDayNotFound,
                            style: const TextStyle(
                              fontFamily: 'Nexa3',
                              fontSize: 18,
                              color: Color(0xFFE9E9E9),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              readDailyInfo.setDate(date, month, year);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DailyInfo()));
            }
          },
          child: Center(
            child: FittedBox(
              child: Text(
                date > 0 ? date.toString() : "",
                style: TextStyle(
                  color: isInRange
                      ? Theme.of(context).canvasColor
                      : Theme.of(context).indicatorColor,
                  fontSize: 18,
                  fontFamily: 'Nexa3',
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ),
          )),
    );
  }

  bool isDateInRange(DateTime dateToCheck, DateTime startDate, DateTime endDate) {
    return dateToCheck.isAfter(startDate) && dateToCheck.isBefore(endDate);
  }

  Widget containerColorChange(
      BuildContext context, Future<double> toplamFuture,int year ,int month, int day) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(calendarRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    int selectedValueDay = readSettings.monthStartDay!;

    DateTime startDate = DateTime(read.yearIndex, read.monthIndex, selectedValueDay-1);
    DateTime endDate = DateTime(read.yearIndex, read.monthIndex+1, selectedValueDay);

    var controllerDate = DateTime(year,month,day);
    bool isInRange = isDateInRange(controllerDate, startDate, endDate);
    if (isInRange) {
      return FutureBuilder<double>(
        future: toplamFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double toplam = snapshot.data!;
            String toplamS = toplam.toString();
            if (toplamS.contains('-')) {
              return Positioned(
                right: 4,
                top: 4,
                child: Container(
                  height: size.height * 0.025,
                  width: size.height * 0.025,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(90),
                        topRight: Radius.circular(50)),
                    color: Color(0xffD91A2A),
                  ),
                ),
              );
            } else if (toplam == 0) {
              return const SizedBox();
            } else {
              return Positioned(
                right: 3,
                top: 3,
                child: Container(
                  height: size.height * 0.025,
                  width: size.height * 0.025,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(90),
                        topRight: Radius.circular(50)),
                    color: Color(0xff1A8E58),
                  ),
                ),
              );
            }
          } else if (snapshot.hasError) {
            // handle error case
            return const Text('Error');
          } else {
            // handle loading case
            return const SizedBox(

            );
          }
        },
      );
    } else {
      return const SizedBox();
    }
  }
}