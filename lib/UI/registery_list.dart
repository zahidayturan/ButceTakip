import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/textConverter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
                    readHome.menuControllerForRegistery == false ? translation(context).savedActivities : translation(context).lastActivities,
                    style: TextStyle(
                        color: Theme.of(context).canvasColor,
                        fontFamily: "Nexa4",
                        fontSize: 21,
                        height: 1
                    ),
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
                            color: readHome.menuControllerForRegistery == false ? renkler.koyuuRenk : Colors.white,
                            iconSize: 30,
                            onPressed: () {
                              setState(
                                      () {
                                        readHome.menuControllerForRegistery = !readHome.menuControllerForRegistery;
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
                  height: 8,
                ),
                readHome.menuControllerForRegistery == false ? registeryList(context, ref, setState) : lastOperationList(context, ref, setState),
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
  Widget registeryList(BuildContext context,WidgetRef ref,setState){
    var readDB = ref.read(databaseRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    var watchHome = ref.watch(homeRiverpod);
    return FutureBuilder(
      future: readDB.registeryList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var item = snapshot.data!;
        return  Column(
          children: [
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: readSettings.Language == "العربية" ? EdgeInsets.only(right: 56) : EdgeInsets.only(left: 56),
                    child: Text(
                      translation(context).category,
                      style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontFamily: "Nexa4",
                          fontSize: 15,
                        height: 1
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding:readSettings.Language == "العربية" ? EdgeInsets.only(left: 35) : EdgeInsets.only(right: 30),
                    child: Text(
                      translation(context).amount,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontFamily: "Nexa4",
                          fontSize: 15,
                        height: 1
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
                        height: 305,
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
                  height: 305,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1, right: 1),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.fromSwatch(
                            accentColor: Theme.of(context).disabledColor,
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
                                            isScrollControlled:true,
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
                                                                Converter().textConverterFromDB(item[index].category!, context, 0),
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
                    "${translation(context).numberOfSavedActivities} ${item.length}",
                    style: TextStyle(
                        color: Theme.of(context).canvasColor, fontSize: 13,
                        height: 1
                    ),

                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

  }

  List<String> lastList = ["10","30","50","100","200","300","500","1000"];
  String? selectedValueLastList;
  Widget lastOperationList(BuildContext context,WidgetRef ref,setState){
  var readDB = ref.read(databaseRiverpod);
  var readDailyInfo = ref.read(dailyInfoRiverpod);
  CustomColors renkler = CustomColors();
  var size = MediaQuery.of(context).size;
  var watchHome = ref.watch(homeRiverpod);
  return FutureBuilder(
    future: readDB.lastOperationList(selectedValueLastList != null ? int.tryParse(selectedValueLastList!)! : 10),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      var item = snapshot.data!;
      return Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translation(context).numberOfShowingActivities,
                  style: TextStyle(
                      color: Theme.of(context).canvasColor, fontSize: 15,height: 1,fontFamily: "Nexa4"),overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 40,
                  width: 80,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          "10",
                          style: TextStyle(
                              fontSize: 15,
                              height: 1,
                              color: Theme.of(context).canvasColor),
                        ),
                      ),
                      items: lastList!
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Center(
                          child: Text(
                            item,
                            style: TextStyle(
                                fontSize: 15,
                                height: 1,
                                color: Theme.of(context).canvasColor),
                          ),
                        ),
                      ))
                          .toList(),
                      value: selectedValueLastList,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValueLastList = value;
                        });
                      },
                      iconStyleData: const IconStyleData(
                        iconSize: 18,
                      ),
                      //alignment: Alignment.center,
                      dropdownStyleData: DropdownStyleData(
                          maxHeight: 160,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                          )),
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 36,
                        width: 96,
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        height: 32,
                        overlayColor:
                        MaterialStatePropertyAll(Theme.of(context).disabledColor),
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Positioned(
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 1),
                  child: Container(
                    width: 4,
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(30)),
                      color: item.length > 6
                          ? renkler.arkaRenk
                          : Theme.of(context).indicatorColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 280,
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
                                        height: 48,
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
                                                .spaceAround,
                                            children: [
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
                                                        fontSize: 16,
                                                        height: 1
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
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    item[index].operationTime!,
                                                    style:
                                                    const TextStyle(
                                                      fontFamily: "Nexa3",
                                                      fontSize: 13,
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                  "${translation(context).numberOfActivitiesForSearchSection} ${item.length}",
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