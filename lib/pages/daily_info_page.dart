import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../UI/spend_detail.dart';

class DailyInfo extends ConsumerWidget {
  const DailyInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomColors renkler = CustomColors();
    return SafeArea(
      child: Scaffold(
        backgroundColor: renkler.arkaRenk,
        appBar: const AppbarDailyInfo(),
        body: const DailyInfoBody(),
      ),
    );
  }
}

class DailyInfoBody extends ConsumerStatefulWidget {
  const DailyInfoBody({Key? key}) : super(key: key);
  @override
  ConsumerState<DailyInfoBody> createState() => _DailyInfoBody();
}

class _DailyInfoBody extends ConsumerState<DailyInfoBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        list(context),
        dayDetailsGuide(context),
        dayTypeCount(context)
      ],
    );
  }

  int? registrationState;
  Widget list(BuildContext context) {
    ref.listen(databaseRiverpod, (previous, next) {
      return ref.watch(databaseRiverpod);
    });
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    var size = MediaQuery.of(context).size;
    Future<List<SpendInfo>> myList = readDailyInfo.myMethod2();
    CustomColors renkler = CustomColors();
    return FutureBuilder(
            future: myList,
            builder: (context, AsyncSnapshot<List<SpendInfo>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var item = snapshot.data!; // !
              return Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 11.5),
                                  child: SizedBox(
                                    width: 4,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 11.5),
                                  child: Container(
                                    width: 4,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                        color: snapshot.data!.length <= 8
                                            ? Colors.white
                                            : const Color(0xFF0D1C26)),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    scrollbarTheme: ScrollbarThemeData(
                                        thumbColor: MaterialStateProperty.all(
                                            const Color(0xffF2CB05)))),
                                child: Scrollbar(
                                  isAlwaysShown: true,
                                  scrollbarOrientation: ScrollbarOrientation.right,
                                  interactive: true,
                                  thickness: 7,
                                  radius: const Radius.circular(15),
                                  child: ListView.builder(
                                    itemCount: item.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 15, top: 5),
                                        child: InkWell(
                                          onTap: () {
                                            {
                                              readDailyInfo.setSpendDetail(
                                                  item, index);
                                              readDailyInfo.regChange(
                                                  item[index].registration);
                                              ref.watch(databaseRiverpod).delete;
                                              showModalBottomSheet(
                                                context: context,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            25))),
                                                backgroundColor:
                                                const Color(0xff0D1C26),
                                                builder: (context) {
                                                  //ref.watch(databaseRiverpod).updatest;
                                                  // genel bilgi sekmesi açılıyor.
                                                  return const SpendDetail();
                                                },
                                              );
                                            }
                                          },
                                          child: SizedBox(
                                            height: 48,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(9.0),
                                                    child: Icon(
                                                      Icons.remove_red_eye,
                                                      color: item[index]
                                                          .operationType ==
                                                          "Gider"
                                                          ? const Color(0xFFD91A2A)
                                                          : const Color(0xFF1A8E58),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "${item[index].category}",
                                                    style: const TextStyle(
                                                      fontFamily: 'NEXA3',
                                                      fontSize: 18,
                                                      color: Color(0xff0D1C26),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        right: 8.0),
                                                    child : item[index]
                                                        .operationType ==
                                                        "Gelir"
                                                        ? RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:item[index].amount.toString(),style: TextStyle(
                                                            fontFamily: 'NEXA3',
                                                            fontSize: 18,
                                                            color: renkler.yesilRenk,
                                                          ),
                                                          ),
                                                           TextSpan(
                                                            text: ' ₺',
                                                            style: TextStyle(
                                                              fontFamily: 'TL',
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w600,
                                                              color: renkler.yesilRenk,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ) : RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:item[index].amount.toString(),style: TextStyle(
                                                            fontFamily: 'NEXA3',
                                                            fontSize: 18,
                                                            color: renkler.kirmiziRenk,
                                                          ),
                                                          ),
                                                          TextSpan(
                                                            text: ' ₺',
                                                            style: TextStyle(
                                                              fontFamily: 'TL',
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w600,
                                                              color: renkler.kirmiziRenk,
                                                            ),
                                                          ),
                                                        ],
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: SizedBox(
                          width: size.width * 0.98,
                          height: 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 15,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    "${item.length}",
                                    style: const TextStyle(
                                        color: Color(0xFFE9E9E9),
                                        fontSize: 18,
                                        fontFamily: 'NEXA4'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    "${item.length}",
                                    style: const TextStyle(
                                        color: Color(0xFFF2CB05),
                                        fontSize: 18,
                                        fontFamily: 'NEXA4'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              );
            });
  }

  Widget dayDetailsGuide(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var read = ref.read(dailyInfoRiverpod);
    return FutureBuilder<List>(
      future: read.getMonthDaily(read.day, read.month, read.year),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data!;
          return SizedBox(
            width: size.width * 0.90,
            height: size.height * 0.05,
            child: Stack(
              children: [
                Positioned(
                  top: 3,
                  child: SizedBox(
                    height: size.height * 0.04,
                    width: size.width * 0.90,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff1A8E58), Color(0xffD91A2A)],
                          stops: [0.5, 0.5],
                        ),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " +${data[0]}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w900,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.15,
                          ),
                          Text(
                            "-${data[1]} ",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w900,
                              height: 1.4,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //gelir bilgisi
                Center(
                  child: SizedBox(
                    height: size.height * 0.05,
                    width: size.width / 3.5,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xffF2CB05),
                      ),
                      child: Center(
                        child: Text(
                          "${data[2]}",
                          style: const TextStyle(
                            color: Color(0xff0D1C26),
                            fontSize: 18,
                            fontFamily: 'Nexa3',
                            fontWeight: FontWeight.w900,
                            height: 1.4,
                          ),
                        ),
                      ), //Toplam değişim.
                    ),
                  ),
                ),
                //Gider bilgisi
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget dayTypeCount(BuildContext context) {
    var read = ref.read(dailyInfoRiverpod);
    return FutureBuilder<List>(
      future: read.getDayAmountCount(read.day, read.month, read.year),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${data[0]} Gelir Bilgisi",
                  style: const TextStyle(
                    color: Color(0xff0D1C26),
                    fontFamily: 'Nexa3',
                    fontSize: 18,
                  ),
                ),
                Text("${data[1]} Gider Bilgisi",
                    style: const TextStyle(
                      color: Color(0xff0D1C26),
                      fontFamily: 'Nexa3',
                      fontSize: 18,
                    )),
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

class AppbarDailyInfo extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const AppbarDailyInfo({Key? key}) : super(key: key);
  @override
  ConsumerState<AppbarDailyInfo> createState() => _AppbarDailyInfoState();
  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _AppbarDailyInfoState extends ConsumerState<AppbarDailyInfo> {
  @override
  Widget build(BuildContext context) {
    return appBar(context, ref);
  }

  CustomColors renkler = CustomColors();
  Widget appBar(BuildContext context, WidgetRef ref) {
    ref.listen(databaseRiverpod, (previous, next) {
      return ref.watch(databaseRiverpod);
    });
    List myDate = ref.read(dailyInfoRiverpod).getDate();
    var size = MediaQuery.of(context).size;
    return FutureBuilder<double>(
      future: ref.read(dailyInfoRiverpod).getResult(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Veri henüz gelmediğinde veya gecikme yaşandığında
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 55,
                    width: size.width - 80,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(15),
                        ),
                        color: renkler.arkaRenk,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${myDate[0]} ${myDate[1]} ${myDate[2]}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Nexa3",
                              fontSize: 28,
                            ),
                          ),
                          const Text(
                            "İŞLEM DETAYLARI",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Nexa3",
                              fontWeight: FontWeight.w400,
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
        if (snapshot.hasData) {
          double result = snapshot.data!;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 55,
                    width: size.width - 80,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(15),
                        ),
                        color: result >= 0
                            ? renkler.yesilRenk
                            : renkler.kirmiziRenk,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${myDate[0]} ${myDate[1]} ${myDate[2]}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "NEXA3",
                              fontSize: 28,
                            ),
                          ),
                          const Text(
                            "İŞLEM DETAYLARI",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "NEXA3",
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
                          icon: Image.asset(
                            "assets/icons/remove.png",
                            height: 16,
                            width: 16,
                            color: Colors.white,
                          ),
                          onPressed: () {
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
        } else {
          return const SizedBox();
        }
      },
    );
  }
}