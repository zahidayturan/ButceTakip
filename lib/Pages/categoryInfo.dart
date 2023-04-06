import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/constans/TextPref.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class categoryInfo extends ConsumerWidget {
  const categoryInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomColors renkler = CustomColors();
    var read = ref.read(databaseRiverpod);
    var readCategoryInfo = ref.read(categoryInfoRiverpod);
    var size = MediaQuery.of(context).size;
    var readHome = ref.read(homeRiverpod);
    var readnavbar = ref.read(botomNavBarRiverpod);
    return Scaffold(
      backgroundColor: renkler.ArkaRenk,
      appBar: const appbarCategoryInfo(),
      body: const categoryInfoBody(),
    );
  }
}

class categoryInfoBody extends ConsumerStatefulWidget {
  const categoryInfoBody({Key? key}) : super(key: key);
  @override
  ConsumerState<categoryInfoBody> createState() => _categoryInfoBody();
}

class _categoryInfoBody extends ConsumerState<categoryInfoBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        list(context),
        dayDetailsGuide(context),
      ],
    );
  }

  Widget list(BuildContext context) {
    var read = ref.read(databaseRiverpod);
    var readCategoryInfo = ref.read(categoryInfoRiverpod);
    var size = MediaQuery.of(context).size;
    Future<List<spendinfo>> myList = readCategoryInfo.myMethod2();
    var readnavbar = ref.read(botomNavBarRiverpod);
    return FutureBuilder(
        future: myList,
        builder: (context, AsyncSnapshot<List<spendinfo>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var item = snapshot.data!; // !
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height - 185,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: 5, color: Color(0xff0D1C26)))),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            scrollbarTheme: ScrollbarThemeData(
                                thumbColor: MaterialStateProperty.all(
                                    const Color(0xffF2CB05)))),
                        child: Scrollbar(
                          scrollbarOrientation: ScrollbarOrientation.right,
                          isAlwaysShown: true,
                          interactive: true,
                          thickness: 7,
                          radius: const Radius.circular(15),
                          child: ListView.builder(
                            itemCount: item.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 15, top: 5, bottom: 5),
                                child: InkWell(
                                  onTap: () {
                                    {
                                      ref.watch(databaseRiverpod).Delete;
                                      showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(25))),
                                        backgroundColor:
                                            const Color(0xff0D1C26),
                                        builder: (context) {
                                          // genel bilgi sekmesi açılıyor.
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
                                                                read.Delete(
                                                                    item[index]
                                                                        .id!);
                                                                read.myMethod2();
                                                                readnavbar
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
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: SizedBox(
                                    height: 48,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(9.0),
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              color:
                                                  item[index].operationType ==
                                                          "Gider"
                                                      ? const Color(0xFFD91A2A)
                                                      : const Color(0xFF1A8E58),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${item[index].operationDate}",
                                            style: const TextStyle(
                                              fontFamily: 'NEXA4',
                                              fontSize: 18,
                                              color: Color(0xff0D1C26),
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: item[index].operationType ==
                                                    "Gelir"
                                                ? Text(
                                                    item[index]
                                                        .amount
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                      fontFamily: 'NEXA4',
                                                      fontSize: 18,
                                                      color: Color(0xFF1A8E58),
                                                    ),
                                                  )
                                                : Text(
                                                    item[index]
                                                        .amount
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontFamily: 'NEXA4',
                                                      fontSize: 18,
                                                      color: Color(0xFFD91A2A),
                                                    ),
                                                  ),
                                          )
                                        ],
                                      ),
                                    ),
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
                SizedBox(
                  height: 15,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${item.length}",
                          style: const TextStyle(color: Color(0xFFF2CB05)),
                        )
                      ],
                    ),
                  ),
                ),
              ]);
        });
  }
  Widget dayDetailsGuide(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(categoryInfoRiverpod);
    return FutureBuilder<double>(
      future: read.getTotalAmount(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          double data = snapshot.data!;
          return SizedBox(
            width: size.width * 0.9,
            height: size.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 210,
                  child: Text("Toplam Tutar",style: const TextStyle(
                    fontFamily: 'NEXA4',
                    fontSize: 17,
                    color: Color(0xff0D1C26),
                  ),),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffF2CB05),
                  ),
                  height: 26,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10,left: 10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: data.toStringAsFixed(2),style: const TextStyle(
                                fontFamily: 'NEXA4',
                                fontSize: 17,
                                color: Color(0xff0D1C26),
                              ),
                              ),
                              const TextSpan(
                                text: ' ₺',
                                style: TextStyle(
                                  fontFamily: 'TL',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }



}

class appbarCategoryInfo extends ConsumerWidget implements PreferredSizeWidget {
  const appbarCategoryInfo({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(80);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var read = ref.read(categoryInfoRiverpod);
    var size = MediaQuery.of(context).size;
    List myCategory = read.getCategory();
    List myDate = read.getDate();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 66,
              width: size.width - 80,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(15),
                  ),
                  color: Color(0xff0D1C26),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      myCategory[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "NEXA4",
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      myDate[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "NEXA4",
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xff0D1C26),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //readNavBar.setCurrentindex(0);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
