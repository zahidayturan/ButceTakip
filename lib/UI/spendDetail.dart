import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Pages/updateData.dart';
import '../modals/Spendinfo.dart';

///örnek kullanım
/*
showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(25))),
    backgroundColor:
      const Color(0xff0D1C26),
    builder: (context) {
    // genel bilgi sekmesi açılıyor.
    return spendDetail(item: item, index: index);
    },
);
 */

class SpendDetail extends ConsumerStatefulWidget {
  const SpendDetail({super.key});
  @override
  _SpendDetailState createState() => _SpendDetailState();
}

class _SpendDetailState extends ConsumerState<SpendDetail> {
  @override
  Widget build(BuildContext context) {
    var readDB = ref.read(databaseRiverpod);
    var readNavBar = ref.read(botomNavBarRiverpod);
    var readUpdateData = ref.read(updateDataRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    List<spendinfo> item = readDailyInfo.getSpendDetailItem();
    int index = readDailyInfo.getSpendDetailIndex();
    var size = MediaQuery.of(context).size;
    return Padding(
      padding:
      const EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 20.0),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: double.infinity
        ),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceEvenly,
              children: [
                const Text(
                  "İşlem Detayı  ",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nexa4',
                    fontSize: 26,
                  ),
                ),
                const Icon(
                  Icons.remove_red_eye,
                  color:
                  Color(0xffF2CB05),
                  size: 34,
                ),
                const Spacer(),
                DecoratedBox(
                  decoration:
                  BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius
                        .circular(40),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(
                          context)
                          .pop();
                    },
                    icon: const Icon(
                      Icons.clear_rounded,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                const Text("TARİH",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa4',
                      fontSize: 18,
                    )),
                SizedBox(
                  height: 22,
                  child: DecoratedBox(
                    decoration:
                    const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius
                          .all(Radius
                          .circular(
                          15)),
                    ),
                    child: Center(
                      child: Padding(
                        padding:
                        const EdgeInsets
                            .only(
                            left:
                            15.0,
                            right:
                            15.0,
                            top: 2.0),
                        child: Text(
                          "${item[index].operationDate}",
                          style:
                          const TextStyle(
                            fontFamily:
                            'NEXA4',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                const Text("SAAT",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa4',
                      fontSize: 18,
                    )),
                Text(
                    "${item[index].operationTime}",
                    style:
                    const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa4',
                      fontSize: 18,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                const Text("KATEGORİ",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa4',
                      fontSize: 18,
                    )),
                Text(
                    "${item[index].category}",
                    style:
                    const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa4',
                      fontSize: 18,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                const Text("ÖDEME TÜRÜ",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa4',
                      fontSize: 18,
                    )),
                Text(
                    "${item[index].operationTool}",
                    style:
                    const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa4',
                      fontSize: 18,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                const Text("TUTAR",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa4',
                      fontSize: 18,
                    )),
                Text(
                    "${item[index].amount}",
                    style:
                    const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa4',
                      fontSize: 18,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                const Text("NOT",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa4',
                      fontSize: 18,
                    )),
                Widet01(item, index),
              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceAround,
              children: [
                /*Column(
                  children: [
                    DecoratedBox(
                      decoration:
                      BoxDecoration(
                        color: const Color(
                            0xFFF2CB05),
                        borderRadius:
                        BorderRadius
                            .circular(
                            50),
                      ),
                      child: IconButton(
                        onPressed: () {
                          readDailyInfo.regChange(item[index].registration);
                          readDailyInfo.updateRegistration(item[index].id);
                          //readDailyInfo.regChange(item[index].registration = item[index].registration == 0 ? 1 : 0);
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                              const Color(0xff0D1C26),
                              duration: const Duration(seconds: 1),
                              content: item[index].registration == 1 ? const Text(
                                'İşaret Kaldırıldı',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Nexa3',
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                ),
                              ) : const Text(
                                'İşaret Eklendi',
                                style: TextStyle(
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
                        iconSize: 30,
                        icon: item[index].registration == 0 ? const Icon(Icons.bookmark_outline) : const Icon(Icons.bookmark_outlined),
                      ),
                    ),
                    const Padding(
                      padding:
                      EdgeInsets.only(
                          top: 4.0),
                      child: Text(
                        "İşaretle",
                        style: TextStyle(
                          color: Color(
                              0xFFF2CB05),
                          fontFamily:
                          'Nexa3',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),*/
                Column(
                  children: [
                    DecoratedBox(
                      decoration:
                      BoxDecoration(
                        color: const Color(
                            0xFFF2CB05),
                        borderRadius:
                        BorderRadius
                            .circular(
                            50),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors
                              .white,
                        ),
                        onPressed: () {
                          readDB.Delete(
                              item[index]
                                  .id!);
                          readDB.myMethod2();
                          Navigator.of(
                              context)
                              .pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor:
                              Color(0xff0D1C26),
                              duration: Duration(seconds: 1),
                              content: Text(
                                'İşlem bilgisi silindi',
                                style: TextStyle(
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
                      ),
                    ),
                    const Padding(
                      padding:
                      EdgeInsets.only(
                          top: 4.0),
                      child: Text(
                        "Sil",
                        style: TextStyle(
                          color: Color(
                              0xFFF2CB05),
                          fontFamily:
                          'Nexa3',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    DecoratedBox(
                      decoration:
                      BoxDecoration(
                        color: const Color(
                            0xFFF2CB05),
                        borderRadius:
                        BorderRadius
                            .circular(
                            50),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons
                              .create_rounded,
                          size: 35,
                          color: Colors
                              .white,
                        ),
                        onPressed: () {
                          readUpdateData.setItems(spendinfo.withId(item[index].id!, item[index].operationType, item[index].category, item[index].operationTool, item[index].registration, item[index].amount, item[index].note, item[index].operationDay, item[index].operationMonth, item[index].operationYear, item[index].operationTime, item[index].operationDate));
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UpdateData(),));
                        },
                      ),
                    ),
                    const Padding(
                      padding:
                      EdgeInsets.only(
                          top: 4.0),
                      child: Text(
                        "Düzenle",
                        style: TextStyle(
                          color: Color(
                              0xFFF2CB05),
                          fontFamily:
                          'Nexa3',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Widet01(var item, var index) {  //not uzunluğuna karşın taşmayı önlemek için kurulmuştur.
    String longText = item[index].note ;
    List<String> parts = [];

    while (longText.isNotEmpty) {
      if (longText.length > 25) {
        parts.add(longText.substring(0, 25));
        longText = longText.substring(25);
      } else {
        parts.add(longText);
        longText = '';
      }
    }

    List<Text> textWidgets = parts.map((line) => Text(
        line,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: "Nexa3",
        fontSize: 18
      ),
    )).toList();

    return Column(
      children: textWidgets,
    );
  }
}
