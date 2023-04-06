import 'package:butcekontrol/Pages/categoryInfo.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d_chart/d_chart.dart';

class Statistics extends ConsumerWidget {
  Statistics({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: const Color(0xff0D1C26),
      child: const SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          appBar: StatisticAppBar(),
          body: StaticticsBody(),
        ),
      ),
    );
  }
}

class StaticticsBody extends ConsumerStatefulWidget {
  const StaticticsBody({Key? key}) : super(key: key);
  @override
  ConsumerState<StaticticsBody> createState() => _StaticticsBody();
}

class _StaticticsBody extends ConsumerState<StaticticsBody> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(statisticsRiverpod);
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: size.width,
          //height: size.height*0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: GelirGiderButon(context),
              ),
              SizedBox(
                width: 330,
                height: 200,
                child: pasta(context),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: TarihButon(context),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        categoryList(context),
        /*SizedBox(
          child: Text(
              "data ${validDateMenu} tür ${giderGelirHepsi} yıl ${selectedYearIndex} ay ${selectedMonthIndex} hafta ${selectedWeekIndex} gün ${selectedDayIndex}"),
        ),*/
      ],
    );
  }

  Widget categoryList(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    var readCategoryInfo = ref.read(categoryInfoRiverpod);
    var size = MediaQuery.of(context).size;
    Future<List<Map<String, dynamic>>> myList = read.getCategoryByMonth(
        validDateMenu,
        giderGelirHepsi,
        selectedYearIndex,
        selectedMonthIndex,
        selectedWeekIndex,
        selectedDayIndex);
    return FutureBuilder(
        future: myList,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var item = snapshot.data!;
          double totalAmount = 0;
          for (var item in item) {
            totalAmount += item['amount'];
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: SizedBox(
                height: 100,
                width: 140,
                child: Container(
                  color: Colors.deepOrange,
                  child: Center(child: Text("Abi banka bostir",style: TextStyle(color: Colors.white, fontSize: 16),)),
                ),
              ),
            );
          } else {
          return Column(
            children: [
              SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.35,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: () {
                          readCategoryInfo.setDateAndCategory(selectedDayIndex, selectedMonthIndex, selectedYearIndex, selectedWeekIndex, item[index]['category'],validDateMenu);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  categoryInfo(),));
                          },
                        child: SizedBox(
                          height: 42,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 5),
                                Container(
                                  width: 65,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: colorsList[index],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "% ${item[index]['percentages'].toString()}",
                                    style: const TextStyle(
                                      fontFamily: 'NEXA3',
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  item[index]['category'],
                                  style: const TextStyle(
                                    fontFamily: 'NEXA3',
                                    fontSize: 18,
                                    color: Color(0xff0D1C26),
                                  ),
                                ),
                                const Spacer(),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:item[index]['amount'].toString(),style: const TextStyle(
                                        fontFamily: 'NEXA4',
                                        fontSize: 16,
                                        color: Color(0xFFF2CB05),
                                      ),
                                      ),
                                      const TextSpan(
                                        text: ' ₺',
                                        style: TextStyle(
                                          fontFamily: 'TL',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFF2CB05),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     SizedBox(
                      width: 210,
                      child: Text("$giderGelirHepsi İçin Toplam Tutar",style: const TextStyle(
                        fontFamily: 'NEXA4',
                        fontSize: 17,
                        color: Color(0xff0D1C26),
                      ),),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      height: 26,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10,left: 10),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: totalAmount.toStringAsFixed(1),style: const TextStyle(
                                    fontFamily: 'NEXA4',
                                    fontSize: 17,
                                    color: Color(0xff0D1C26),
                                  ),
                                  ),
                                  const TextSpan(
                                    text: ' ₺',
                                      style: TextStyle(
                                        fontFamily: 'TL',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Color(0xffF2CB05),
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );}
        });
  }

  TarihButon(BuildContext context) {
    if (selectDateMenu == 0) {
      return dateSelectMenu(context);
    } else if (selectDateMenu == 1) {
      return yearSelectMenu(context);
    } else if (selectDateMenu == 2) {
      return monthSelectMenu(context);
    } else if (selectDateMenu == 3) {
      return weekSelectMenu(context);
    } else if (selectDateMenu == 4) {
      return daySelectMenu(context);
    }
  }

  int selectDateMenu = 2;
  int validDateMenu = 2;
  int selectedMonthIndex = DateTime.now().month;
  int selectedYearIndex = DateTime.now().year;
  int selectedWeekIndex = 1;
  int selectedDayIndex = DateTime.now().day;
  final PageController pageDayController =
      PageController(initialPage: DateTime.now().day - 1);
  final PageController pageWeekController = PageController(initialPage: 0);
  final PageController pageMonthController =
      PageController(initialPage: DateTime.now().month - 1);
  final PageController pageYearController =
      PageController(initialPage: DateTime.now().year - 2020);

  Widget dateSelectMenu(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    return SizedBox(
      height: 40,
      width: 240,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 240,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectDateMenu = 1;
                                validDateMenu = 1;
                                selectedYearIndex = DateTime.now().year;
                              });
                            },
                            child: const Text(
                              "YIL",
                              style: TextStyle(
                                fontFamily: 'NEXA4',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 5,
                          width: 36,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                            color: Color(0xffF2CB05),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 44,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectDateMenu = 2;
                                validDateMenu = 2;
                                selectedYearIndex = DateTime.now().year;
                                selectedMonthIndex = DateTime.now().month;
                              });
                            },
                            child: const Text(
                              "AY",
                              style: TextStyle(
                                fontFamily: 'NEXA4',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 5,
                          width: 40,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                            color: Color(0xffF2CB05),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 40,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedYearIndex = DateTime.now().year;
                                selectedMonthIndex = DateTime.now().month;
                                selectedWeekIndex = 1;
                                selectDateMenu = 3;
                                validDateMenu =3;
                              });
                            },
                            child: const Text(
                              "HAFTA",
                              style: TextStyle(
                                fontFamily: 'NEXA4',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 5,
                          width: 66,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                            color: Color(0xffF2CB05),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 50,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedYearIndex = DateTime.now().year;
                                selectedMonthIndex = DateTime.now().month;
                                selectedDayIndex = DateTime.now().day;
                                selectDateMenu = 4;
                                //validDateMenu = 4;
                              });
                            },
                            child: const Text(
                              "GÜN",
                              style: TextStyle(
                                fontFamily: 'NEXA4',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            height: 5,
                            width: 46,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15)),
                              color: Color(0xffF2CB05),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget monthSelectMenu(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    List monthName = read.getMonths();
    List yearName = read.getYears();
    return SizedBox(
      height: 40,
      width: 240,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 240,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      color: Color(0xffF2CB05),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectDateMenu = 0;
                          });
                        },
                        child: const Text(
                          "AYLIK",
                          style: TextStyle(
                            fontFamily: 'NEXA4',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 34,
                      width: 60,
                      child: PageView(
                        controller: pageMonthController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedMonthIndex = index + 1;
                          });
                        },
                        children: monthName
                            .map(
                              (year) => Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa3',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 34,
                      width: 48,
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
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa4',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 48,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget yearSelectMenu(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    List yearName = read.getYears();
    return SizedBox(
      height: 40,
      width: 240,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 240,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      color: Color(0xffF2CB05),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectDateMenu = 0;
                            });
                          },
                          child: const Text(
                            "YILLIK",
                            style: TextStyle(
                              fontFamily: 'NEXA4',
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 34,
                      width: 48,
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
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa4',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 48,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget weekSelectMenu(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    List yearName = read.getYears();
    List monthName = read.getMonths();
    List weekName = read.getWeeks(selectedMonthIndex, selectedYearIndex + 2020);
    return SizedBox(
      height: 40,
      width: 240,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 240,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Container(
                    height: 40,
                    width: 66,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      color: Color(0xffF2CB05),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectDateMenu = 0;
                            });
                          },
                          child: const Text(
                            "HAFTA",
                            style: TextStyle(
                              fontFamily: 'NEXA4',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 34,
                      width: 16,
                      child: PageView(
                        controller: pageWeekController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedWeekIndex = index + 1;
                          });
                        },
                        children: weekName
                            .map(
                              (week) => Center(
                                child: Text(
                                  "${week}.",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa3',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 12,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 34,
                      width: 60,
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
                              (year) => Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa3',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 34,
                      width: 48,
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
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa4',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 48,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget daySelectMenu(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    List yearName = read.getYears();
    List monthName = read.getMonths();
    List dayName = read.getDays(selectedMonthIndex, selectedYearIndex + 2020);
    return SizedBox(
      height: 40,
      width: 240,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 240,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Container(
                    height: 40,
                    width: 56,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      color: Color(0xffF2CB05),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectDateMenu = 0;
                            });
                          },
                          child: const Text(
                            "GÜN",
                            style: TextStyle(
                              fontFamily: 'NEXA4',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 34,
                      width: 20,
                      child: PageView(
                        controller: pageDayController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedDayIndex = index + 1;
                          });
                          print(selectedDayIndex);
                        },
                        children: dayName
                            .map(
                              (year) => Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa3',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 18,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 34,
                      width: 60,
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
                              (year) => Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa3',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 34,
                      width: 48,
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
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Nexa4',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 48,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: Color(0xffF2CB05),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String giderGelirHepsi = 'Gider';
  double buttonHeight = 34; //Basılmamış yükseklik
  double buttonHeight2 = 40; //Basılmış yükseklik
  double buttonHeight3 = 34; //Basılmamış yükseklik
  Color containerColor3 = const Color(0xff0D1C26); //Basılmamış renk
  Color containerColor2 = const Color(0xff0D1C26); //Basılmamış renk
  Color containerColor = const Color(0xffF2CB05); //Basılmış renk
  Color textColor3 = Colors.white; //Basılmamış yazı rengi
  Color textColor2 = Colors.white; //Basılmamış yazı rengi
  Color textColor = const Color(0xff0D1C26); //Basılmış yazı rengi
  int index = 0; // Gider ve Gelir butonları arasında geçiş yapmak için
  Widget GelirGiderButon(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    void changeColor2(int index) {
      if (index == 0) {
        setState(() {
          buttonHeight2 = 40;
          buttonHeight = 34;
          buttonHeight3 = 34;
          containerColor = const Color(0xffF2CB05);
          containerColor2 = const Color(0xff0D1C26);
          containerColor3 = const Color(0xff0D1C26);
          textColor = const Color(0xff0D1C26);
          textColor2 = Colors.white;
          textColor3 = Colors.white;
          //this.index = 1;
        });
      } else if (index == 1) {
        setState(() {
          buttonHeight = 40;
          buttonHeight2 = 34;
          buttonHeight3 = 34;
          containerColor2 = const Color(0xffF2CB05);
          containerColor = const Color(0xff0D1C26);
          containerColor3 = const Color(0xff0D1C26);
          textColor = Colors.white;
          textColor2 = const Color(0xff0D1C26);
          textColor3 = Colors.white;
          //this.index = 0;
        });
      } else {
        setState(() {
          buttonHeight3 = 40;
          buttonHeight2 = 34;
          buttonHeight = 34;
          containerColor3 = const Color(0xffF2CB05);
          containerColor2 = const Color(0xff0D1C26);
          containerColor = const Color(0xff0D1C26);
          textColor = Colors.white;
          textColor2 = Colors.white;
          textColor3 = const Color(0xff0D1C26);
          //this.index = 0;
        });
      }
    }

    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              color: Color(0xff0D1C26),
            ),
            height: 34,
            width: 240,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: containerColor,
                  ),
                  height: buttonHeight2,
                  child: SizedBox(
                    width: 70,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            changeColor2(0);
                            giderGelirHepsi = "Gider";
                          });
                        },
                        child: Text("GİDER",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w800))),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: containerColor2,
                  ),
                  height: buttonHeight,
                  child: SizedBox(
                    width: 70,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            changeColor2(1);
                            giderGelirHepsi = 'Gelir';
                          });
                        },
                        child: Text("GELİR",
                            style: TextStyle(
                                color: textColor2,
                                fontSize: 16,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w800))),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: containerColor3,
                  ),
                  height: buttonHeight3,
                  child: SizedBox(
                    width: 70,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            changeColor2(3);
                            giderGelirHepsi = 'Hepsi';
                          });
                        },
                        child: Text("HEPSİ",
                            style: TextStyle(
                                color: textColor3,
                                fontSize: 16,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w800))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pasta(BuildContext context) {
    var read = ref.read(statisticsRiverpod);
    Future<List<Map<String, dynamic>>> listeeme = read.getCategoryAndAmount(
        validDateMenu,
        giderGelirHepsi,
        selectedYearIndex,
        selectedMonthIndex,
        selectedWeekIndex,
        selectedDayIndex);

    return FutureBuilder(
        future: listeeme,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var item = snapshot.data!; // !
          return DChartPie(
            data: item, // liste buraya gelecek, kategori ismi ve miktar
            fillColor: (pieData, index) {
              return colorsList[index!];
            },
            pieLabel: (pieData, index) {
              return "${pieData['domain']}:\n${pieData['measure']}%";
            },
            labelPosition: PieLabelPosition.outside,
            //donutWidth: 15,
            showLabelLine: true,
            labelColor: Color(0xff0D1C26),
            labelFontSize: 11,
            labelLinelength: 11,
          );
        });
  }

  var colorsList = [
    Colors.red,
    Colors.deepOrange,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.cyanAccent,
    Colors.blue,
    Colors.indigo,
    Colors.pinkAccent,
    Colors.deepPurple,
    Colors.purple,
    Colors.redAccent,
    Colors.redAccent,
    Colors.redAccent,
    Colors.redAccent,
    Colors.redAccent,
  ];
}

class StatisticAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const StatisticAppBar({super.key});
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
              "İSTATİSTİKLER",
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
