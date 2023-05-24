import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/pages/daily_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';

class Calendar extends ConsumerWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readNavBar = ref.read(botomNavBarRiverpod);
    readNavBar.currentColor = const Color(0xffF2F2F2);
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBarForPage(title: 'İŞLEM TAKVİMİ'),
        body: CalendarBody(),
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [calendarDesign(context, ref)],
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

    return Center(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          dateSelector(context),
          const SizedBox(height: 10),
          monthGuide(context),
          SizedBox(
            width: size.width * 0.92,
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
          const SizedBox(height: 10),
          SizedBox(
            width: size.width * 0.92,
            height: size.height * 0.44,
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
                          containerAdd(context, intDays[x * 7 + y],intMonths[x * 7 + y], intYears[x * 7 + y]),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          monthDetailsGuide(context),
        ],
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
          top: 5.5,
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
                          const Text(
                            "+0.0",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w900,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.15,
                          ),
                          const Text(
                            "-0.0",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
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
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xffF2CB05),
                      ),
                      child: Center(
                        child: Text(
                          "0.0",
                          style: TextStyle(
                            color: Color(0xff0D1C26),
                            fontSize: 18,
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
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff1A8E58), Color(0xffD91A2A)],
                          stops: [0.5, 0.5],
                        ),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "  +${data[0]}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
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
                              color: Colors.white,
                              fontSize: 18,
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
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xffF2CB05),
                      ),
                      child: Center(
                        child: Text(
                          "${data[2]}",
                          style: const TextStyle(
                            color: Color(0xff0D1C26),
                            fontSize: 18,
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

  Widget containerAdd(BuildContext context, int days, int months, int years) {
    var read = ref.read(calendarRiverpod);
    var total = read.getDateColor(days,months,years);
    return SizedBox(
      height: 45,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          //height: size.height * 0.065,
          //width: size.width * 0.12,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          child: Stack(children:[
          containerColorChange(context,total,months),
          dateText(context, days,months, years,total)]),
        ),
      ),
    );
  }

  Widget containerDayAdd(BuildContext context, String day) {
    return SizedBox(
      height:45,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
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
        ),
      ),
    );
  }

  Widget dateText(BuildContext context, int date, int month, int year, Future<double> total) {
    var size = MediaQuery.of(context).size;
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    return SizedBox(
      height: size.height * 0.065,
      width: size.height * 0.065,
      child: TextButton(
          onPressed: () async {
            double totalAmount = await total;
            if (totalAmount == 0) {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 40,
                      color: const Color(0xFF0D1C26),
                      child: const Center(
                        child: Text(
                          'Güne ait veri bulunamadı !',
                          style: TextStyle(
                            fontFamily: 'Nexa3',
                            fontSize: 18,
                            color: Colors.white,
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
          child: Text(
            date > 0 ? date.toString() : "",
            style: TextStyle(
              color: month == selectedMonthIndex
                  ? const Color(0xff0D1C26)
                  : const Color(0xffF2F2F2),
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
              return const SizedBox();
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