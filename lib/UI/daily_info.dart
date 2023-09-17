import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/textConverter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import '../constans/text_pref.dart';
import '../models/spend_info.dart';
import 'package:butcekontrol/classes/language.dart';

import '../pages/daily_info_page.dart';


class GunlukInfo extends ConsumerStatefulWidget {
  const GunlukInfo({super.key});
  @override
  ConsumerState<GunlukInfo> createState() => _GunlukInfoState();
}

class _GunlukInfoState extends ConsumerState<GunlukInfo> {
  final ScrollController scroolBarController2 = ScrollController();
  var renkler = CustomColors();

  @override

  Widget build(BuildContext context) {
    ref.listen(databaseRiverpod, (previous, next) {
      return ref.watch(databaseRiverpod);
    });
    var readSettings = ref.read(settingsRiverpod);
    String dateFormat = readSettings.dateFormat ?? "dd.MM.yyyy";
    DateTime now = DateTime.now();
    String formattedDate = intl.DateFormat(dateFormat).format(now)  ;
    var readDB = ref.read(databaseRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    var size = MediaQuery.of(context).size;
    var readNavBar = ref.read(botomNavBarRiverpod);
    var readCalendar = ref.read(calendarRiverpod);
    var readSetting = ref.read(settingsRiverpod);
    var darkMode = readSetting.DarkMode;
    CustomColors renkler = CustomColors();
    return Center(
      child: SizedBox(
        height: 220, // bugünün bilgileri yükseklik.
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      readDailyInfo.setDate(DateTime.now().day, DateTime.now().month, DateTime.now().year);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DailyInfo()));
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
                        child: Text(
                          translation(context).todaysActivities, /// dil destekli yazi
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            height: 1,
                            fontFamily: 'Nexa3',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 25,
                      left: 25,
                      top: 4,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        readNavBar.setCurrentindex(2);
                        Navigator.of(context).popUntil((route) => route.isFirst) ;
                        readCalendar.setIndex(0, 3,ref);
                        readCalendar.resetPageController();
                      },
                      child: Text(formattedDate,
                          style: TextStyle(
                              fontSize: 16,
                              height: 1,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w900,
                          color: Theme.of(context).canvasColor
                          )),
                    ),
                  )
                ],
              ),
            ),/// Bugünn bilgileri satırı
            const SizedBox(height: 5),
            Center(
              child: FutureBuilder<List<SpendInfo>>(
                future: readDB.myDailyMethod(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<SpendInfo>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return snapshot.data!.length == 0 ? Center(
                    child: SizedBox(
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/image/noInfo.png",
                            width: 70,
                            height: 70,
                            //color: Theme.of(context).canvasColor,
                          ),
                          const SizedBox(
                            height: 6,
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
                                    translation(context).noActivity, Theme.of(context).primaryColor, 14))
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) :SizedBox(
                    height: 184,
                    child: ListView.builder(
                        controller: scroolBarController2,
                        itemCount: snapshot.data!.length,
                        itemBuilder:
                            (BuildContext context, index) {
                          SpendInfo item = snapshot.data![index];
                          return RowStyleCreateBox(context, item);
                        }),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget RowStyleCreateBox(BuildContext context, item){
    var size = MediaQuery.of(context).size;
    var readSettings = ref.read(settingsRiverpod);
    return GestureDetector(
      onTap: () {
        var readDailyInfo = ref.read(dailyInfoRiverpod);
        readDailyInfo.setSpendDetail([item], 0);
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
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children :[

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: const EdgeInsets.only(top: 5.2, bottom:5.2 , right: 18),
                      height:  40, // container boyu veriyoruz.
                      width: size.width * .93,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).indicatorColor,
                      ),
                      child: Row(
                          children: [
                            Container(
                              height: 27,
                              width : size.width * .015,
                              decoration: BoxDecoration(
                                color: item.operationType == "Gelir" ? renkler.yesilRenk : renkler.kirmiziRenk,
                                borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
                              ),

                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 2),
                                          child: Text(
                                            item.operationTime.toString(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Theme.of(context).canvasColor,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 14,
                                              height: 1
                                            ),
                                          ),
                                        ),
                                      ),///time
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          Converter().textConverterFromDB(item.category!, context, 0),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Theme.of(context).canvasColor,
                                            height: 1
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),///category
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          Converter().textConverterFromDB(item.operationTool!, context, 2),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Theme.of(context).canvasColor,
                                            height: 1
                                          ),
                                        ),
                                      ),///operation
                                      Directionality(
                                        textDirection: readSettings.localChanger() == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
                                        child: Expanded(
                                          flex: 2,
                                          child: SizedBox(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text:  "${item.realAmount}",
                                                      style: TextStyle(
                                                        height: 1,
                                                        color: item.operationType == "Gelir" ? renkler.yesilRenk : renkler.kirmiziRenk,
                                                        fontFamily:
                                                        "Nexa3",
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ref.read(settingsRiverpod).prefixSymbol,
                                                      style: TextStyle(
                                                        height: 1,
                                                        color: item.operationType == "Gelir" ? renkler.yesilRenk : renkler.kirmiziRenk,
                                                        fontFamily:
                                                        "TL",
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ])),
                                              ),
                                            ),
                                          ),
                                      ),///amount
                                      ],
                                    ),
                                    Expanded(
                                      child: Text(
                                        item.note != "" ? "${translation(context).note} ${item.note}" : translation(context).noNoteAdded,
                                        style: const TextStyle(
                                          height: 1,
                                          fontSize: 14
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),
                  const SizedBox(height: 5) // elemanlar arasına bşluk bırakmak için kulllandım.
                ],
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: Container(
                  decoration: BoxDecoration(
                    color:  Theme.of(context).highlightColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                        Icons.remove_red_eye,
                      color: Colors.white,
                      size: 18,

                    ),
                  ),
                ),
              ),
          ]
        ),
      ),
    );
  }
}