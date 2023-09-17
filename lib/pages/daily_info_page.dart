import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/textConverter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../UI/spend_detail.dart';
import 'package:butcekontrol/classes/language.dart';

import '../constans/text_pref.dart';

class DailyInfo extends ConsumerWidget {
  const DailyInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomColors renkler = CustomColors();
    return const SafeArea(
      child: Scaffold(
        //backgroundColor: renkler.arkaRenk,
        appBar: AppbarDailyInfo(),
        body: DailyInfoBody(),
      ),
    );
  }
}

class DailyInfoBody extends ConsumerStatefulWidget {
  const DailyInfoBody({Key? key}) : super(key: key);
  @override
  ConsumerState<DailyInfoBody> createState() => _DailyInfoBody();
}

class _DailyInfoBody extends ConsumerState<DailyInfoBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        list(context),
        dayDetailsGuide(context),
        dayTypeCount(context)
      ],
    );
  }
  void checkAndPop(int itemLength) {
    print("kalmadı");
    if (itemLength == 1) {
      print("kalmadı");
      Navigator.pop(context);
    }
    else null;
  }

  int? registrationState;
  Widget list(BuildContext context) {
    ref.listen(databaseRiverpod, (previous, next) {
      return ref.watch(databaseRiverpod);
    });
    var readSetting = ref.read(settingsRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    var size = MediaQuery.of(context).size;
    Future<List<SpendInfo>> myList = readDailyInfo.myMethod2();
    CustomColors renkler = CustomColors();
    return FutureBuilder(
            future: myList,
            builder: (context, AsyncSnapshot<List<SpendInfo>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var item = snapshot.data!; // !
              return Expanded(
                child: item.length == 0
                  ?Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/image/noInfo.png",
                        width: 150,
                        height: 150,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 15,
                        width: 80,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).canvasColor,
                            ),
                            child: Center(child: TextMod(
                                translation(context).noActivity, Theme.of(context).primaryColor, 11))
                        ),
                      ),
                    ],
                  )
                  :Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 11.5,top: 4),
                                    child: Container(
                                      width: 4,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                          color: snapshot.data!.length <= 12
                                              ? Theme.of(context).indicatorColor
                                              : Theme.of(context).canvasColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.fromSwatch(
                                      accentColor: Theme.of(context).disabledColor,
                                    ),
                                    scrollbarTheme: ScrollbarThemeData(
                                        thumbColor: MaterialStateProperty.all(
                                          Theme.of(context).dialogBackgroundColor,))),
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  scrollbarOrientation: ScrollbarOrientation.right,
                                  interactive: true,
                                  thickness: 7,
                                  radius: const Radius.circular(15),
                                  child: ListView.builder(
                                    itemCount: item.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                             right: 15, top: 5),
                                        child: InkWell(
                                          onTap: () {
                                            {
                                              readDailyInfo.setSpendDetail(item, index);
                                              readDailyInfo.regChange(item[index].registration);
                                              ref.watch(databaseRiverpod).delete;
                                              showModalBottomSheet(
                                                isScrollControlled:true,
                                                context: context,
                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                                                backgroundColor:
                                                const Color(0xff0D1C26),
                                                builder: (context) {
                                                  //ref.watch(databaseRiverpod).updatest;
                                                  // genel bilgi sekmesi açılıyor.
                                                  return const SpendDetail();
                                                },
                                              ).then((value) {
                                                  item.length == 1 ? Navigator.pop(context) : null;
                                              });
                                            }
                                          },
                                          highlightColor: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(13),
                                          child: SizedBox(
                                            height: 50,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                color: Theme.of(context).indicatorColor,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 4),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(bottom: 5,left: 6,right: 6),
                                                      child: Icon(
                                                        Icons.remove_red_eye,
                                                        color: item[index]
                                                            .operationType ==
                                                            "Gider"
                                                            ? const Color(0xFFD91A2A)
                                                            : Theme.of(context).canvasColor,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Expanded(
                                                      child: Text(
                                                        Converter().textConverterFromDB(item[index].category!, context, 0),
                                                        style: TextStyle(
                                                          fontFamily: 'NEXA3',
                                                          fontSize: 17,
                                                          height: 1,
                                                          color: Theme.of(context).canvasColor,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          right: 8.0,left: 8),
                                                      child : item[index]
                                                          .operationType ==
                                                          "Gelir"
                                                          ? RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:item[index].realAmount!.toStringAsFixed(2),style: TextStyle(
                                                              fontFamily: 'NEXA3',
                                                              fontSize: 17,
                                                              height: 1,
                                                              color: Theme.of(context).canvasColor
                                                            ),
                                                            ),
                                                             TextSpan(
                                                              text: readSetting.prefixSymbol,
                                                              style: TextStyle(
                                                                fontFamily: 'TL',
                                                                fontSize: 17,
                                                                height: 1,
                                                                fontWeight: FontWeight.w600,
                                                                  color: Theme.of(context).canvasColor
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ) : RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:item[index].realAmount!.toStringAsFixed(2),style: TextStyle(
                                                              fontFamily: 'Nexa3',
                                                              fontSize: 17,
                                                              height: 1,
                                                              color: renkler.kirmiziRenk,
                                                            ),
                                                            ),
                                                            TextSpan(
                                                              text: readSetting.prefixSymbol,
                                                              style: TextStyle(
                                                                fontFamily: 'TL',
                                                                fontSize: 17,
                                                                height: 1,
                                                                fontWeight: FontWeight.w600,
                                                                color: renkler.kirmiziRenk,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: SizedBox(
                            width: size.width * 0.98,
                            height: 15,
                            child: SizedBox(
                              height: 15,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                  "${item.length}",
                                  style: TextStyle(
                                      color: Theme.of(context).dialogBackgroundColor,
                                      fontSize: 18,
                                      fontFamily: 'NEXA4'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              );
            });
  }

  Widget dayDetailsGuide(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(dailyInfoRiverpod);
    CustomColors renkler = CustomColors();
    return FutureBuilder<List>(
      future: read.getMonthDaily(read.day, read.month, read.year),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data!;
          return Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
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
                            FittedBox(
                              child: Text(
                                " +${data[0]}",
                                style: TextStyle(
                                  color: renkler.yaziRenk,
                                  fontSize: 15,
                                  fontFamily: 'Nexa3',
                                  fontWeight: FontWeight.w900,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.15,
                            ),
                            FittedBox(
                              child: Text(
                                "-${data[1]} ",
                                style: TextStyle(
                                  color: renkler.yaziRenk,
                                  fontSize: 15,
                                  fontFamily: 'Nexa3',
                                  fontWeight: FontWeight.w900,
                                  height: 1.4,
                                ),
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
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Theme.of(context).disabledColor,
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
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget dayTypeCount(BuildContext context) {
    var read = ref.read(dailyInfoRiverpod);
    return FutureBuilder<List>(
      future: read.getDayAmountCount(read.day, read.month, read.year),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${data[0]} ${translation(context).incomeInfo}",
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontFamily: 'Nexa3',
                    fontSize: 17,
                  ),
                ),
                Text("${data[1]} ${translation(context).expenseInfo}",
                    style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontFamily: 'Nexa3',
                      fontSize: 17,
                    )),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class AppbarDailyInfo extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const AppbarDailyInfo({Key? key}) : super(key: key);
  @override
  ConsumerState<AppbarDailyInfo> createState() => _AppbarDailyInfoState();
  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _AppbarDailyInfoState extends ConsumerState<AppbarDailyInfo> {
  @override
  Widget build(BuildContext context) {
    return appBar(context, ref);
  }

  CustomColors renkler = CustomColors();
  Widget appBar(BuildContext context, WidgetRef ref) {
    ref.listen(databaseRiverpod, (previous, next) {
      return ref.watch(databaseRiverpod);
    });
    List myDate = ref.read(dailyInfoRiverpod).getDate(context);
    var size = MediaQuery.of(context).size;
    var readSettings = ref.read(settingsRiverpod);
    CustomColors renkler = CustomColors();
    return FutureBuilder<double>(
      future: ref.read(dailyInfoRiverpod).getResult(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Veri henüz gelmediğinde veya gecikme yaşandığında
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 55,
                    width: size.width - 80,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: readSettings.localChanger() == Locale("ar") ?
                        const BorderRadius.horizontal(
                          left: Radius.circular(15),
                        ) :
                        const BorderRadius.horizontal(
                          right: Radius.circular(15),
                        ),
                        color: renkler.arkaRenk,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${myDate[0]} ${myDate[1]} ${myDate[2]}",
                            style: TextStyle(
                              color: renkler.yaziRenk,
                              fontFamily: "Nexa3",
                              height: 1,
                              fontSize: 24,
                            ),
                          ),
                           Text(
                            translation(context).activityDetails,
                            style: TextStyle(
                              color: renkler.yaziRenk,
                              fontFamily: "Nexa3",
                              fontWeight: FontWeight.w400,
                              height: 1,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: renkler.yaziRenk,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          double result = snapshot.data!;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 55,
                    width: size.width - 80,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: readSettings.localChanger() == Locale("ar") ?
                        const BorderRadius.horizontal(
                          left: Radius.circular(15),
                        ) :
                        const BorderRadius.horizontal(
                          right: Radius.circular(15),
                        ),
                        color: result >= 0
                            ? renkler.yesilRenk
                            : renkler.kirmiziRenk,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${myDate[0]} ${myDate[1]} ${myDate[2]}",
                            style: TextStyle(
                              height: 1,
                              color: renkler.yaziRenk,
                              fontFamily: "NEXA3",
                              fontSize: 24,
                            ),
                          ),
                           Text(
                            translation(context).activityDetails,
                            style: TextStyle(
                              height: 1,
                              color: renkler.yaziRenk,
                              fontFamily: "NEXA3",
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: IconButton(
                          icon: Image.asset(
                            "assets/icons/remove.png",
                            height: 16,
                            width: 16,
                            color: renkler.yaziRenk
                          ),
                          highlightColor: Theme.of(context).primaryColor,
                          splashColor:Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ), /// çarpı işareti
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}