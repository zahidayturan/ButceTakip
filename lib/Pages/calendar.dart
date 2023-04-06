import 'package:butcekontrol/utils/DateTimeManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';
import 'package:butcekontrol/Pages/dailyInfo.dart';

class Calendar extends ConsumerWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readNavBar = ref.read(botomNavBarRiverpod);
    readNavBar.currentColor = Color(0xffF2F2F2);
    return Container(
      color: const Color(0xff0D1C26),
      child: const SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          appBar: CalendarAppBar(),
          body: CalendarBody(),
        ),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CalendarDesign(context, ref)],
    );
  }

  Widget CalendarDesign(BuildContext context, WidgetRef ref) {
    var read = ref.read(calendarRiverpod);
    var size = MediaQuery.of(context).size;
    var year = selectedYearIndex;
    var month = selectedMonthIndex;

    List<String> dateMap = read.getCalendarDays(year, month);
    var days = [];
    var months = [];
    var years = [];

    for (var i = 0; i < dateMap.length; i++) {
      var datePiece = dateMap[i].split('.');
      var day = int.parse(datePiece[0]);
      var month = int.parse(datePiece[1]);
      var year = int.parse(datePiece[2]);

      days.add(day);
      months.add(month);
      years.add(year);
    }
    var intDays = days.map((gun) => int.parse(gun.toString())).toList();
    var intMonths = months.map((ay) => int.parse(ay.toString())).toList();
    var intYears = years.map((yil) => int.parse(yil.toString())).toList();

    return SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            dateSelector(context),
            SizedBox(height: 10),
            monthGuide(context),
            SizedBox(
              width: size.width * 0.92,
              height: size.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  containerDayAdd(context, "Pt"),
                  containerDayAdd(context, "Sa"),
                  containerDayAdd(context, "Ça"),
                  containerDayAdd(context, "Pe"),
                  containerDayAdd(context, "Cu"),
                  containerDayAdd(context, "Ct"),
                  containerDayAdd(context, "Pz"),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.46,
              child: Column(
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
                            Stack(
                              children: [
                                containerAdd(context),
                                containerColorChange(
                                    context,
                                    read.getDateColor(
                                        intDays[x * 7 + y],
                                        intMonths[x * 7 + y],
                                        intYears[x * 7 + y]),
                                    intMonths[x * 7 + y]),
                                dateText(context, intDays[x * 7 + y],
                                    intMonths[x * 7 + y], intYears[x * 7 + y])
                              ],
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 15),
            monthDetailsGuide(context),
          ],
        ),
      ),
    );
  }

  int selectedMonthIndex = DateTime.now().month;
  int selectedYearIndex = DateTime.now().year;
  final PageController pageMonthController =
      PageController(initialPage: DateTime.now().month - 1);
  final PageController pageYearController =
      PageController(initialPage: DateTime.now().year - 2020);

  Widget dateSelector(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(calendarRiverpod);
    List monthName = read.getMonths();
    List yearName = read.getYears();
    return Stack(
      children: [
        Positioned(
          top: 5,
          child: Container(
            height: size.height * 0.060,
            width: size.width * 0.52,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Color(0xffF2CB05),
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.52,
          height: size.height * 0.074,
          child: Stack(
            children: [
              Positioned(
                top: 5,
                child: Container(
                  height: size.height * 0.060,
                  width: size.width * 0.52,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Color(0xffF2CB05),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: size.height * 0.060,
                    width: size.width * 0.32,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Color(0xffF2CB05),
                    ),
                    child: PageView(
                      controller: pageMonthController,
                      onPageChanged: (index) {
                        setState(() {
                          selectedMonthIndex = index + 1;
                        });
                        print(selectedMonthIndex);
                      },
                      children: monthName
                          .map(
                            (month) => Center(
                              child: Text(
                                month,
                                style: const TextStyle(
                                  color: Color(0xff0D1C26),
                                  fontSize: 20,
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
                    width: size.width * 0.2,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color(0xff0D1C26),
                    ),
                    child: PageView(
                      controller: pageYearController,
                      onPageChanged: (index) {
                        setState(() {
                          selectedYearIndex = index + 2020;
                        });
                        print(selectedYearIndex);
                      },
                      children: yearName
                          .map(
                            (year) => Center(
                              child: Text(
                                year,
                                style: const TextStyle(
                                  color: Color(0xffF2CB05),
                                  fontSize: 20,
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
    );
  }

  Widget monthDetailsGuide(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(calendarRiverpod);
    return FutureBuilder<List>(
      future: read.getMonthAmount(selectedMonthIndex, selectedYearIndex),
      builder: (context, snapshot) {
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
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff1A8E58), Color(0xffD91A2A)],
                          stops: [0.5, 0.5],
                        ),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "+${data[0]}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w900,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.15,
                          ),
                          Text(
                            "-${data[1]}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
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
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xffF2CB05),
                      ),
                      child: Center(
                        child: Text(
                          "${data[2]}",
                          style: const TextStyle(
                            color: Color(0xff0D1C26),
                            fontSize: 20,
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
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget monthGuide(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(calendarRiverpod);
    return FutureBuilder<List>(
      future: read.getMonthAmountCount(selectedMonthIndex, selectedYearIndex),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data!;
          return SizedBox(
            width: size.width * 0.90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${data[0]} Gelir Bilgisi",
                  style: const TextStyle(
                    color: Color(0xff0D1C26),
                    fontSize: 17,
                    fontFamily: 'Nexa3',
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                Text(
                  "${data[1]} Gider Bilgisi",
                  style: const TextStyle(
                    color: Color(0xff0D1C26),
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
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget containerAdd(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.065,
      width: size.width * 0.11,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
      ),
    );
  }

  Widget containerDayAdd(BuildContext context, String day) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.065,
      width: size.width * 0.11,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color(0xff0D1C26),
      ),
      child: Center(
        child: Text(
          day,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Nexa3',
            fontWeight: FontWeight.w900,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget dateText(BuildContext context, int date, int month, int year) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(calendarRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    var monthName = read.getMonthName(month);
    return SizedBox(
      height: size.height * 0.065,
      width: size.height * 0.065,
      child: TextButton(
          onPressed: () {
            if (month == selectedMonthIndex) {
              print("${date} ${monthName} ${year}");
            }
            readDailyInfo.setDate(date, month, year);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  dailyInfo(),));
          },
          child: Text(
            date > 0 ? date.toString() : "",
            style: TextStyle(
              color: month == selectedMonthIndex
                  ? Color(0xff0D1C26)
                  : Color(0xffF2F2F2),
              fontSize: 20,
              fontFamily: 'Nexa3',
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          )),
    );
  }

  Widget containerColorChange(
      BuildContext context, Future<double> toplamFuture, int month) {
    var size = MediaQuery.of(context).size;
    if (month == selectedMonthIndex) {
      return FutureBuilder<double>(
        future: toplamFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double toplam = snapshot.data!;
            String toplamS = toplam.toString();
            if (toplamS.contains('-')) {
              return Positioned(
                right: 3,
                top: 3,
                child: Container(
                  height: size.height * 0.030,
                  width: size.width * 0.055,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(90),
                        topRight: Radius.circular(50)),
                    color: Color(0xffD91A2A),
                  ),
                ),
              );
            } else if (toplam == 0) {
              return SizedBox();
            } else {
              return Positioned(
                right: 3,
                top: 3,
                child: Container(
                  height: size.height * 0.030,
                  width: size.width * 0.055,
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
            return Text('Error');
          } else {
            // handle loading case
            return SizedBox(
              height: size.height * 0.030,
              width: size.width * 0.055,
              child: const CircularProgressIndicator(),
            );
          }
        },
      );
    } else {
      return const SizedBox();
    }
  }
}

class CalendarAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CalendarAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(60);

  Widget build(BuildContext context, WidgetRef ref) {
    var read2 = ref.read(botomNavBarRiverpod);
    var size = MediaQuery.of(context).size;
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
                decoration: const BoxDecoration(
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
                decoration: const BoxDecoration(
                    color: Color(0xffF2CB05),
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
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                //Navigator.of(context).pop();
                read2.setCurrentindex(0);
              },
            ),
          ),
          const Positioned(
            right: 20,
            top: 18,
            child: Text(
              "İŞLEM TAKVİMİ",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'NEXA4',
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
