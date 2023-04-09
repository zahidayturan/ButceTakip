import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class spendDetail extends ConsumerWidget {
  final item ;
  final index ;
  const spendDetail({Key? key, required this.item, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readDB = ref.read(databaseRiverpod);
    var readNavBar = ref.read(botomNavBarRiverpod);
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 1.2,
      child: Padding(
        padding:
        const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 20.0),
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
                Text(
                    "${item[index].note}",
                    style:
                    const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa3',
                      fontSize: 18,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceAround,
              children: [
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
                          iconSize: 30,
                          icon: item[index]
                              .registration ==
                              0
                              ? const Icon(
                              Icons
                                  .bookmark_outline)
                              : const Icon(
                              Icons
                                  .bookmark_outlined),
                          onPressed: () {
                            ///updateedd DATA BAASEE LOOKK AT HERE
                          }),
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
                ),
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
                          readNavBar
                              .setCurrentindex(
                              5);
                          Navigator.of(
                              context)
                              .pop();
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
                        onPressed: () {},
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
    );;
  }
}
