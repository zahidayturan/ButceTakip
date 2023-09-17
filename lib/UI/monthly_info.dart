import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/pages/daily_info_page.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constans/text_pref.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:intl/intl.dart' as intl;

class Aylikinfo extends ConsumerStatefulWidget {
  const Aylikinfo({Key? key}) : super(key: key);

  @override
  ConsumerState<Aylikinfo> createState() => _AylikinfoState();
}

class _AylikinfoState extends ConsumerState<Aylikinfo> {
  final ScrollController scrolbarcontroller1 = ScrollController();

  @override
  void dispose() {
    scrolbarcontroller1.dispose();
    super.dispose();
  }
  int indexYear = 0;
  @override
  Widget build(BuildContext context) {
    var readHome = ref.read(homeRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    var read = ref.read(databaseRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    PageController pageController =  PageController(initialPage: readSettings.currentIndex);
    readSettings.setControllerPage(pageController);
    ref.listen(databaseRiverpod, (previous, next) {
      ///buna bir bakılacak ? bunun sayesinde çalışıyor bakacağım
      ref.watch(databaseRiverpod).month;
      ref.watch(databaseRiverpod).isuseinsert;
      return ref.watch(databaseRiverpod);
    });
    CustomColors renkler = CustomColors();
    return Expanded(
      child: StreamBuilder<Map<String, dynamic>>(
          stream: read.myMethod(ref),
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var dailyTotals = snapshot.data!['dailyTotals'];
            return PageView.builder(
              controller: readSettings.pageControllerR,
              itemCount: 132,
              pageSnapping: true,
              onPageChanged: (index) {
                setState(() {
                  print(pageController.page!.toInt());
                  if(pageController.page!.toInt() < index){///arttırma
                      readSettings.setIndex(index, 2, ref);
                  }else if(pageController.page!.toInt() == index){ ///azaltma
                      readSettings.setIndex(index, 2, ref);
                  }
                  print(index);
                  print(readSettings.yearIndex);
                  print(readSettings.monthIndex);
                  read.setMonthandYear(readSettings.monthIndex.toString(), readSettings.yearIndex.toString());
                  readHome.setStatus();
                });
              },
              itemBuilder: (context, index) {
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: Center(
                    child: Padding(
                      //borderin scroll ile birleşimi gözüksü diye soldan padding
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: dailyTotals.length == 0
                          ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/image/noInfo.png",
                                  width: 80,
                                  height: 80,
                                  //color: Theme.of(context).canvasColor,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 22,
                                  width: 85,
                                  child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Theme.of(context).canvasColor,
                                      ),
                                      child: Center(
                                          child: TextMod(
                                              translation(context).noActivity,
                                              Theme.of(context).primaryColor,
                                              14
                                          )
                                      )
                                  ),
                                ),
                              ],
                            ),
                          )
                          : ListView.builder(
                          controller: scrolbarcontroller1,
                          itemCount: dailyTotals.length,
                          itemBuilder: (BuildContext context, index) {
                            var keys = dailyTotals.keys.toList();
                            var day = keys[index];
                            var dayTotals = dailyTotals[day]!;
                            var dayItemLength =  dayTotals['itemsLength']!;
                            var totalAmount = dayTotals['totalAmount']!;
                            var totalAmount2 = dayTotals['totalAmount2']!;
                            var itemMonths = dayTotals['itemsMonth']!;
                            var itemYears = dayTotals['itemsYear']!;
                            final formattedTotal = (totalAmount - totalAmount2).toStringAsFixed(1);
                            var dateTime = DateTime(itemYears.toInt(), itemMonths.toInt(), int.parse(day));
                            var dayOfWeekName = _getDayOfWeekName(dateTime.weekday, context);
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    readHome.setDailyStatus(
                                        totalAmount.toString(),
                                        totalAmount2.toString(),
                                        formattedTotal.toString());
                                    if (double.parse(formattedTotal) <= 0) {
                                      read.setStatus("-");
                                    } else {
                                      read.setStatus("+");
                                    }
                                    read.setDay(day);
                                    readDailyInfo.setDate(int.parse(day), itemMonths.toInt(), itemYears.toInt());
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DailyInfo()));
                                  },
                                  highlightColor: Theme.of(context).dividerColor,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).indicatorColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          color: double.parse(formattedTotal) < 0
                                                              ? renkler.kirmiziRenk
                                                              : renkler.yesilRenk,
                                                          borderRadius: const BorderRadius.only(
                                                            bottomRight: Radius.circular(90),
                                                            bottomLeft: Radius.circular(20),
                                                            topLeft: Radius.circular(50),
                                                            topRight: Radius.circular(20),
                                                          ),
                                                        ),
                                                        height: 18,
                                                        width: 18,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 9, top: 5),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: day,
                                                                style: TextStyle(
                                                                  height: 1,
                                                                  fontFamily: "Nexa4",
                                                                  color: Theme.of(context).canvasColor,
                                                                  fontSize: 19,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: readSettings.monthStartDay! != 1 ?".${itemMonths.toStringAsFixed(0)}" : "",
                                                                style:
                                                                TextStyle(
                                                                  height: 1,
                                                                  fontFamily: "Nexa4",
                                                                  color: Theme.of(context).canvasColor,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(left: 8),
                                                    child: Text(
                                                      dayOfWeekName,
                                                      style: const TextStyle(
                                                        height: 1,
                                                        fontFamily: "Nexa3",
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ), /// sol taraftaki gün sayısı ve gün adı
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: FittedBox(
                                                      child: Directionality(
                                                        textDirection: readSettings.Language == "العربية" ? TextDirection.rtl : TextDirection.ltr,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              (totalAmount - totalAmount2).toStringAsFixed(2).length < 9 ? (totalAmount - totalAmount2).toStringAsFixed(2) : (totalAmount - totalAmount2).toStringAsFixed(0),
                                                              style: TextStyle(
                                                                height: 1,
                                                                color: double.parse(formattedTotal) < 0
                                                                    ? renkler.kirmiziRenk
                                                                    : Theme.of(context).canvasColor,
                                                                fontFamily: "Nexa4",
                                                                fontSize: 17,
                                                              ),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              textDirection: TextDirection.ltr,
                                                            ),
                                                            Text(
                                                              readSettings.prefixSymbol!,
                                                              style: TextStyle(
                                                                height: 1,
                                                                color: double.parse(formattedTotal) < 0
                                                                    ? renkler.kirmiziRenk
                                                                    : Theme.of(context).canvasColor,
                                                                fontFamily: "TL",
                                                                fontSize: 17,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${dayItemLength.toStringAsFixed(0)} ${translation(context).activityCount}",
                                                    style: TextStyle(
                                                      height: 1,
                                                      color: Theme.of(context).canvasColor,
                                                      fontFamily: "Nexa3",
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ), /// ortadaki toplam tutar
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(top: 5),
                                                    child:  FittedBox(
                                                      child: Directionality(
                                                        textDirection: readSettings.localChanger() == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
                                                        child: RichText(
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            text: TextSpan(children: [
                                                              TextSpan(
                                                                text:  totalAmount.toStringAsFixed(2).length < 9 ?  totalAmount.toStringAsFixed(2) : totalAmount.toStringAsFixed(0),
                                                                style: TextStyle(
                                                                  height: 1,
                                                                  color: renkler.yesilRenk,
                                                                  fontFamily: "Nexa3",
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: readSettings.prefixSymbol,
                                                                style: TextStyle(
                                                                  height: 1,
                                                                  color: renkler.yesilRenk,
                                                                  fontFamily: "TL",
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ])),
                                                      ),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    child: Directionality(
                                                      textDirection: readSettings.localChanger() == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
                                                      child: RichText(
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          text: TextSpan(children: [
                                                            TextSpan(
                                                              text:  totalAmount2.toStringAsFixed(2).length < 9 ?  totalAmount2.toStringAsFixed(2) : totalAmount2.toStringAsFixed(1),
                                                              style: TextStyle(
                                                                height: 1,
                                                                color: renkler.kirmiziRenk,
                                                                fontFamily: "Nexa3",
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: readSettings.prefixSymbol,
                                                              style: TextStyle(
                                                                height: 1,
                                                                color: renkler.kirmiziRenk,
                                                                fontFamily: "TL",
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ]
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ), /// sağ taraftaki gelir ve gider tutarları
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6)
                              ],
                            );
                          }),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  Widget eyeColorChoice(String toplam, BuildContext context) {
    CustomColors renkler = CustomColors();
    if (toplam.contains('-')) {
      return Icon(
        Icons.remove_red_eye,
        size: 16,
        color: renkler.kirmiziRenk,
      );
    } else {
      return Icon(Icons.remove_red_eye,
          size: 16, color: Theme.of(context).canvasColor);
    }
  }

  String _getDayOfWeekName(int dayOfWeek, BuildContext context) {
    switch (dayOfWeek) {
      case 1:
        return translation(context).monday;
      case 2:
        return translation(context).tuesday;
      case 3:
        return translation(context).wednesday;
      case 4:
        return translation(context).thursday;
      case 5:
        return translation(context).friday;
      case 6:
        return translation(context).saturday;
      case 7:
        return translation(context).sunday;
      default:
        return '';
    }
  }
}