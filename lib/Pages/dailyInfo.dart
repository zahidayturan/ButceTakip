import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../UI/spendDetail.dart';

class dailyInfo extends ConsumerWidget {
  const dailyInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomColors renkler = CustomColors();
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: renkler.ArkaRenk,
          appBar: const AppbarDailyInfo(),
          body: const dailyInfoBody(),
        ),
      ),
    );
  }
}

class dailyInfoBody extends ConsumerStatefulWidget {
  const dailyInfoBody({Key? key}) : super(key: key);
  @override
  ConsumerState<dailyInfoBody> createState() => _dailyInfoBody();
}

class _dailyInfoBody extends ConsumerState<dailyInfoBody> {
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
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    var size = MediaQuery.of(context).size;
    Future<List<spendinfo>> myList = readDailyInfo.myMethod2();
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
                  height: size.height * 0.73,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 11.5),
                            child: SizedBox(
                              width: 4,
                              height: size.height * 0.73,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11.5),
                            child: SizedBox(
                              width: 4,
                              height: size.height * 0.72,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(30)),
                                    color: snapshot.data!.length <= 8
                                        ? Colors.white
                                        : const Color(0xFF0D1C26)),
                              ),
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

                                        readDailyInfo.setSpendDetail(item, index);
                                        readDailyInfo.regChange(item[index].registration);
                                        ref.watch(databaseRiverpod).Delete;
                                        showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(25))),
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
                                                fontFamily: 'NEXA4',
                                                fontSize: 18,
                                                color: Color(0xff0D1C26),
                                              ),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: item[index]
                                                          .operationType ==
                                                      "Gelir"
                                                  ? Text(
                                                      item[index]
                                                          .amount
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                        fontFamily: 'NEXA4',
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFF1A8E58),
                                                      ),
                                                    )
                                                  : Text(
                                                      item[index]
                                                          .amount
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontFamily: 'NEXA4',
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFFD91A2A),
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
                SizedBox(
                  width: size.width * 0.98,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 15,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 1, right: 4),
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
                          padding: const EdgeInsets.only(top: 1, right: 4),
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
              ]);
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "+${data[0]}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w900,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.15,
                          ),
                          Text(
                            "-${data[1]}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
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
                            fontSize: 20,
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
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
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

class AppbarDailyInfo extends ConsumerStatefulWidget implements PreferredSizeWidget {
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
  
  Widget appBar(BuildContext context,WidgetRef ref){
    List myDate = ref.read(dailyInfoRiverpod).getDate();
    var size = MediaQuery.of(context).size;
    return FutureBuilder<double>(
      future: ref.read(dailyInfoRiverpod).getResult(),
      builder: (context, snapshot) {
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
                        color: result >= 0 ? Colors.green : Colors.red,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${myDate[0]} ${myDate[1]} ${myDate[2]}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "NEXA4",
                              fontSize: 28,
                            ),
                          ),
                          const Text(
                            "İŞLEM DETAYLARI",
                            style: TextStyle(
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
          // show loading indicator
          return const CircularProgressIndicator();
        }
      },
    );
  }
}