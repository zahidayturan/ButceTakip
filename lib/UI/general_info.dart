import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Generalinfo extends ConsumerWidget {
  //statelesswidget
  const Generalinfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> months = [
      translation(context).january,
      translation(context).february,
      translation(context).march,
      translation(context).april,
      translation(context).may,
      translation(context).june,
      translation(context).july,
      translation(context).august,
      translation(context).september,
      translation(context).october,
      translation(context).november,
      translation(context).december,
    ];
    List<String> years = [
      "2020",
      "2021",
      "2022",
      "2023",
      "2024",
      "2025",
      "2026",
      "2027",
      "2028",
      "2029",
      "2030"
    ];
    var readhome = ref.read(homeRiverpod);
    var watchhome = ref.watch(homeRiverpod);
    var readdb = ref.read(databaseRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    //watchhome.refrestst;
    int indexyear = watchhome.indexyear;
    int indexmounth = watchhome.indexmounth;
    return StreamBuilder<Map<String, dynamic>>(
        stream: readdb.myMethod(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //var dailyTotals = snapshot.data!['dailyTotals'];
          var items = snapshot.data!['items'];
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: double.infinity, //container in boyutunu içindekiler belirliyor.
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: renkler.yesilRenk,
                        ),
                        height: 62,
                        width: 6,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  translation(context).monthlyIncome,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: 15,
                                      fontFamily: 'Nexa3',
                                      color: Theme.of(context).canvasColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                                              color: renkler.sariRenk
                                          ),
                                          width: 208,
                                          height: 26,
                                        ),
                                      ),
                                      Row(
                                        //Tarih bilgisini değiştirebilme
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 2),
                                            child: RotatedBox(
                                              quarterTurns: 1,
                                              child: InkWell(
                                                //alignment: Alignment.topCenter,
                                                //padding: EdgeInsets.zero,
                                                onTap: () {
                                                  if (indexmounth > 0) {
                                                    indexmounth -= 1;
                                                  } else {
                                                    if (indexyear != 0) {
                                                      indexyear -= 1;
                                                      indexmounth = 11;
                                                    }
                                                  }
                                                  readhome.controllerPageMontly!.jumpToPage(indexmounth + 1);
                                                  //readhome.controllerPageMontly!.animateToPage(indexmounth, duration: Duration(milliseconds: 100), curve: Curves.linear);
                                                  readhome.changeindex(indexmounth, indexyear);
                                                  readdb.setMonthandYear((indexmounth + 1).toString(), years[indexyear]);
                                                },
                                                  highlightColor: Theme.of(context).indicatorColor,
                                                child: SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: Image.asset(
                                                    "assets/icons/arrow.png",
                                                    color: renkler.koyuuRenk,
                                                  ),
                                                )
                                              ),
                                            ),
                                          ),
                                          Directionality(
                                            textDirection: readSettings.localChanger() == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
                                            child: GestureDetector(
                                              onTap: () {
                                                readhome.controllerPageMontly!.jumpToPage(DateTime.now().month);
                                                readhome.changeindex(DateTime.now().month-1, DateTime.now().year-2020);
                                                readdb.setMonthandYear(DateTime.now().month.toString(), DateTime.now().year.toString());
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(50)),
                                                child: Container(
                                                  height: 32,
                                                  width: 164,
                                                  color: Theme.of(context).highlightColor,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          months[readhome.indexmounth],
                                                          style: TextStyle(
                                                            color: renkler.arkaRenk,
                                                            fontSize: 17,
                                                            fontFamily: 'Nexa3',
                                                          ),
                                                        ),
                                                        // Ay gösterge
                                                        const SizedBox(width: 4),
                                                        Text(
                                                          years[readhome.indexyear],
                                                          style: TextStyle(
                                                            color: renkler.arkaRenk,
                                                            fontSize: 17,
                                                            fontFamily: 'Nexa4',
                                                          ),
                                                        ),
                                                        // Yıl gösterge
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 2),
                                            child: RotatedBox(
                                              quarterTurns: 3,
                                              child: InkWell(
                                                //padding: EdgeInsets.zero,
                                                //alignment: Alignment.topCenter,
                                                onTap: () {
                                                  if (indexmounth < months.length - 1) {
                                                    indexmounth += 1;
                                                  } else if (indexyear < years.length - 1) {
                                                    indexmounth = 0;
                                                    indexyear += 1;
                                                  }
                                                  readhome.controllerPageMontly!.jumpToPage(indexmounth + 1);
                                                  readhome.changeindex(indexmounth, indexyear);
                                                  readdb.setMonthandYear((indexmounth + 1).toString(), years[indexyear]);
                                                },
                                                highlightColor: Theme.of(context).indicatorColor,
                                                child: SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: Image.asset(
                                                    "assets/icons/arrow.png",
                                                    color: renkler.koyuuRenk,
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
                                Text(
                                  translation(context).monthlyExpenses,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: 15,
                                      fontFamily: 'Nexa3',
                                      color: Theme.of(context).canvasColor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 18,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Tooltip(
                                      message: "${readdb.getTotalAmountPositive(items)[1]} ${readSettings.prefixSymbol}",
                                      triggerMode: TooltipTriggerMode.tap,
                                      showDuration: const Duration(seconds: 2),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          color: renkler.arkaRenk,
                                          fontFamily: 'TL',
                                          fontWeight: FontWeight.bold,
                                          height: 1),
                                      textAlign: TextAlign.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(10)),
                                          color: renkler.yesilRenk),
                                      child: FittedBox(
                                        child: RichText(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(children: [
                                          TextSpan(
                                            text: readdb
                                                .getTotalAmountPositive(items)[0],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Nexa3',
                                              color: renkler.yesilRenk,
                                            ),
                                          ),
                                          TextSpan(
                                            text: readSettings.prefixSymbol,
                                            style: TextStyle(
                                              fontFamily: 'TL',
                                              height: 1,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: renkler.yesilRenk,
                                            ),
                                          ),
                                        ])),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Tooltip(
                                      message: "${readdb.getTotalAmount(items)[1]} ${readSettings.prefixSymbol}",
                                      triggerMode: TooltipTriggerMode.tap,
                                      showDuration: const Duration(seconds: 2),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          color: renkler.koyuuRenk,
                                          fontFamily: 'TL',
                                          fontWeight: FontWeight.bold,
                                          height: 1),
                                      textAlign: TextAlign.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(10)),
                                          color: renkler.sariRenk),
                                      child: FittedBox(
                                        child: RichText(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(children: [
                                          TextSpan(
                                            text: readdb.getTotalAmount(items)[0],
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontFamily: 'Nexa3',
                                              color: Theme.of(context).canvasColor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: readSettings.prefixSymbol,
                                            style: TextStyle(
                                              height: 1,
                                              fontFamily: 'TL',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).canvasColor,
                                            ),
                                          ),
                                        ])),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Tooltip(
                                      message: "${readdb.getTotalAmountNegative(items)[1]} ${readSettings.prefixSymbol}",
                                      triggerMode: TooltipTriggerMode.tap,
                                      showDuration: const Duration(seconds: 2),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          color: renkler.arkaRenk,
                                          fontFamily: 'TL',
                                          fontWeight: FontWeight.bold,
                                          height: 1),
                                      textAlign: TextAlign.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(10)),
                                          color: renkler.kirmiziRenk),
                                      child: FittedBox(
                                        child: RichText(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(children: [
                                          TextSpan(
                                            text: readdb
                                                .getTotalAmountNegative(items)[0],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Nexa3',
                                              color: renkler.kirmiziRenk,
                                            ),
                                          ),
                                          TextSpan(
                                            text: readSettings.prefixSymbol,
                                            style: TextStyle(
                                              height: 1,
                                              fontFamily: 'TL',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: renkler.kirmiziRenk,
                                            ),
                                          ),
                                        ])),
                                      ),
                                    ),
                                  ),
                                ), // gider bilgisi
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          color: renkler.kirmiziRenk,
                        ),
                        height: 62,
                        width: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  InlineSpan textChange(String text, String value, amount) {
    return amount <= 99999
        ? TextSpan(text: '$text ')
        : TextSpan(text: '$value ');
  }
}
