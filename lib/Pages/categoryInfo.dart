import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/constans/TextPref.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../UI/spendDetail.dart';

class categoryInfo extends ConsumerWidget {
  const categoryInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomColors renkler = CustomColors();
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: renkler.ArkaRenk,
          appBar: const appbarCategoryInfo(),
          body: const categoryInfoBody(),
        ),
      ),
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
    var readDailyInfo = ref.read(dailyInfoRiverpod);
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
                  height: size.height*0.72,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 11.5),
                            child: SizedBox(
                              width: 4,
                              height: size.height*0.72,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 11.5),
                            child: SizedBox(
                              width: 4,
                              height: size.height*0.72,
                              child:  DecoratedBox(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    color: snapshot.data!.length <= 8 ? Colors.white : Color(0xFF0D1C26)),
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
                                            return SpendDetail();
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
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width*0.98,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 15,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 1, right: 4),
                          child: Text(
                            "${item.length}",
                            style: const TextStyle(color: Color(0xFFE9E9E9),fontSize: 18,fontFamily: 'NEXA4'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 1, right: 4),
                          child: Text(
                            "${item.length}",
                            style: const TextStyle(color: Color(0xFFF2CB05),fontSize: 18,fontFamily: 'NEXA4'),
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
        padding: const EdgeInsets.only(top: 10, bottom: 5),
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
