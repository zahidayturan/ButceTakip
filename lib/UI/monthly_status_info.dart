import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/pages/daily_info_page.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:butcekontrol/classes/language.dart';


class MonthlyStatusInfo extends ConsumerStatefulWidget {
  const MonthlyStatusInfo({super.key});
  @override
  ConsumerState<MonthlyStatusInfo> createState() => _MonthlyStatusInfoState();
}

class _MonthlyStatusInfoState extends ConsumerState<MonthlyStatusInfo> {

  var renkler = CustomColors();

  @override

  Widget build(BuildContext context) {
    ref.listen(databaseRiverpod, (previous, next) {
      return ref.watch(databaseRiverpod);
    });

    var readDB = ref.read(databaseRiverpod);
    var size = MediaQuery.of(context).size;
    var readHome = ref.read(homeRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    CustomColors renkler = CustomColors();
    return FutureBuilder <Map<String, Map<String, double>>>(
      future: readDB.monthlyStatusInfo(ref),
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, Map<String, double>>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var dailyTotals = snapshot.data;
        double totalExpenses = dailyTotals!
            .values
            .map((totals) => totals['totalAmount2'] ?? 0)
            .fold(0, (prev, amount) => prev + amount);

        double totalIncome = dailyTotals!
            .values
            .map((totals) => totals['totalAmount'] ?? 0)
            .fold(0, (prev, amount) => prev + amount);

        var formattedTotal = totalIncome - totalExpenses;
        var avarageExpenses = dailyTotals.isNotEmpty ? (totalExpenses / dailyTotals.length).toStringAsFixed(2) : "0.00";
/*
        dailyTotals!.forEach((day, totals) {
          print('Day: $day');
          print('Total Amount: ${totals['totalAmount']}');
          print('Total Amount2: ${totals['totalAmount2']}');
          print('Items Length: ${totals['itemsLength']}');
          print('Items Month: ${totals['itemsMonth']}');
          print('Items Year: ${totals['itemsYear']}');
          print('------------------');
        });
        print(totalExpenses);
        print(totalIncome);*/
        double economyScore;

        if (totalIncome >= totalExpenses) {
          if(totalIncome == 0 && totalExpenses == 0){
            economyScore = 10.01;
          }else{
            economyScore = 10.0;
          }
        } else {
          double ratio = totalIncome / totalExpenses;
          economyScore = ratio * 10;
        }
        var sortedList = dailyTotals.entries.toList()
          ..sort((a, b) => b.value['totalAmount2']!.compareTo(a.value['totalAmount2']!));
        var maxTotalAmount2Day =  sortedList.isNotEmpty ? sortedList.first.key : "";
        var maxTotalAmount2Month =  sortedList.isNotEmpty ? sortedList.first.value["itemsMonth"]!.toStringAsFixed(0) : "";
        var maxTotalAmount2Year =  sortedList.isNotEmpty ? sortedList.first.value["itemsYear"]!.toStringAsFixed(0) : "";
        String maxTotalAmount2Date = maxTotalAmount2Day != "" ? "$maxTotalAmount2Day.$maxTotalAmount2Month.$maxTotalAmount2Year" : "Harcama yok";

        return SizedBox(
          height: 184,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8,bottom: 12),
                    child: Container(
                      height: 54,
                      width: size.width,
                      decoration: BoxDecoration(
                    color: Theme.of(context).indicatorColor,
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text("Ortalama günlük harcama tutarı",style: TextStyle(height: 1,fontSize: 15),textAlign: TextAlign.center,)),
                            Container(
                              height: 36,
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: avarageExpenses,
                                          style: TextStyle(
                                            height: 1,
                                            color: Theme.of(context).primaryColor,
                                            fontFamily:
                                            "Nexa4",
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ref.read(settingsRiverpod).prefixSymbol,
                                          style: TextStyle(
                                            height: 1,
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                            "TL",
                                            fontSize: 15,
                                          ),
                                        ),
                                      ])),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6,bottom: 8),
                          child: Container(
                            height: 72,
                            decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Center(child: Text("Ekonomi puanı",
                                    style: TextStyle(
                                    height: 1,
                                    color: Theme.of(context).primaryColor,
                                    fontFamily:
                                    "Nexa3",
                                    fontSize: 15,
                                  ),textAlign: TextAlign.center)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Visibility(
                                        visible: size.width > 320,
                                        child: SizedBox(height: 16,
                                          width: 16,),
                                      ),
                                      RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text:  economyScore != 10.01 ?economyScore.toStringAsFixed(1) : "",
                                              style: TextStyle(
                                                height: 1,
                                                color: Theme.of(context).cardColor,
                                                fontFamily:
                                                "Nexa4",
                                                fontSize: 22,
                                              ),
                                            ),
                                            TextSpan(
                                              text: economyScore != 10.01 ?"/10" : "Henüz Yok",
                                              style: TextStyle(
                                                height: 1,
                                                color: Theme.of(context).primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                "Nexa3",
                                                fontSize: 16,
                                                overflow: TextOverflow.ellipsis
                                              ),
                                            ),
                                          ])),
                                      Visibility(
                                        visible: size.width > 320,
                                        child: Tooltip(
                                          message:  "Aylık olarak gelir gider oranına göre hesaplanan puan",
                                          triggerMode: TooltipTriggerMode.tap,
                                          showDuration: const Duration(seconds: 10),
                                          margin: const EdgeInsets.symmetric(horizontal: 10),
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              color: renkler.arkaRenk,
                                              height: 1),
                                          textAlign: TextAlign.justify,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            const BorderRadius.all(Radius.circular(10)),
                                            color: Theme.of(context).highlightColor,
                                            boxShadow: 1 == 1 ? [
                                              BoxShadow(
                                                color: Colors.black54.withOpacity(0.8),
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
                                              )
                                            ],
                                            border: Border.all(
                                                color: Theme
                                                    .of(context)
                                                    .indicatorColor, // Set border color
                                                width: 1.0),
                                          ),
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).splashColor,
                                                shape: BoxShape.circle
                                            ),
                                            child: Icon(
                                              Icons.question_mark_rounded,
                                              size: 16,
                                              color: Theme
                                                  .of(context)
                                                  .canvasColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      mostSpendCategory(context)
                    ],
                  ),
                  beforeMonthCompare(context,formattedTotal),
                  Padding(
                    padding: const EdgeInsets.only(top: 8,bottom: 8),
                    child: InkWell(
                        onTap: () {
                          if(maxTotalAmount2Date != "Harcama yok"){
                            readHome.setDailyStatus(
                                dailyTotals[maxTotalAmount2Day]!["totalAmount"].toString(),
                                dailyTotals[maxTotalAmount2Day]!["totalAmount2"].toString(),
                                (double.parse(dailyTotals[maxTotalAmount2Day]!["totalAmount"].toString()) - double.parse(dailyTotals[maxTotalAmount2Day]!["totalAmount2"].toString())!).toString());
                            if ((double.parse(dailyTotals[maxTotalAmount2Day]!["totalAmount"].toString()) - double.parse(dailyTotals[maxTotalAmount2Day]!["totalAmount2"].toString())!) <= 0) {
                              readDB.setStatus("-");
                            } else {
                              readDB.setStatus("+");
                            }
                            readDB.setDay(maxTotalAmount2Day);
                            readDailyInfo.setDate(int.parse(maxTotalAmount2Day), int.parse(maxTotalAmount2Month), int.parse(maxTotalAmount2Year));
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DailyInfo()));
                          }
                        },
                      child: Container(
                        height: 54,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context).indicatorColor,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Center(child: Text("En çok harcama yapılan gün",style: TextStyle(height: 1,fontSize: 15,overflow: TextOverflow.ellipsis),textAlign: TextAlign.center,maxLines: 3,))),
                              Container(
                                height: 36,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                         "${maxTotalAmount2Date}",
                                          style: TextStyle(
                                            height: 1,
                                            color: Theme.of(context).canvasColor,
                                            fontFamily:
                                            "Nexa4",
                                            fontSize: 15,
                                          ),
                                        )),
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
          ),
        );
      },
    );
  }
  int pageControllerCategory = 0;
  Widget mostSpendCategory(BuildContext context) {
    var readDB = ref.read(databaseRiverpod);
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return FutureBuilder <List<MapEntry<String, List<double>>>>(
      future: readDB.monthlyStatusInfoForCategory(ref),
      builder: (BuildContext context,
          AsyncSnapshot<List<MapEntry<String, List<double>>>> snapshot) {
        var category = "Harcama yok";
        var categoryAmount = 0.0;
        int categoryCount = 0;
        if (!snapshot.hasData) {
          print("Yüklenecek 22");
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var listItem = snapshot.data;
        if(listItem!.isNotEmpty){
          category = listItem!.first.key;
          categoryAmount = listItem!.first.value[0];
          categoryCount = listItem!.first.value[1].toInt();
        }
        return Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(left: 6,bottom: 8),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                  color: Theme.of(context).indicatorColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: PageView(
                        scrollDirection: Axis.vertical,
                        physics: listItem!.isNotEmpty ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
                        onPageChanged: (value) {
                          setState(() {
                            pageControllerCategory = value;
                          });
                        },
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(child: Text("En çok harcama\nyapılan kategori",style: TextStyle(
                                height: 1,
                                color: Theme.of(context).canvasColor,
                                fontFamily:
                                "Nexa3",
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15,
                              ),textAlign: TextAlign.center,
                              maxLines: 3,)),
                              Text(category,style: TextStyle(
                                height: 1,
                                color: Theme.of(context).secondaryHeaderColor,
                                fontFamily:
                                "Nexa4",
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis,
                              ),textAlign: TextAlign.center)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(child: Text(category,style: TextStyle(
                                  height: 1,
                                  color: Theme.of(context).canvasColor,
                                  fontFamily:
                                  "Nexa3",
                                  fontSize: 15,
                                ),textAlign: TextAlign.center,)),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text:  categoryAmount.toStringAsFixed(2),
                                        style: TextStyle(
                                          height: 1,
                                          color: Theme.of(context).disabledColor,
                                          fontFamily:
                                          "Nexa4",
                                          fontSize: 14,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ref.read(settingsRiverpod).prefixSymbol,
                                        style: TextStyle(
                                          height: 1,
                                          color: Theme.of(context).disabledColor,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                          "TL",
                                          fontSize: 14,
                                        ),
                                      ),
                                    ])),
                                Center(child: Text("${categoryCount.toString()} Kayıt",style: TextStyle(
                                  height: 1,
                                  color: Theme.of(context).canvasColor,
                                  fontFamily:
                                  "Nexa3",
                                  fontSize: 14,
                                ),textAlign: TextAlign.center,)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    listItem!.isNotEmpty ? counterContainer(context,pageControllerCategory) : SizedBox()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int pageController = 0;
  Widget beforeMonthCompare(BuildContext context, double formattedTotal) {
    var readDB = ref.read(databaseRiverpod);
    var size = MediaQuery.of(context).size;
    var readSettings = ref.read(settingsRiverpod);
    CustomColors renkler = CustomColors();

    return FutureBuilder <double>(
      future: readDB.monthlyStatusInfoForCompare(ref),
      builder: (BuildContext context,
          AsyncSnapshot<double> snapshot) {
        double total = 0.0;
        double compare = 0.0;
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var item = snapshot.data;
        item != null ? compare = formattedTotal - item : null;
        item != null ? total = item : null;
        return Padding(
          padding: const EdgeInsets.only(top: 8,bottom: 8),
          child: Container(
            height: 54,
            width: size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).indicatorColor,
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  counterContainer(context,pageController),
                  Expanded(
                    child: PageView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      onPageChanged: (value) {
                        setState(() {
                          pageController = value;
                          print(pageController);
                        });
                      },
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Center(child: Text("Bir önceki aya göre\n net durumun değişimi",style: TextStyle(height: 1,fontSize: 15),textAlign: TextAlign.center,))),
                            Container(
                              height: 36,
                              decoration: BoxDecoration(
                                  color: compare > 0 ? renkler.yesilRenk : renkler.kirmiziRenk,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:  compare.toStringAsFixed(2),
                                          style: TextStyle(
                                            height: 1,
                                            color: renkler.arkaRenk,
                                            fontFamily:
                                            "Nexa4",
                                            fontSize: 15,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ref.read(settingsRiverpod).prefixSymbol,
                                          style: TextStyle(
                                            height: 1,
                                            color: renkler.arkaRenk,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                            "TL",
                                            fontSize: 15,
                                          ),
                                        ),
                                      ])),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Center(child: Text("${readSettings.getMonthInListWithIndex(context,readSettings.monthIndex-1)}",style: TextStyle(height: 1,fontSize: 14),textAlign: TextAlign.center,))),
                            Container(
                              height: 28,
                              decoration: BoxDecoration(
                                  color: total >= 0 ? renkler.yesilRenk : renkler.kirmiziRenk,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:  total.toStringAsFixed(2),
                                          style: TextStyle(
                                            height: 1,
                                            color: renkler.arkaRenk,
                                            fontFamily:
                                            "Nexa4",
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ref.read(settingsRiverpod).prefixSymbol,
                                          style: TextStyle(
                                            height: 1,
                                            color: renkler.arkaRenk,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                            "TL",
                                            fontSize: 14,
                                          ),
                                        ),
                                      ])),
                                ),
                              ),
                            ),
                            Expanded(child: Center(child: Text("${readSettings.getMonthInList(context)}",style: TextStyle(height: 1,fontSize: 14),textAlign: TextAlign.center,))),
                            Container(
                              height: 28,
                              decoration: BoxDecoration(
                                  color: formattedTotal >= 0 ? renkler.yesilRenk : renkler.kirmiziRenk,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:  formattedTotal.toStringAsFixed(2),
                                          style: TextStyle(
                                            height: 1,
                                            color: renkler.arkaRenk,
                                            fontFamily:
                                            "Nexa4",
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ref.read(settingsRiverpod).prefixSymbol,
                                          style: TextStyle(
                                            height: 1,
                                            color: renkler.arkaRenk,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                            "TL",
                                            fontSize: 14,
                                          ),
                                        ),
                                      ])),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget counterContainer(BuildContext context, int pageCount) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 8,
            height: pageCount == 0 ? 24 : 8,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: pageCount == 0
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).canvasColor),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width:  8,
          height: pageCount == 1 ? 24 : 8,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: pageCount == 1
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).canvasColor),
        ),
      ],
    );
  }
}