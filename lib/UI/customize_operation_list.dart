import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomizeList extends ConsumerWidget {
  const CustomizeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readUpdateData = ref.read(updateDataRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: readUpdateData.getCustomizeRepeatedOperation(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var item = snapshot.data!;
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
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
                      "Tekrarlı İşlemler",
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
                  height: 12.0,
                ),
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
                            color: item.length > 5
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
                                accentColor: Color(0xFFF2CB05),
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
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            readDailyInfo.setSpendDetail(item, index);
                                            showModalBottomSheet(
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
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 15),
                                            child: Container(
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).indicatorColor,
                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${item[index].processOnce}",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily: "Nexa3",
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${item[index].amount}",
                                                          style: TextStyle(
                                                            color: item[index]
                                                                        .operationType ==
                                                                    "Gider"
                                                                ? renkler.kirmiziRenk
                                                                : Theme.of(context).canvasColor,
                                                            fontFamily: "Nexa4",
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${item[index].operationDate}",
                                                          style:
                                                          const TextStyle(
                                                            fontFamily: "Nexa3",
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${item[index].category}",
                                                          style: TextStyle(
                                                            color: Theme.of(context).canvasColor,
                                                            fontFamily: "Nexa3",
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 82,
                                                          height: 15,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6)),
                                                            color: Theme.of(context).canvasColor
                                                          ),
                                                          child: Center(child: Padding(
                                                            padding: const EdgeInsets.only(top: 2),
                                                            child: Text("İşlem Detayları",style: TextStyle(fontSize: 10,color: Theme.of(context).primaryColor),),
                                                          )),
                                                        ),
                                                        Container(
                                                          width: 82,
                                                          height: 15,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6)),
                                                              color: renkler.sariRenk
                                                          ),
                                                          child: Center(child: Padding(
                                                            padding: const EdgeInsets.only(top: 2),
                                                            child: Text("Tekrarı İptal Et",style: TextStyle(fontSize: 10,color: renkler.koyuuRenk),),
                                                          )),
                                                        ),
                                                        Container(
                                                          width: 82,
                                                          height: 15,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6)),
                                                              color: Theme.of(context).canvasColor
                                                          ),
                                                          child: Center(child: Padding(
                                                            padding: const EdgeInsets.only(top: 2),
                                                            child: Text("Tekrarı Düzenle",style: TextStyle(fontSize: 10,color: Theme.of(context).primaryColor),),
                                                          )),
                                                        )
                                                      ],
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
                        "Aktif Tekrarlı İşlem Sayısı : ${item.length}",
                        style: TextStyle(
                            color: Theme.of(context).canvasColor, fontSize: 13),
                      ),
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
