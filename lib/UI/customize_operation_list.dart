import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/textConverter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CustomizeList extends ConsumerWidget {
  const CustomizeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readHome= ref.read(homeRiverpod);
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    return StatefulBuilder(
      builder: (context, setState) {
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
                        readHome.menuControllerForRepeated == false
                            ? translation(context).repetitiveActivities
                            : translation(context).installmentActivities,
                        style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontFamily: "Nexa4",
                            fontSize: double.parse(translation(context).repetitiveActivitiesSize),
                        height: 1),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(20)
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.swap_horiz_rounded),
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                color: readHome.menuControllerForRepeated == false ? renkler.koyuuRenk : Colors.white,
                                iconSize: 30,
                                onPressed: () {
                                  setState(
                                          () {
                                            readHome.menuControllerForRepeated = !readHome.menuControllerForRepeated;
                                      });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: IconButton(
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
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  readHome.menuControllerForRepeated == false ? repeatedList(context, ref,setState) : installemntList(context, ref,setState),
                ],
              )),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: Theme.of(context).highlightColor,
        );
      },
    );

  }



  Widget repeatedList(BuildContext context, WidgetRef ref,setState) {
    var readUpdateData = ref.read(updateDataRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    var watchHome = ref.watch(homeRiverpod);
    return FutureBuilder(
      future: readUpdateData.getCustomizeRepeatedOperation(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var item = snapshot.data!;
        return Column(
          children: [
            Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Container(
                      width: 4,
                      height: 320,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(30)),
                        color: item.length > 4
                            ? renkler.arkaRenk
                            : Theme.of(context).indicatorColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 320,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.fromSwatch(
                            accentColor: Theme.of(context).disabledColor,
                          ),
                          scrollbarTheme: ScrollbarThemeData(
                              thumbColor: MaterialStateProperty.all(
                                  Theme.of(context)
                                      .dialogBackgroundColor))),
                      child: SizedBox(
                        child: Scrollbar(
                          scrollbarOrientation: ScrollbarOrientation.right,
                          thumbVisibility: true,
                          interactive: true,
                          thickness: 6,
                          radius: const Radius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 1),
                            child: ListView.builder(
                              itemCount: item.length,
                              itemBuilder: (context, index) {
                                var readSettings = ref.read(settingsRiverpod);
                                DateTime itemDate = DateTime(int.tryParse(item[index].operationYear!)!,int.tryParse(item[index].operationMonth!)!,int.tryParse(item[index].operationDay!)!);
                                String formattedDate = DateFormat(readSettings.dateFormat).format(itemDate);
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        readDailyInfo.setSpendDetail(
                                            item, index);
                                        showModalBottomSheet(
                                          isScrollControlled:true,
                                          context: context,
                                          shape:
                                          const RoundedRectangleBorder(
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
                                      highlightColor : Theme.of(context).scaffoldBackgroundColor,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .indicatorColor,
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6,
                                                left: 8,
                                                right: 8,
                                            bottom: 0),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      Converter().textConverterFromDB(item[index].processOnce!, context, 1),
                                                      style:
                                                      const TextStyle(
                                                        fontFamily: "Nexa3",
                                                        fontSize: 16,
                                                        height: 1
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
                                                                "Nexa4",
                                                                fontSize: 16,
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
                                                                fontSize: 17,
                                                              ),
                                                            ),
                                                          ])),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      formattedDate,
                                                      style:
                                                      const TextStyle(
                                                        fontFamily: "Nexa3",
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                Converter().textConverterFromDB(item[index].category!, context, 0),
                                                        style: TextStyle(
                                                          color: Theme.of(
                                                              context)
                                                              .canvasColor,
                                                          fontFamily: "Nexa3",
                                                          fontSize: 13,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4,right: 4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                      height : 18,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  backgroundColor: Theme.of(context).primaryColor,
                                                                  title: Text(translation(context).cancelRepetition,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 17,fontFamily: 'Nexa3'),textAlign: TextAlign.center),
                                                                  titlePadding: EdgeInsets.all(10),
                                                                  content: Text(translation(context).confirmNoRepeat,style: TextStyle(color: Theme.of(context).canvasColor,fontSize: 17,fontFamily: 'Nexa3'),textAlign: TextAlign.center,),
                                                                  shadowColor: renkler.koyuuRenk,
                                                                  contentPadding: EdgeInsets.only(top: 2,left: 16,right: 16,bottom: 2),
                                                                  actionsPadding: EdgeInsets.all(0),
                                                                  actions: [
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child: Text(translation(context).no,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 17,fontFamily: 'Nexa3'),),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            setState(() {
                                                                              readUpdateData.removeProcessOnce(item[index].id!);
                                                                            });
                                                                            Navigator.of(context).pop();
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                backgroundColor: Theme.of(context).highlightColor,
                                                                                duration: const Duration(seconds: 1),
                                                                                content: Text(
                                                                                  translation(context).repeatCancelled,
                                                                                  style: const TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontSize: 16,
                                                                                    fontFamily: 'Nexa3',
                                                                                    fontWeight: FontWeight.w600,
                                                                                    height: 1.3,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child: Text(translation(context).yesCancel,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 17,fontFamily: 'Nexa3'),),
                                                                        ),
                                                                      ],

                                                                    )
                                                                  ],
                                                                );
                                                              });
                                                          },
                                                        style: ButtonStyle(
                                                            backgroundColor:MaterialStatePropertyAll(Theme.of(context).disabledColor),
                                                            shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                                const RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight: Radius.circular(5),
                                                                        topLeft: Radius.circular(5)
                                                                    )
                                                                )),
                                                            padding: const MaterialStatePropertyAll(EdgeInsets.only(top: 2,left: 6,right: 6))
                                                        ),
                                                        child: Text(
                                                          translation(context).cancelRepetition,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              height : 1,
                                                              color: renkler
                                                                  .koyuuRenk),
                                                        ),
                                                      ),
                                                    ),
                                                      SizedBox(
                                                        height : 18,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            readDailyInfo.setSpendDetail(
                                                                item, index);
                                                            showModalBottomSheet(
                                                              isScrollControlled:true,
                                                              context: context,
                                                              shape:
                                                              const RoundedRectangleBorder(
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
                                                          style: ButtonStyle(
                                                              backgroundColor:MaterialStatePropertyAll(renkler.koyuuRenk),
                                                              shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                                  const RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                          topRight: Radius.circular(5),
                                                                          topLeft: Radius.circular(5)
                                                                      )
                                                                  )),
                                                              padding: const MaterialStatePropertyAll(EdgeInsets.only(top: 2,left: 6,right: 6))
                                                          ),
                                                          child: Text(
                                                            translation(context).activityDetailsSmall,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                height : 1,
                                                                color: renkler
                                                                    .arkaRenk),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
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
                    "${translation(context).activeRepetitiveActivities} ${item.length}",
                    style: TextStyle(
                        color: Theme.of(context).canvasColor, fontSize: 13, height: 1),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget installemntList(BuildContext context, WidgetRef ref,setState) {
    var readUpdateData = ref.read(updateDataRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    var watchHome = ref.watch(homeRiverpod);
    return FutureBuilder(
      future: readUpdateData.getCustomizeInstallmentOperation(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var item = snapshot.data!;
        return Column(
          children: [
            Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Container(
                      width: 4,
                      height: 320,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(30)),
                        color: item.length > 4
                            ? renkler.arkaRenk
                            : Theme.of(context).indicatorColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 320,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.fromSwatch(
                            accentColor: Theme.of(context).disabledColor,
                          ),
                          scrollbarTheme: ScrollbarThemeData(
                              thumbColor:
                              MaterialStateProperty.all(Theme.of(context).dialogBackgroundColor))),
                      child: SizedBox(
                        child: Scrollbar(
                          scrollbarOrientation: ScrollbarOrientation.right,
                          thumbVisibility: true,
                          interactive: true,
                          thickness: 6,
                          radius: const Radius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 1),
                            child: ListView.builder(
                              itemCount: item.length,
                              itemBuilder: (context, index) {
                                var readSettings = ref.read(settingsRiverpod);
                                DateTime itemDate = DateTime(int.tryParse(item[index].operationYear!)!,int.tryParse(item[index].operationMonth!)!,int.tryParse(item[index].operationDay!)!);
                                String formattedDate = DateFormat(readSettings.dateFormat).format(itemDate);
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        readDailyInfo.setSpendDetail(item, index);
                                        showModalBottomSheet(
                                          isScrollControlled:true,
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(
                                                  top: Radius.circular(25))),
                                          backgroundColor: const Color(0xff0D1C26),
                                          builder: (context) {
                                            // genel bilgi sekmesi açılıyor.
                                            ref.watch(databaseRiverpod).deletst;
                                            return const SpendDetail();
                                          },
                                        );
                                      },
                                      highlightColor : Theme.of(context).scaffoldBackgroundColor,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: Container(
                                          height: 64,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).indicatorColor,
                                              borderRadius: const BorderRadius.all(Radius.circular(10))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 6.0,left: 8,right: 8),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${item[index].processOnce}",
                                                      style:
                                                      const TextStyle(
                                                        fontFamily: "Nexa3",
                                                        fontSize: 16,
                                                        height: 1
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
                                                                "Nexa4",
                                                                fontSize: 16,
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
                                                                fontSize: 17,
                                                              ),
                                                            ),
                                                          ])),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      formattedDate,
                                                      style:
                                                      const TextStyle(
                                                        fontFamily: "Nexa3",
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${item[index].category}",
                                                        style: TextStyle(
                                                          color: Theme.of(
                                                              context)
                                                              .canvasColor,
                                                          fontFamily: "Nexa3",
                                                          fontSize: 13,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4,right: 4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        height : 18,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context: context,
                                                                builder: (context) {
                                                                  return AlertDialog(
                                                                    backgroundColor: Theme.of(context).primaryColor,
                                                                    title: Text(translation(context).cancelInstallment,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 17,fontFamily: 'Nexa3'),textAlign: TextAlign.center),
                                                                    titlePadding: EdgeInsets.all(10),
                                                                    content: Text(translation(context).confirmNoInstallments,style: TextStyle(color: Theme.of(context).canvasColor,fontSize: 17,fontFamily: 'Nexa3'),textAlign: TextAlign.center,),
                                                                    shadowColor: renkler.koyuuRenk,
                                                                    contentPadding: EdgeInsets.only(top: 2,left: 16,right: 16,bottom: 2),
                                                                    actionsPadding: EdgeInsets.all(0),
                                                                    actions: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          TextButton(
                                                                            onPressed: () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child: Text(translation(context).no,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 17,fontFamily: 'Nexa3'),),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed: () {
                                                                              setState(() {
                                                                                readUpdateData.removeProcessOnce(item[index].id!);
                                                                              });
                                                                              Navigator.of(context).pop();
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  backgroundColor: Theme.of(context).highlightColor,
                                                                                  duration: const Duration(seconds: 1),
                                                                                  content: Text(
                                                                                    translation(context).installmentCancelled,
                                                                                    style: const TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 16,
                                                                                      fontFamily: 'Nexa3',
                                                                                      fontWeight: FontWeight.w600,
                                                                                      height: 1.3,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                            child: Text(translation(context).yesCancel,style: TextStyle(color: Theme.of(context).secondaryHeaderColor,fontSize: 17,fontFamily: 'Nexa3'),),
                                                                          ),
                                                                        ],

                                                                      )
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                          style: ButtonStyle(
                                                              backgroundColor:MaterialStatePropertyAll(Theme.of(context).disabledColor),
                                                              shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                                  const RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                          topRight: Radius.circular(5),
                                                                          topLeft: Radius.circular(5)
                                                                      )
                                                                  )),
                                                              padding: const MaterialStatePropertyAll(EdgeInsets.only(top: 2,left: 6,right: 6))
                                                          ),
                                                          child: Text(
                                                            translation(context).cancelInstallment,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                height : 1,
                                                                color: renkler
                                                                    .koyuuRenk),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height : 18,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            readDailyInfo.setSpendDetail(
                                                                item, index);
                                                            showModalBottomSheet(
                                                              isScrollControlled:true,
                                                              context: context,
                                                              shape:
                                                              const RoundedRectangleBorder(
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
                                                          style: ButtonStyle(
                                                              backgroundColor:MaterialStatePropertyAll(renkler.koyuuRenk),
                                                              shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                                  const RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                          topRight: Radius.circular(5),
                                                                          topLeft: Radius.circular(5)
                                                                      )
                                                                  )),
                                                              padding: const MaterialStatePropertyAll(EdgeInsets.only(top: 2,left: 6,right: 6))
                                                          ),
                                                          child: Text(
                                                            translation(context).activityDetailsSmall,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                height : 1,
                                                                color: renkler
                                                                    .arkaRenk),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16,),
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
                    "${translation(context).activeInstallmentActivities} ${item.length}",
                    style: TextStyle(
                        color: Theme.of(context).canvasColor, fontSize: 13, height: 1),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
