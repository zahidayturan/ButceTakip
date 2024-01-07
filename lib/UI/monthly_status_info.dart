import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/pages/daily_info_page.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/textConverter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:intl/intl.dart' as intl;


class MonthlyStatusInfo extends ConsumerStatefulWidget {
  const MonthlyStatusInfo({super.key});
  @override
  ConsumerState<MonthlyStatusInfo> createState() => _MonthlyStatusInfoState();
}

class _MonthlyStatusInfoState extends ConsumerState<MonthlyStatusInfo> {

  var renkler = CustomColors();

  @override
  bool avarageSizeController = false;
  Widget build(BuildContext context) {
    ref.listen(databaseRiverpod, (previous, next) {
      return ref.watch(databaseRiverpod);
    });

    var readDB = ref.read(databaseRiverpod);
    var size = MediaQuery.of(context).size;
    var readHome = ref.read(homeRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    var readSetting = ref.read(settingsRiverpod);
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
        int totalAmount2Includes = dailyTotals!.values.where((temp) => temp['totalAmount2'] != 0).length;

        double totalExpenses = dailyTotals!
            .values
            .map((totals) => totals['totalAmount2'] ?? 0)
            .fold(0, (prev, amount) => prev + amount);

        double totalIncome = dailyTotals!
            .values
            .map((totals) => totals['totalAmount'] ?? 0)
            .fold(0, (prev, amount) => prev + amount);

        var formattedTotal = totalIncome - totalExpenses;
        var avarageExpenses = totalAmount2Includes !=0 ? (totalExpenses / totalAmount2Includes).toStringAsFixed(2) : "0.00";

        double economyScore;
        if (totalIncome >= totalExpenses) {
          if(totalIncome == 0 && totalExpenses == 0){
            economyScore = 10.01;
          }else{
            economyScore = 10.0;
          }
        }
        else if(totalIncome ==0 && totalExpenses !=0){
          double ratio = (totalIncome / totalExpenses);
          economyScore = ratio * 10;
        }
        else {
          double ratio = (totalIncome / totalExpenses)-0.01;
          economyScore = ratio * 10;
        }
        var sortedList = dailyTotals.entries.toList()
          ..sort((a, b) => b.value['totalAmount2']!.compareTo(a.value['totalAmount2']!));
        var maxTotalAmount2Day =  sortedList.isNotEmpty ? sortedList.first.key : "";
        var maxTotalAmount2Month =  sortedList.isNotEmpty ? sortedList.first.value["itemsMonth"]!.toStringAsFixed(0) : "";
        var maxTotalAmount2Year =  sortedList.isNotEmpty ? sortedList.first.value["itemsYear"]!.toStringAsFixed(0) : "";
        String getDateForMaxDay(){
          var readSettings = ref.read(settingsRiverpod);
          if(maxTotalAmount2Day != ""){
            DateTime date = DateTime(int.parse(maxTotalAmount2Year),int.parse(maxTotalAmount2Month),int.parse(maxTotalAmount2Day));
            String formattedDate = intl.DateFormat(readSettings.dateFormat).format(date);
            return formattedDate;
          }else{
            return translation(context).noSpending;
          }
        }
        String maxTotalAmount2Date = maxTotalAmount2Day != "" ? "$maxTotalAmount2Day.$maxTotalAmount2Month.$maxTotalAmount2Year" : translation(context).noSpending;
        // ${readSettings.getMonthInList(context)} ${readSettings.yearIndex.toString()}
        DateTime date = DateTime(readSetting.yearIndex,readSetting.monthIndex+1,0);
        return SizedBox(
          height: 184,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:4,bottom: 12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      height: avarageSizeController == false ? 54 : 90,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).indicatorColor,
                          borderRadius: const BorderRadius.all(Radius.circular(15))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Directionality(
                          textDirection: ref.read(settingsRiverpod).Language == "العربية" ? TextDirection.rtl : TextDirection.ltr,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if(avarageSizeController == false){
                                          avarageSizeController = true;
                                        }else{
                                          avarageSizeController = false;
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 23,
                                      width: 23,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).secondaryHeaderColor,
                                        shape: BoxShape.circle,
                                        //borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                      child: Center(
                                        child: Icon(
                                          avarageSizeController == false ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined,
                                          color: renkler.yaziRenk,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Text(translation(context).dailyAverageSpending,style: const TextStyle(height: 1,fontSize: 15),textAlign: TextAlign.center,)),
                                  Container(
                                    height: 36,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).secondaryHeaderColor,
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
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
                                                  fontFamily: "Nexa4",
                                                  fontSize: 15,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ref.read(settingsRiverpod).prefixSymbol,
                                                style: TextStyle(
                                                  height: 1,
                                                  color: Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "TL",
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ])),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              AnimatedPadding(
                                duration: const Duration(milliseconds: 600),
                                padding: EdgeInsets.only(top: avarageSizeController == false ? 0 :6),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  height: avarageSizeController == false ? 0 :36,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Row(
                                                children: [
                                                  Text(translation(context).monthlyExpensesWithoutEnter),
                                                  const Text(" / "),
                                                  Text("${date.day}"),
                                                ],
                                              )),/// aylik gider / ay  kaç gün ise
                                          RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: (totalExpenses/date.day).toStringAsFixed(2),
                                                  style: TextStyle(
                                                    height: 1,
                                                    color: Theme.of(context).canvasColor,
                                                    fontFamily: "Nexa4",
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ref.read(settingsRiverpod).prefixSymbol,
                                                  style: TextStyle(
                                                    height: 1,
                                                    color: Theme.of(context).canvasColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "TL",
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ])),
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
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6,bottom: 6),
                          child: Container(
                            height: 72,
                            decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: const BorderRadius.all(Radius.circular(15))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Center(child: Text(translation(context).spendingScore,
                                      style: TextStyle(
                                        height: 1,
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: "Nexa3",
                                        fontSize: 15,
                                      ),textAlign: TextAlign.center)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Visibility(
                                        visible: size.width > 324,
                                        child: const SizedBox(height: 16,
                                          width: 16,),
                                      ),
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              economyScore != 10.01 ?economyScore.toStringAsFixed(1) : "",
                                              style: TextStyle(
                                                height: 1,
                                                color: Theme.of(context).cardColor,
                                                fontFamily: "Nexa4",
                                                fontSize: 22,
                                              ),
                                            ),
                                            Visibility(
                                              visible: size.width > 324,
                                              child: Text(
                                                economyScore != 10.01 ?"/10" : translation(context).noResult,
                                                style: TextStyle(
                                                    height: 1,
                                                    color: Theme.of(context).primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Nexa3",
                                                    fontSize: 16,
                                                    overflow: TextOverflow.ellipsis
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: size.width > 324,
                                        child: Tooltip(
                                          message:  translation(context).monthlyIncomeExpenseScore,
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
                                                color: Theme.of(context).indicatorColor, // Set border color
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
                                              color: Theme.of(context).canvasColor,
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
                    padding: const EdgeInsets.only(top: 6,bottom: 6),
                    child: InkWell(
                      highlightColor: Theme.of(context).scaffoldBackgroundColor,
                      onTap: () {
                        if(maxTotalAmount2Date != translation(context).noSpending){
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
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Theme.of(context).highlightColor,
                                duration: const Duration(seconds: 1),
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                content: Center(
                                  child: Text(
                                    translation(context).dataNotFound,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Nexa3',
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                  ),
                                ),
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 54,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context).indicatorColor,
                            borderRadius: const BorderRadius.all(Radius.circular(15))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Directionality(
                            textDirection: ref.read(settingsRiverpod).Language == "العربية" ? TextDirection.rtl : TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Center(child: Text(translation(context).mostSpendingDay,style: const TextStyle(height: 1,fontSize: 15,overflow: TextOverflow.ellipsis),textAlign: TextAlign.center,maxLines: 3,))),
                                Container(
                                  height: 36,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Center(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text(
                                          getDateForMaxDay(),
                                          style: TextStyle(
                                            height: 1,
                                            color: Theme.of(context).canvasColor,
                                            fontFamily: "Nexa4",
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
                  ),
                  mostExpensiveSpending(context),
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
        var category = translation(context).noSpending;
        var categoryAmount = 0.0;
        int categoryCount = 0;
        if (!snapshot.hasData) {
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
            padding: const EdgeInsets.only(left: 6,bottom: 6),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                  color: Theme.of(context).indicatorColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: PageView(
                        scrollDirection: Axis.vertical,
                        physics: listItem!.isNotEmpty ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
                        onPageChanged: (value) {
                          setState(() {
                            pageControllerCategory = value;
                          });
                        },
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(child: Text(translation(context).mostSpendingCategory,style: TextStyle(
                                height: 1,
                                color: Theme.of(context).canvasColor,
                                fontFamily: "Nexa3",
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15,
                              ),textAlign: TextAlign.center,
                                maxLines: 3,)),
                              Text(Converter().textConverterFromDB(category, context, 0),style: TextStyle(
                                height: 1,
                                color: Theme.of(context).secondaryHeaderColor,
                                fontFamily: "Nexa4",
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
                                Center(child: Text(Converter().textConverterFromDB(category, context, 0),style: TextStyle(
                                  height: 1,
                                  color: Theme.of(context).canvasColor,
                                  fontFamily: "Nexa3",
                                  fontSize: 15,
                                ),textAlign: TextAlign.center,)),
                                Directionality(
                                  textDirection: ref.read(settingsRiverpod).Language == "العربية" ? TextDirection.rtl : TextDirection.ltr,
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:  categoryAmount.toStringAsFixed(2),
                                          style: TextStyle(
                                            height: 1,
                                            color: Theme.of(context).disabledColor,
                                            fontFamily: "Nexa4",
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ref.read(settingsRiverpod).prefixSymbol,
                                          style: TextStyle(
                                            height: 1,
                                            color: Theme.of(context).disabledColor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "TL",
                                            fontSize: 14,
                                          ),
                                        ),
                                      ])),
                                ),
                                Center(child: Text("${categoryCount.toString()} ${translation(context).activityCount}",style: TextStyle(
                                  height: 1,
                                  color: Theme.of(context).canvasColor,
                                  fontFamily: "Nexa3",
                                  fontSize: 14,
                                ),textAlign: TextAlign.center,)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    listItem!.isNotEmpty ? counterContainer(context,pageControllerCategory) : const SizedBox()
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
          padding: const EdgeInsets.only(top: 6,bottom: 6),
          child: Container(
            height: 54,
            width: size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).indicatorColor,
                borderRadius: const BorderRadius.all(Radius.circular(15))
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Directionality(
                textDirection: ref.read(settingsRiverpod).Language == "العربية" ? TextDirection.rtl : TextDirection.ltr,
                child: Row(
                  children: [
                    counterContainer(context,pageController),
                    Expanded(
                      child: PageView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
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
                              Expanded(child: Center(child: Text(translation(context).changeInNetSpending,style: const TextStyle(height: 1,fontSize: 15),textAlign: TextAlign.center,))),
                              Container(
                                height: 36,
                                decoration: BoxDecoration(
                                    color: compare >= 0 ? renkler.yesilRenk : renkler.kirmiziRenk,
                                    borderRadius: const BorderRadius.all(Radius.circular(10))
                                ),
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: Text(
                                              compare.toStringAsFixed(2),
                                              style: TextStyle(
                                                height: 1,
                                                color: renkler.arkaRenk,
                                                fontFamily: "Nexa4",
                                                fontSize: 15,
                                              ),
                                              textDirection: TextDirection.ltr,

                                            ),
                                          ),
                                          Text(
                                            ref.read(settingsRiverpod).prefixSymbol!,
                                            style: TextStyle(
                                              height: 1,
                                              color: renkler.arkaRenk,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "TL",
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Center(child: Text(readSettings.getMonthInListWithIndex(context,readSettings.monthIndex-1),style: const TextStyle(height: 1,fontSize: 14),textAlign: TextAlign.center,))),
                              Container(
                                height: 28,
                                decoration: BoxDecoration(
                                    color: total >= 0 ? renkler.yesilRenk : renkler.kirmiziRenk,
                                    borderRadius: const BorderRadius.all(Radius.circular(10))
                                ),
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            total.toStringAsFixed(2),
                                            style: TextStyle(
                                              height: 1,
                                              color: renkler.arkaRenk,
                                              fontFamily: "Nexa4",
                                              fontSize: 14,
                                            ),
                                            textDirection: TextDirection.ltr,

                                          ),
                                          Text(
                                            ref.read(settingsRiverpod).prefixSymbol!,
                                            style: TextStyle(
                                              height: 1,
                                              color: renkler.arkaRenk,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "TL",
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ),
                              Expanded(child: Center(child: Text(readSettings.getMonthInList(context),style: const TextStyle(height: 1,fontSize: 14),textAlign: TextAlign.center,))),
                              Container(
                                height: 28,
                                decoration: BoxDecoration(
                                    color: formattedTotal >= 0 ? renkler.yesilRenk : renkler.kirmiziRenk,
                                    borderRadius: const BorderRadius.all(Radius.circular(10))
                                ),
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            formattedTotal.toStringAsFixed(2),
                                            style: TextStyle(
                                              height: 1,
                                              color: renkler.arkaRenk,
                                              fontFamily: "Nexa4",
                                              fontSize: 14,
                                            ),
                                            textDirection: TextDirection.ltr,

                                          ),
                                          Text(
                                            ref.read(settingsRiverpod).prefixSymbol!,
                                            style: TextStyle(
                                              height: 1,
                                              color: renkler.arkaRenk,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "TL",
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      )
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
          ),
        );
      },
    );
  }

  Widget mostExpensiveSpending(BuildContext context) {
    var readDB = ref.read(databaseRiverpod);
    var size = MediaQuery.of(context).size;
    var readSettings = ref.read(settingsRiverpod);
    CustomColors renkler = CustomColors();

    return FutureBuilder <List<SpendInfo>>(
      future: readDB.monthlyStatusInfoForMostExpenses(ref),
      builder: (BuildContext context,
          AsyncSnapshot<List<SpendInfo>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var item = snapshot.data;
        SpendInfo mostExpensiveSpending = item!.isNotEmpty ? item[0] : SpendInfo("", "", "", 0, 0.00, "", "", "", "", "", "", "", "", 0.00, "", "");
        return Padding(
          padding: const EdgeInsets.only(top: 6,bottom: 6),
          child: InkWell(
            highlightColor: Theme.of(context).scaffoldBackgroundColor,
            onTap: () {
              if(item.isNotEmpty){
                var readDailyInfo = ref.read(dailyInfoRiverpod);
                readDailyInfo.setSpendDetail([item[0]], 0);
                showModalBottomSheet(
                  isScrollControlled:true,
                  context: context,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                  backgroundColor:
                  renkler.koyuuRenk,
                  builder: (context) {
                    //ref.watch(databaseRiverpod).updatest;
                    // genel bilgi sekmesi açılıyor.
                    return const SpendDetail();
                  },
                );
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: Theme.of(context).highlightColor,
                      duration: const Duration(seconds: 1),
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      content: Center(
                        child: Text(
                          translation(context).dataNotFound,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Nexa3',
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))
                  ),
                );
              }
            },
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 54,
                    //width: size.width-54,
                    decoration: BoxDecoration(
                        color: Theme.of(context).indicatorColor,
                        borderRadius: const BorderRadius.all(Radius.circular(15))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Directionality(
                        textDirection: ref.read(settingsRiverpod).Language == "العربية" ? TextDirection.rtl : TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Center(child: Text(translation(context).mostExpensiveSpending,style: const TextStyle(height: 1,fontSize: 15,overflow: TextOverflow.ellipsis),textAlign: TextAlign.center,maxLines: 2,))),
                            Container(
                              height: 36,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: Text(
                                            mostExpensiveSpending.amount != 0.0 ?mostExpensiveSpending.realAmount.toString() : translation(context).noSpending,
                                            style: TextStyle(
                                              height: 1,
                                              color: mostExpensiveSpending.amount != 0.0 ? renkler.kirmiziRenk : Theme.of(context).canvasColor,
                                              fontFamily: "Nexa4",
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          ref.read(settingsRiverpod).prefixSymbol!,
                                          style: TextStyle(
                                            height: 1,
                                            color: mostExpensiveSpending.amount != 0.0 ? renkler.kirmiziRenk : Theme.of(context).canvasColor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "TL",
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        shape: BoxShape.circle
                    ),
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Theme.of(context).unselectedWidgetColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
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
          padding: const EdgeInsets.all(2.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: pageCount == 1 ? 8 : 6,
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
          width: pageCount == 0 ? 8 : 6,
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