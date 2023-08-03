import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/pages/daily_info_page.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constans/text_pref.dart';

class Aylikinfo extends ConsumerWidget {
  const Aylikinfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrolbarcontroller1 = ScrollController();
    var read = ref.read(databaseRiverpod);
    var readHome = ref.read(homeRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    ref.listen(databaseRiverpod, (previous, next) {
      ///bune mk bakılacak ? bunun sayesinde çlaışıyor bakıcam
      ref.watch(databaseRiverpod).month;
      ref.watch(databaseRiverpod).isuseinsert;
      return ref.watch(databaseRiverpod);
    });
    CustomColors renkler = CustomColors();
    var ceyrekwsize = MediaQuery.of(context).size.width / 5;
    var size = MediaQuery.of(context).size;
    var abuzer = 1;
    return Expanded(
            child: StreamBuilder<Map<String, dynamic>>(
                stream: read.myMethod(),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var dailyTotals = snapshot.data!['dailyTotals'];
                  var items = snapshot.data!["items"];
                  return Center(
                    child: Padding(
                      //borderin scroll ile birleşimi gözüksü diye soldan padding
                      padding:
                          const EdgeInsets.only(left: 4.0, top: 8, bottom: 4),
                      child: dailyTotals.length == 0
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/image/origami_noinfo.png",
                                    width: 45,
                                    height: 45,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                  SizedBox(
                                    height: 22,
                                    width: 85,
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                          color: Theme.of(context).canvasColor,
                                        ),
                                        child: Center(child: TextMod(
                                            "Kayıt Yok", Theme.of(context).primaryColor, 14))
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.fromSwatch(
                                    accentColor: Color(0xFFF2CB05),
                                  ),
                                  scrollbarTheme: ScrollbarThemeData(
                                thumbColor:
                                    MaterialStateProperty.all(Theme.of(context).dialogBackgroundColor,),
                              )),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 1.6),
                                    child: Container(
                                      width: 4,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                          color: dailyTotals.length <= 9
                                              ? Theme.of(context).indicatorColor
                                              : Theme.of(context).canvasColor),
                                    ),
                                  ),
                                  Scrollbar(
                                    controller: scrolbarcontroller1,
                                    thumbVisibility: true,
                                    scrollbarOrientation:
                                        ScrollbarOrientation.left,
                                    interactive: true,
                                    thickness: 7,
                                    radius: const Radius.circular(15.0),
                                    child: ListView.builder(
                                        controller: scrolbarcontroller1,
                                        itemCount: dailyTotals.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          var keys = dailyTotals.keys.toList();
                                          var day = keys[index];
                                          var month = read.month;
                                          var year = read.year;
                                          var dayTotals = dailyTotals[day]!;
                                          var totalAmount =
                                              dayTotals['totalAmount']!;
                                          var totalAmount2 =
                                              dayTotals['totalAmount2']!;
                                          final formattedTotal =
                                              (totalAmount - totalAmount2)
                                                  .toStringAsFixed(1);
                                          var dateTime = DateTime(
                                              int.parse(year),
                                              int.parse(month),
                                              int.parse(day));
                                          var dayOfWeekName = _getDayOfWeekName(
                                              dateTime.weekday);
                                          return Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15, right: 10),
                                                child: ClipRRect(
                                                  //Borderradius vermek için kullanıyoruz
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      readHome.setDailyStatus(
                                                          totalAmount
                                                              .toString(),
                                                          totalAmount2
                                                              .toString(),
                                                          formattedTotal
                                                              .toString());
                                                      if (double.parse(
                                                              formattedTotal) <=
                                                          0) {
                                                        read.setStatus("-");
                                                      } else {
                                                        read.setStatus("+");
                                                      }
                                                      read.setDay(day);
                                                      read.setDate(items[index]
                                                          .operationDate);
                                                      readDailyInfo.setDate(
                                                          int.parse(day),
                                                          int.parse(month),
                                                          int.parse(year));
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const DailyInfo()));
                                                    },
                                                    child: Container(
                                                      height: 28,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(10)
                                                        ),

                                                        color: Theme.of(context).indicatorColor,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 12,
                                                                right: 6),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 4),
                                                              child: SizedBox(
                                                                  width:
                                                                      ceyrekwsize,
                                                                  child: RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Nexa3',
                                                                        fontSize:
                                                                            14,
                                                                            color: Theme.of(context).canvasColor,
                                                                      ),
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              '$day ',
                                                                          style: const TextStyle(
                                                                              fontFamily:
                                                                                  'Nexa3',
                                                                              fontWeight:
                                                                                  FontWeight.w900,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              dayOfWeekName,
                                                                          style: const TextStyle(
                                                                              fontFamily:
                                                                                  'Nexa3',
                                                                              fontSize:
                                                                                  14),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 4),
                                                              child: SizedBox(
                                                                width:
                                                                    ceyrekwsize,
                                                                child: Center(
                                                                  child: Text(
                                                                    totalAmount.toStringAsFixed(1),
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Nexa3',
                                                                      fontSize:
                                                                          14,
                                                                      color: renkler.yesilRenk
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 4),
                                                              child: SizedBox(
                                                                width:
                                                                    ceyrekwsize,
                                                                child: Center(
                                                                  child: Text(
                                                                    totalAmount2.toStringAsFixed(1),
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Nexa3',
                                                                      fontSize:
                                                                          14,
                                                                      color: renkler
                                                                          .kirmiziRenk,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 5,top: 4),
                                                              child: SizedBox(
                                                                width:
                                                                    ceyrekwsize,
                                                                child: Text(
                                                                  '$formattedTotal',
                                                                  textAlign: TextAlign.right,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Nexa3',
                                                                    fontSize:
                                                                        14,
                                                                        color: Theme.of(context).canvasColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            eyeColorChoice(
                                                                formattedTotal,context),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 6)
                                              // elemanlar arasına bşluk bırakmak için kulllandım.
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  );
                }),
          );
  }

  Widget eyeColorChoice(String toplam, BuildContext context) {
    CustomColors renkler = CustomColors();
    if (toplam.contains('-')) {
      return Icon(
        Icons.remove_red_eye,
        color: renkler.kirmiziRenk,
      );
    } else {
      return Icon(Icons.remove_red_eye, color: Theme.of(context).canvasColor);
    }
  }

  String _getDayOfWeekName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Pzt';
      case 2:
        return 'Sal';
      case 3:
        return 'Çar';
      case 4:
        return 'Per';
      case 5:
        return 'Cum';
      case 6:
        return 'Cts';
      case 7:
        return 'Paz';
      default:
        return '';
    }
  }
}
