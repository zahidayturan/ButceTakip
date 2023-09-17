import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Generalinfo extends ConsumerStatefulWidget {
  const Generalinfo({Key? key}) : super(key: key);
  @override
  ConsumerState<Generalinfo> createState() => _Generalinfo();
}

class _Generalinfo extends ConsumerState<Generalinfo> {

  @override
  Widget build(BuildContext context) {
    var readSettings = ref.read(settingsRiverpod);
    var watchhome = ref.watch(homeRiverpod);
    var watchSettings = ref.watch(settingsRiverpod);
    var readdb = ref.read(databaseRiverpod);
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    var read = ref.read(databaseRiverpod);
    return StreamBuilder<Map<String, dynamic>>(
        stream: readdb.myMethod(ref),
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
                                              color: Theme.of(context).disabledColor
                                          ),
                                          width: 208,
                                          height: 26,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: readSettings.currentIndex !=0,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 2),
                                              child: RotatedBox(
                                                quarterTurns: 1,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      readSettings.setIndex(readSettings.currentIndex,1,ref);
                                                      read.setMonthandYear(readSettings.monthIndex.toString(), readSettings.yearIndex.toString());
                                                    });
                                                  },
                                                    onLongPress: () {
                                                      setState(() {
                                                        readSettings.setIndex(readSettings.currentIndex,4,ref);
                                                        read.setMonthandYear(readSettings.monthIndex.toString(), readSettings.yearIndex.toString());
                                                      });
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
                                          ),
                                          Directionality(
                                            textDirection: readSettings.localChanger() == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
                                            child: GestureDetector(
                                              onLongPress: () {
                                                setState(() {
                                                  readSettings.setIndex(readSettings.currentIndex,3,ref);
                                                  read.setMonthandYear(readSettings.monthIndex.toString(), readSettings.yearIndex.toString());
                                                });
                                                },
                                              child: ClipRRect(
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(50)),
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 500),
                                                  curve: Curves.linearToEaseOut,
                                                  height: 32,
                                                  width: (readSettings.currentIndex == 0 || readSettings.currentIndex == 131) ? 186 : 164,
                                                  color: Theme.of(context).highlightColor,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          readSettings.getMonthInList(context),
                                                          style: TextStyle(
                                                            color: renkler.arkaRenk,
                                                            fontSize: 17,
                                                            fontFamily: 'Nexa3',
                                                          ),
                                                        ),
                                                        // Ay gösterge
                                                        const SizedBox(width: 4),
                                                        Text(
                                                          readSettings.years[readSettings.yearIndex-2020],
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
                                          Visibility(
                                            visible: readSettings.currentIndex !=131,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 2),
                                              child: RotatedBox(
                                                quarterTurns: 3,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      readSettings.setIndex(readSettings.currentIndex,0,ref);
                                                      read.setMonthandYear(readSettings.monthIndex.toString(), readSettings.yearIndex.toString());
                                                    });
                                                  },
                                                  onLongPress: () {
                                                    setState(() {
                                                      readSettings.setIndex(readSettings.currentIndex,5,ref);
                                                      read.setMonthandYear(readSettings.monthIndex.toString(), readSettings.yearIndex.toString());
                                                    });
                                                  },
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
                                Directionality(
                                  textDirection: readSettings.localChanger() == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
                                  child: Expanded(
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
                                ), // gelir bilgisi
                                Directionality(
                                  textDirection: readSettings.localChanger() == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
                                  child: Expanded(
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
                                            color: Theme.of(context).disabledColor),
                                        child: FittedBox(
                                          child :   Directionality(
                                        textDirection: readSettings.Language == "العربية" ? TextDirection.rtl : TextDirection.ltr,
                                          child: Row(
                                            children: [
                                              Text(
                                                readdb.getTotalAmount(items)[0],
                                                style: TextStyle(
                                                  fontSize: 19,
                                                  fontFamily: 'Nexa3',
                                                  color: Theme.of(context).canvasColor,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textDirection: TextDirection.ltr,
                                              ),
                                              Text(
                                                readSettings.prefixSymbol!,
                                                style: TextStyle(
                                                  height: 1,
                                                  fontFamily: 'TL',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context).canvasColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ), // toplam bilgisi
                                Directionality(
                                  textDirection: readSettings.localChanger() == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
                                  child: Expanded(
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

}
