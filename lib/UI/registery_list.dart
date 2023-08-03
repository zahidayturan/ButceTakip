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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "     İşlem\nKategorisi",
                            style: TextStyle(
                              color: Theme.of(context).canvasColor,
                              fontFamily: "Nexa3",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 35),
                          child: Text(
                            " İşlem\nTutarı",
                            style: TextStyle(
                              color: Theme.of(context).canvasColor,
                              fontFamily: "Nexa3",
                            ),
                          ),
                        ),
                      ],
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
                              padding: const EdgeInsets.only(right: 1),
                              child: Container(
                                width: 4,
                                height: 290,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                  color: item.length > 8
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
                            padding: const EdgeInsets.only(left: 1),
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
                                      ScrollbarOrientation.right,
                                  thumbVisibility: true,
                                  interactive: true,
                                  thickness: 6,
                                  radius: const Radius.circular(20),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(right: 1),
                                    child: ListView.builder(
                                      itemCount: item.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
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
                                                                  25))),
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
                                          child: SizedBox(
                                            height: 35,
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 6,
                                                      horizontal: 15),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(20),
                                                    child: Container(
                                                      color: Theme.of(context).indicatorColor,
                                                      height: 1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 2),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.width /
                                                                      20,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width /
                                                                      3.6,
                                                              child: Center(
                                                                child: Text(
                                                                  "${item[index].category}",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        "Nexa3",
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width /
                                                                      20,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width /
                                                                      5,
                                                              child: Center(
                                                                child: Text(
                                                                  "${item[index].amount}",
                                                                  style:
                                                                      TextStyle(
                                                                    color: item[index].operationType ==
                                                                            "Gelir"
                                                                        ? Colors.green
                                                                        : Colors.red,
                                                                    fontFamily:
                                                                        "Nexa3",
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 2,
                                                  left: 1,
                                                  child: SizedBox(
                                                    width: 30,
                                                    height: 30,
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
                                          ),
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
