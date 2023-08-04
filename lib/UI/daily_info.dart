import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../constans/text_pref.dart';
import '../models/spend_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/app/butce_kontrol_app.dart';


class GunlukInfo extends ConsumerStatefulWidget {
  const GunlukInfo({super.key});
  @override
  ConsumerState<GunlukInfo> createState() => _GunlukInfoState();
}

class _GunlukInfoState extends ConsumerState<GunlukInfo> {
  final ScrollController scroolBarController2 = ScrollController();
  var renkler = CustomColors();
  bool isContainerClicked = true;

  Widget gelirGiderInfo(SpendInfo item) {
    if (item.operationType == 'Gelir') {
      return Text(
        '${item.amount}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontFamily:'Nexa3',
            color: renkler.yesilRenk
        ),
      );
    } else {
      return Text(
        '${item.amount}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontFamily:'Nexa3',
          color: renkler.kirmiziRenk,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(databaseRiverpod, (previous, next) {
      return ref.watch(databaseRiverpod);
    });
    var readSettings = ref.read(settingsRiverpod);
    var readDB = ref.read(databaseRiverpod);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy').format(now);
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    return Center(
      child: SizedBox(
        height: 230,
        child: Container(
            //margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: readSettings.localChanger() == Locale("ar") ?
                            BorderRadius.horizontal(
                                left: Radius.circular(10)
                            ) :
                            BorderRadius.horizontal(
                                right: Radius.circular(10)
                            ),
                            color: Theme.of(context).highlightColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 20, top: 6, bottom: 3),
                            child: Text(
                              translation(context).todaysActivities, /// dil destekli yazi
                              //"Bugünün İşlem Bilgileri",
                              style: TextStyle(
                                color: renkler.arkaRenk,
                                height: 1,
                                fontFamily: 'Nexa3',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
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
                const SizedBox(height: 8),
                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: Text(
                                translation(context).category,
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 16,
                                  color: Theme.of(context).canvasColor,
                                  fontFamily: 'Nexa3',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Center(
                              child: Text(
                                translation(context).payment,
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 16,
                                  fontFamily: 'Nexa3',
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: Text(
                                translation(context).amount,
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 16,
                                  fontFamily: 'Nexa3',
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                translation(context).time,
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 16,
                                  fontFamily: 'Nexa3',
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      FutureBuilder<List<SpendInfo>>(
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
                                            translation(context).noActivity, Colors.white, 14))
                                            "Kayıt Yok", Theme.of(context).primaryColor, 14))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ) :SizedBox(
                            height: 170,
                            child: Padding(
                              //borderin scroll ile birleşimi gözüksü diye soldan padding
                              padding: const EdgeInsets.only(
                                  left: 5.0, top: 5),
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
                                        height: 170,
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
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 15, right: 15,),
                                                  child: ClipRRect(
                                                    //Borderradius vermek için kullanıyoruz
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10.0),
                                                    child: InkWell(
                                                      child: Container(
                                                        height: 28,
                                                        decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(
                                                              Radius.circular(10)
                                                          ),
                                                          /*
                                                          border: Border.all(
                                                              color: renkler.arkaRenk, // Set border color
                                                              width: 1.0),*/
                                                          color: Theme.of(context).indicatorColor,
                                                        ),
                                                        child: isContainerClicked
                                                            ? Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                '${item.category}',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: Theme.of(context).canvasColor,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 50,
                                                              child: Text(
                                                                '${item.operationTool}',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: Theme.of(context).canvasColor,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 100,
                                                              child: gelirGiderInfo(item),
                                                            ),
                                                            SizedBox(
                                                              width: 60,
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 10),
                                                                child: Text(
                                                                  item.operationTime.toString(),
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                    color: Theme.of(context).canvasColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                            : Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            SizedBox(
                                                              width: 40,
                                                              child: Text(
                                                                'NOT: ',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: Theme.of(context).canvasColor,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Center(
                                                                child: SizedBox(
                                                                  child: SingleChildScrollView(
                                                                    scrollDirection: Axis.horizontal,
                                                                    child: Text(
                                                                      item.note == '' ? 'Not Eklenmemiş' : '${item.note}',
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                        color: Theme.of(context).canvasColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          isContainerClicked = !isContainerClicked;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                    height:
                                                    6) // elemanlar arasına bşluk bırakmak için kulllandım.
                                              ],
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

/*

 */