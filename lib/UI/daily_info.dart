import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import '../constans/text_pref.dart';
import '../models/spend_info.dart';
import 'package:butcekontrol/classes/language.dart';


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
    var readDB = ref.read(databaseRiverpod);
    DateTime now = DateTime.now();
    //String formattedDate = intl.DateFormat('dd.MM.yyyy').format(now);
    String formattedDate = readSettings.localChanger() == const Locale("ar") ? intl.DateFormat('yyyy.MM.dd').format(now) : intl.DateFormat('dd.MM.yyyy').format(now);
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return Center(
      child: SizedBox(
        height: 230, // bugünün bilgileri yükseklik.
        //height: 230,
        child: Container(
            //margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Theme.of(context).highlightColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 3),
                          child: Text(
                            translation(context).todaysActivities, /// dil destekli yazi
                            //"Bugünün İşlem Bilgileri",
                            style: TextStyle(
                              color: renkler.arkaRenk,
                              height: 1,
                              fontFamily: 'Nexa3',
                              fontSize: 17,
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
                        child: Text(formattedDate,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w900,
                            color: Theme.of(context).canvasColor
                            )),
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
                          height: 160,
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
                                        translation(context).noActivity, Theme.of(context).primaryColor, 14))
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) :SizedBox(
                        height: size.height * .25,
                        child: Padding(
                          //borderin scroll ile birleşimi gözüksü diye soldan padding
                          padding: const EdgeInsets.only(left: 5.0, top: 5),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.fromSwatch(
                                  accentColor: const Color(0xFFF2CB05),
                                ),
                                scrollbarTheme: ScrollbarThemeData(
                                  thumbColor:
                                  MaterialStateProperty.all(Theme.of(context).dialogBackgroundColor),
                                )),

                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 1.75, right: 1.75),
                                  child: SizedBox(
                                    width: 4,
                                    height: size.height * .25,
                                    child:  DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                                          color: snapshot.data!.length <= 4 ? Theme.of(context).indicatorColor : Theme.of(context).canvasColor),
                                    ),
                                  ),
                                ),
                                Scrollbar(
                                  controller: scroolBarController2,
                                  thumbVisibility: true,
                                  scrollbarOrientation:
                                  readSettings.localChanger() == Locale("ar") ? ScrollbarOrientation.right :
                                  ScrollbarOrientation.left,
                                  interactive: true,
                                  thickness: 7,
                                  radius: const Radius.circular(15.0),
                                  child: ListView.builder(
                                      controller: scroolBarController2,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        SpendInfo item = snapshot.data![index];
                                        return RowStyleCreateBox(context, item);
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
  Widget RowStyleCreateBox(BuildContext context, item){
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        var readDailyInfo = ref.read(dailyInfoRiverpod);
        readDailyInfo.setSpendDetail([item], 0);
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
          backgroundColor:
          const Color(0xff0D1C26),
          builder: (context) {
            //ref.watch(databaseRiverpod).updatest;
            // genel bilgi sekmesi açılıyor.
            return const SpendDetail();
          },
        );
      },
      child: Stack(
        children :[

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.only(top: 5.2, bottom:5.2 , right: 14),
                    height:  40, // container boyu veriyoruz.
                    width: size.width * .898,
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
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(4)),
                            ),

                          ),
                          SizedBox(width: 5),
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
                                              fontSize: 14
                                          ),
                                        ),
                                      ),
                                    ),///time
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${item.category}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${item.operationTool}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                        ),
                                      ),
                                    ),///operation
                                    Expanded(
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
                                      ),///amount
                                    ],
                                  ),
                                  Expanded(
                                    child: Text(
                                      item.note != "" ? "Not :${item.note}" : "Not Eklenmemiş",
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
                const SizedBox(height: 6) // elemanlar arasına bşluk bırakmak için kulllandım.
              ],
            ),
            Positioned(
              top: 10.0,
              right: 9.0,
              child: Container(
                decoration: BoxDecoration(
                  color:  Theme.of(context).highlightColor,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                      Icons.remove_red_eye,
                    color: Colors.white,
                    size: 14,

                  ),
                ),
              ),
            ),
        ]
      ),
    );
  }
}

/*

 */