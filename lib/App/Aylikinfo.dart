import 'package:butcekontrol/Pages/gunlukpage.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/utils/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class Aylikinfo extends StatefulWidget {
  const Aylikinfo({Key ? key}) : super(key : key) ;
  @override
  State<Aylikinfo> createState() => _AylikinfoState();
}

class _AylikinfoState extends State<Aylikinfo> {
  final ScrollController Scrolbarcontroller1 = ScrollController();
  CustomColors renkler = CustomColors();

  static String month = "3";
  static String year = "2023";

  static Stream<Map<String, Object>> myMethod() async* {
    while (true) {
      List<spendinfo> items =
          await SQLHelper.getItemsByOperationMonthAndYear(month, year);
      var groupedItems = groupBy(items, (item) => item.operationDay);
      var dailyTotals = <String, Map<String, double>>{};
      groupedItems.forEach((day, dayItems) {
        double totalAmount = dayItems
            .where((element) => element.operationType == 'Gelir')
            .fold(
                0, (previousValue, element) => previousValue + element.amount!);
        double totalAmount2 = dayItems
            .where((element) => element.operationType == 'Gider')
            .fold(
                0, (previousValue, element) => previousValue + element.amount!);
        dailyTotals[day!] = {
          'totalAmount': totalAmount,
          'totalAmount2': totalAmount2
        };
      });
      dailyTotals = Map.fromEntries(dailyTotals.entries.toList()
        ..sort((e1, e2) => int.parse(e2.key).compareTo(int.parse(e1.key))));
      yield {'items': items, 'dailyTotals': dailyTotals};
      await Future.delayed(const Duration(seconds: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    var ceyrekwsize = MediaQuery.of(context).size.width / 5;
<<<<<<< Updated upstream
    ScrollController Scrolbarcontroller1 = ScrollController();
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Map<String, dynamic>>(
      stream: myMethod(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<spendinfo> items = snapshot.data!['items'];
        var dailyTotals = snapshot.data!['dailyTotals'];
        return Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 3.04,
                child: Padding(
                  //borderin scroll ile birleşimi gözüksü diye soldan padding
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        scrollbarTheme: ScrollbarThemeData(
                      thumbColor: MaterialStateProperty.all(renkler.sariRenk),
                    )),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 1.75),
                          child: SizedBox(
                            width: 4,
                            height: size.height / 3.04,
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  color: Color(0xff0D1C26)),
                            ),
                          ),
                        ),
                        Scrollbar(
                          controller: Scrolbarcontroller1,
                          scrollbarOrientation: ScrollbarOrientation.left,
                          isAlwaysShown: true,
                          interactive: true,
                          thickness: 7,
                          radius: Radius.circular(15.0),
                          child: ListView.builder(
                              controller: Scrolbarcontroller1,
                              itemCount: dailyTotals.length,
                              itemBuilder: (BuildContext context, index) {
                                var keys = dailyTotals.keys.toList();
                                var day = keys[index];
                                var _month = month;
                                var _year = year;
                                var dayTotals = dailyTotals[day]!;
                                var totalAmount = dayTotals['totalAmount']!;
                                var totalAmount2 = dayTotals['totalAmount2']!;
                                final formattedTotal =
                                    (totalAmount - totalAmount2)
                                        .toStringAsFixed(2);

                                var dateTime = DateTime(int.parse(_year),
                                    int.parse(_month), int.parse(day));
                                var dayOfWeekName =
                                    _getDayOfWeekName(dateTime.weekday);
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 10),
                                      child: ClipRRect(
                                        //Borderradius vermek için kullanıyoruz
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        gunlukpages()));
                                          },
                                          child: Container(
                                            height: 27.4,
                                            color: renkler.ArkaRenk,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12, right: 15),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  SizedBox(
                                                      width: ceyrekwsize,
                                                      child: Text(
                                                        '$day $dayOfWeekName',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: ceyrekwsize,
                                                    child: Center(
                                                      child: Text(
                                                        '$totalAmount',
                                                        style: const TextStyle(
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: ceyrekwsize,
                                                    child: Center(
                                                      child: Text(
                                                        '$totalAmount2',
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: ceyrekwsize,
                                                    child: Center(
                                                      child: Text(
                                                        '$formattedTotal',
                                                        style: const TextStyle(
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    constraints:
                                                        const BoxConstraints(
                                                      maxHeight: 30,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(1),
                                                    icon: eyeColorChoice(12.2),
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  gunlukpages()));
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            5) // elemanlar arasına bşluk bırakmak için kulllandım.
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget eyeColorChoice(double toplam) {
    if (toplam < 0) {
      return const Icon(
        Icons.remove_red_eye,
        color: Colors.red,
      );
    } else {
      return const Icon(Icons.remove_red_eye, color: Colors.black);
    }
  }

  String getTotalAmount(List<spendinfo> items) {
    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    return (totalAmount - totalAmount2).toStringAsFixed(2);
  }

  String getTotalAmountPositive(List<spendinfo> items) {
    double totalAmount = items
        .where((element) => element.operationType == 'Gelir')
        .fold(0, (previousValue, element) => previousValue + element.amount!);

    return totalAmount.toStringAsFixed(2);
  }

  String getTotalAmountNegative(List<spendinfo> items) {
    double totalAmount2 = items
        .where((element) => element.operationType == 'Gider')
        .fold(0, (previousValue, element) => previousValue + element.amount!);
    return totalAmount2.toStringAsFixed(2);
  }

  String _getDayOfWeekName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Pzti';
      case 2:
        return 'Salı';
      case 3:
        return 'Çarş';
      case 4:
        return 'Perş';
      case 5:
        return 'Cuma';
      case 6:
        return 'Ctsi';
      case 7:
        return 'Pazr';
      default:
        return '';
    }
  }
}
