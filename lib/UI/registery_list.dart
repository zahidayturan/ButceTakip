import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
showDialog(
              context: context,
              builder: (context) {
                return registeryListW();
              },
            );
 */
class RegisteryList extends ConsumerWidget {
  const RegisteryList({Key? key}) : super(key: key);

  ///Bu widgeti kullanmak için showDialog un çocuğu olarak göndermeniz gerekmektedir.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readDB = ref.read(databaseRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: readDB.registeryList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var item = snapshot.data!;
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10),
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 390,
            ),
            child: Column(
              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kaydedilen İşlemler",
                    style: TextStyle(
                        color: Theme.of(context).canvasColor,
                        fontFamily: "Nexa4",
                        fontSize: 21),
                  ),
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(20)),
                      ),
                      child:   IconButton(
                        icon: Image.asset(
                          "assets/icons/remove.png",
                          height: 16,
                          width: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                        iconSize: 24,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 56),
                            child: Text(
                              "İşlem\nKategorisi",
                              style: TextStyle(
                                color: Theme.of(context).canvasColor,
                                fontFamily: "Nexa4",
                                fontSize: 15
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: Text(
                              "İşlem\nTutarı",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).canvasColor,
                                fontFamily: "Nexa4",
                                fontSize: 15
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), //baslıklar
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 1.9, left: 1.5),
                              child: Container(
                                width: 4,
                                height: 290,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                  color: item.length > 7
                                      ? Theme.of(context).canvasColor
                                      : Theme.of(context).indicatorColor,),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 290,
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1, right: 1),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.fromSwatch(
                                    accentColor: const Color(0xFFF2CB05),
                                  ),
                                  scrollbarTheme: ScrollbarThemeData(
                                      thumbColor: MaterialStateProperty.all(
                                        Theme.of(context).dialogBackgroundColor))),
                              child: SizedBox(
                                height: 290,
                                width: 300,
                                child: Scrollbar(
                                  scrollbarOrientation:
                                  readSettings.localChanger() == Locale("ar") ? ScrollbarOrientation.left :
                                  ScrollbarOrientation.right,
                                  thumbVisibility: true,
                                  interactive: true,
                                  thickness: 6,
                                  radius: const Radius.circular(20),

                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 4),
                                    child: ListView.builder(
                                      itemCount: item.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                readDailyInfo.setSpendDetail(
                                                    item, index);
                                                showModalBottomSheet(
                                                  context: context,
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      15))),
                                                  backgroundColor:
                                                      const Color(0xff0D1C26),
                                                  builder: (context) {
                                                    // genel bilgi sekmesi açılıyor.
                                                    ref
                                                        .watch(databaseRiverpod)
                                                        .deletst;
                                                    return const SpendDetail();
                                                  },
                                                );
                                              },
                                              highlightColor: Theme.of(context).scaffoldBackgroundColor,
                                              child: SizedBox(
                                                height: 36,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(right:12,left: 18,top: 3,bottom: 3),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Container(
                                                          color: Theme.of(context).indicatorColor,
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 20,right: 10,top: 2),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      110,
                                                                  child: Center(
                                                                    child: Text(
                                                                      "${item[index].category}",
                                                                      overflow: TextOverflow.ellipsis,
                                                                      textAlign: TextAlign.center,
                                                                      maxLines: 2,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontFamily:
                                                                            "Nexa3",
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: RichText(
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      textAlign: TextAlign.end,
                                                                      text: TextSpan(children: [
                                                                        TextSpan(
                                                                          text:  item[index].realAmount!.toStringAsFixed(1),
                                                                          style: TextStyle(
                                                                            height: 1,
                                                                            color: item[index]
                                                                                .operationType ==
                                                                                "Gider"
                                                                                ? renkler
                                                                                .kirmiziRenk
                                                                                : Theme.of(
                                                                                context)
                                                                                .canvasColor,
                                                                            fontFamily:
                                                                            "Nexa3",
                                                                            fontSize: 15,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text: readSettings.prefixSymbol,
                                                                          style: TextStyle(
                                                                            height: 1,
                                                                            color: item[index]
                                                                                .operationType ==
                                                                                "Gider"
                                                                                ? renkler
                                                                                .kirmiziRenk
                                                                                : Theme.of(
                                                                                context)
                                                                                .canvasColor,
                                                                            fontFamily:
                                                                            "TL",
                                                                            fontSize: 15,
                                                                          ),
                                                                        ),
                                                                      ])),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 0,
                                                      child: SizedBox(
                                                        width: 36,
                                                        height: 36,
                                                        child: DecoratedBox(
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(context).indicatorColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                            color: Theme.of(context).dialogBackgroundColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ),
                                            const SizedBox(height: 6,),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            "Kaydedilen İşlem Sayısı : ${item.length}",
                            style: TextStyle(
                                color: Theme.of(context).canvasColor, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: Theme.of(context).highlightColor,
        );
      },
    );
  }
}
/*

 */
