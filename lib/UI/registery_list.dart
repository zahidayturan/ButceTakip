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
                          color: renkler.sariRenk,
                          fontFamily: "Nexa3",
                          fontSize: 21),
                    ),
                    SizedBox(
                    height: 36,
                    width: 36,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: renkler.arkaRenk,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(20)),
                      ),
                      child:   IconButton(
                        icon: Image.asset(
                          "assets/icons/remove.png",
                          height: 18,
                          width: 18,
                        ),
                        iconSize: 26,
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
                Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "     İşlem\nKategorisi",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Nexa3",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            "  İşlem\nMiktarı",
                            style: TextStyle(
                              color: Colors.white,
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
                                width: 5,
                                height: 290,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                  color: item.length > 8
                                      ? renkler.arkaRenk
                                      : renkler.koyuuRenk,),
                              ),
                            ),
                            /*
                            DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: item.length > 8
                                        ? renkler.arkaRenk
                                        : renkler.koyuuRenk,
                                    width: item.length > 8 ? 5 : 1,
                                  ),
                                ),
                              ),
                            ),*/
                          ],
                        ),
                        SizedBox(
                          height: 280,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  scrollbarTheme: ScrollbarThemeData(
                                      thumbColor: MaterialStateProperty.all(
                                          renkler.sariRenk))),
                              child: SizedBox(
                                height: 300,
                                width: 300,
                                child: Scrollbar(
                                  scrollbarOrientation:
                                      ScrollbarOrientation.right,
                                  thumbVisibility: true,
                                  interactive: true,
                                  thickness: 7,
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
                                                      color:
                                                          renkler.arkaRenk,
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
                                                          color: renkler
                                                              .arkaRenk,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Icon(
                                                        Icons
                                                            .remove_red_eye,
                                                        color: renkler
                                                            .sariRenk,
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
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            "Kaydedilen İşlem Sayısı : ${item.length}",
                            style: TextStyle(
                                color: renkler.arkaRenk, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: renkler.koyuuRenk,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );
  }
}
/*

 */
