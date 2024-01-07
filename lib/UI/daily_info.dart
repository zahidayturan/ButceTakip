import 'package:butcekontrol/UI/monthly_status_info.dart';
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
  int skipController = 0;

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
    var readNavBar = ref.read(botomNavBarRiverpod);
    var readCalendar = ref.read(calendarRiverpod);
    var readSetting = ref.read(settingsRiverpod);
    CustomColors renkler = CustomColors();
    return Center(
      child: SizedBox(
        height: 220, // bugünün bilgileri yükseklik.
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(skipController == 0){
                          readDailyInfo.setDate(DateTime.now().day, DateTime.now().month, DateTime.now().year);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DailyInfo()));
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          color: skipController == 0 ?  Theme.of(context).secondaryHeaderColor : Theme.of(context).dialogBackgroundColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
                          child: Text(
                            skipController == 0 ? translation(context).todaysActivities : "${translation(context).monthlyStatisticsOnlyForEnglishAndArabic} ${readSettings.getMonthInList(context)} ${readSettings.yearIndex.toString()} ${translation(context).monthlyStatisticsOnlyForTurkish}", /// dil destekli yazi
                            style: TextStyle(
                              color: skipController == 0 ? Theme.of(context).primaryColor : Theme.of(context).highlightColor,
                              height: 1,
                              fontFamily: 'Nexa3',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: skipController == 0,
                      child: Padding(
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
                                  fontSize: 15,
                                  height: 1,
                                  fontFamily: 'Nexa4',
                                  fontWeight: FontWeight.w900,
                              color: Theme.of(context).canvasColor
                              )),
                        ),
                      ),
                    ),
                    counterContainer(context, skipController)
                  ],
                ),
              ),
            ),/// Bugünn bilgileri satırı
            const SizedBox(height: 5),
            Directionality(
              textDirection: TextDirection.ltr,
              child: SizedBox(
                height: 184,
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      skipController = value;
                    });
                  },
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
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
                          return snapshot.data!.isEmpty ? Center(
                            child: SizedBox(
                              height: 180,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/image/noInfo4.png",
                                    width: 90,
                                    height: 90,
                                    //color: Theme.of(context).canvasColor,
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
                                physics: const BouncingScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, index) {
                                  SpendInfo item = snapshot.data![index];
                                  return RowStyleCreateBox(context, item);
                                }),
                          );
                        },
                      ),
                    ),
                    const MonthlyStatusInfo(),
                  ],
                ),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Row(
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
                                  ),
                                  item.note != "" ? Expanded(
                                      child: Text(
                                        item.note != "" ? "${translation(context).note} ${item.note}" : translation(context).noNoteAdded,
                                        style: const TextStyle(
                                          height: 1,
                                          fontSize: 13
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ) : SizedBox()
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

  Widget counterContainer(BuildContext context, int pageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: pageCount == 0 ? 24 : 12,
            height: pageCount == 1 ? 12 : 10,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: pageCount == 0
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).canvasColor),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: pageCount == 1 ? 24 : 12,
          height: pageCount == 0 ? 12 : 10,
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