import 'package:butcekontrol/classes/app_bar_for_page.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/pages/daily_info_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';
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
  CustomColors renkler = CustomColors();
  int initialLabelIndex = 0;
  List<String> dayList = ["1","15","31","24","7","2","3","4","5","6","8","9","10","11","12","13","14","16","17","18","19","20","21","22","23","25","26","27","28","29","30"];
  String? selectedValueDay;
  final TextEditingController customDate = TextEditingController(text: "1");
  Widget dateSelector(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(calendarRiverpod);
    List monthName = read.getMonths(context);
    List yearName = read.getYears();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: size.height * 0.05,
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.all(Radius.circular(20))
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
                  customDate.text = "1";
                  selectedValueDay = "1";
                });
              },
            ),
          ),
        ),
        Stack(
          children: [
            SizedBox(
              width: size.width * 0.53,
              height: size.height * 0.074,
              child: Stack(
                children: [
                  Positioned(
                    top: size.height * 0.007,
                    child: Container(
                      height: size.height * 0.060,
                      width: size.width * 0.52,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xFFF2CB05),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: size.height * 0.060,
                        width: size.width * 0.3,
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
                              widthFactor: 1.5,
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
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          color: Theme.of(context).highlightColor,
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
                                    style: TextStyle(
                                      color: Theme.of(context).dialogBackgroundColor,
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
        ),
        Container(
          height: size.height * 0.05,
          decoration: BoxDecoration(
              color: renkler.sariRenk,
              borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: Center(
              child: TextButton(
                onPressed: () {
                  selectedValueDay = customDate.text;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
                            backgroundColor: Theme.of(context).primaryColor,
                            shadowColor: Colors.black54,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: SizedBox(
                                        width: size.width * 0.95,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Ayın Başlangıç Günü",
                                              style: TextStyle(
                                                  color: Theme.of(context).canvasColor,
                                                  fontFamily: "Nexa4",
                                                  fontSize: 21),
                                            ),
                                            SizedBox(
                                              height: 32,
                                              width: 32,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).canvasColor,
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(20)),
                                                ),
                                                child: IconButton(
                                                  icon: Image.asset(
                                                    "assets/icons/remove.png",
                                                    height: 16,
                                                    width: 16,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                  iconSize: 24,
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    SizedBox(
                                      width : 60,
                                      height : 36,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                          isExpanded: true,
                                          hint: Center(
                                            child: Text(
                                              customDate.text,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Nexa4',
                                                color: renkler.koyuuRenk,
                                              ),
                                            ),
                                          ),
                                          items: dayList
                                              .map((String item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Center(
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        height: 1,
                                                        fontFamily:
                                                        'Nexa4',
                                                        color: renkler
                                                            .koyuuRenk),
                                                  ),
                                                ),
                                              ))
                                              .toList(),
                                          value: selectedValueDay,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedValueDay = value;
                                            });
                                          },
                                          iconStyleData: IconStyleData(
                                            iconSize: 18,
                                            iconDisabledColor: renkler.koyuuRenk,
                                            iconEnabledColor: renkler.koyuuRenk
                                          ),
                                          dropdownStyleData:
                                          DropdownStyleData(
                                            ///açılmış kutu
                                              decoration: BoxDecoration(
                                                color: renkler.arkaRenk,
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                          maxHeight: 120),
                                          buttonStyleData: ButtonStyleData(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              height: 36,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  color: renkler.sariRenk,
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))

                                                ///AÇILMAMIŞ KUTU
                                              )),
                                          menuItemStyleData:
                                          MenuItemStyleData(
                                            ///açılmış kutu
                                            height: 36,
                                            overlayColor:
                                            MaterialStatePropertyAll(
                                                renkler.sariRenk),
                                            padding: const EdgeInsets.all(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState((){
                                                customDate.text = "1";
                                                selectedValueDay = "1";
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).highlightColor,
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Center(
                                                  child: FittedBox(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                                                      child: Text(
                                                        "Varsayılan (1)",
                                                        style: TextStyle(
                                                            color: renkler.arkaRenk,
                                                            fontSize: 15,
                                                            fontFamily: 'Nexa3'),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState((){
                                                customDate.text = selectedValueDay.toString();
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              height: 30,
                                             // width: 100,
                                              decoration: BoxDecoration(
                                                color: renkler.sariRenk,
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Center(
                                                  child: FittedBox(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                                      child: Text(
                                                         "$selectedValueDay Olarak Ayarla",
                                                        style: TextStyle(
                                                            color: renkler.koyuuRenk,
                                                            fontSize: 15,
                                                            fontFamily: 'Nexa3'),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ).then((_) => setState(() {}));
                },
                child: FittedBox(
                  child: Text(
                      customDate.text,style: TextStyle(color: renkler.koyuuRenk,fontSize: 20,height: 1,fontFamily: 'Nexa4'),
                  ),
                ),
              ),
            ),
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
                      decoration: BoxDecoration(
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
                            "-0.0  ",
                            style: TextStyle(
                              color:  Colors.white,
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
                      decoration: BoxDecoration(
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
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xffF2CB05),
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
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Theme.of(context).dividerColor,
            border: Border.all(color: Theme.of(context).focusColor,width: 1,strokeAlign: BorderSide.strokeAlignOutside),
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
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Theme.of(context).highlightColor,
          ),
          child: Center(
            child: Text(
              day,
              style: const TextStyle(
                color: Color(0xFFE9E9E9),
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
                        child: Text(
                          translation(context).dataForTheDayNotFound,
                          style: const TextStyle(
                            fontFamily: 'Nexa3',
                            fontSize: 18,
                            color: Color(0xFFE9E9E9),
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
            child: Text(
              date > 0 ? date.toString() : "",
              style: TextStyle(
                color: month == selectedMonthIndex
                    ? Theme.of(context).canvasColor
                    : Theme.of(context).indicatorColor,
                fontSize: 20,
                fontFamily: 'Nexa3',
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
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