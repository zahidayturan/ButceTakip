import 'package:butcekontrol/UI/spend_detail.dart';
import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CategoryInfo extends ConsumerWidget {
  const CategoryInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomColors renkler = CustomColors();
    return Container(
      color: renkler.koyuuRenk,
      child: const SafeArea(
        child: Scaffold(
          bottomNavigationBar: null,
          //backgroundColor: renkler.arkaRenk,
          appBar: AppbarCategoryInfo(),
          body: CategoryInfoBody(),
        ),
      ),
    );
  }
}

class CategoryInfoBody extends ConsumerStatefulWidget {
  const CategoryInfoBody({Key? key}) : super(key: key);
  @override
  ConsumerState<CategoryInfoBody> createState() => _CategoryInfoBody();
}

class _CategoryInfoBody extends ConsumerState<CategoryInfoBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 6,
        ),
        list(context),
        dayDetailsGuide(context),
      ],
    );
  }

  Widget list(BuildContext context) {
    var readCategoryInfo = ref.read(categoryInfoRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    var readSettings = ref.read(settingsRiverpod);
    var size = MediaQuery.of(context).size;
    Future<List<SpendInfo>> myList = readCategoryInfo.myMethod2();
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
                              padding: EdgeInsets.only(left: 11.5, right: 11.5),
                              child: SizedBox(
                                width: 4,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 11.5, left: 11.5),
                              child: Container(
                                width: 4,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    color: snapshot.data!.length <= 10
                                        ? Theme.of(context).indicatorColor
                                        : Theme.of(context).canvasColor),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.fromSwatch(
                                  accentColor: const Color(0xFFF2CB05),
                                ),
                                scrollbarTheme: ScrollbarThemeData(
                                    thumbColor: MaterialStateProperty.all(
                                        Theme.of(context).dialogBackgroundColor))),
                            child: Scrollbar(
                              isAlwaysShown: true,
                              scrollbarOrientation: readSettings.localChanger() == Locale("ar") ? ScrollbarOrientation.left :
                              ScrollbarOrientation.right,
                              interactive: true,
                              thickness: 7,
                              radius: const Radius.circular(15),
                              child: ListView.builder(
                                itemCount: item.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 5, bottom: 5),
                                    child: InkWell(
                                      onTap: () {
                                        {
                                          readDailyInfo.setSpendDetail(item, index);
                                          ref.watch(databaseRiverpod).delete;
                                          showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(
                                                    top: Radius.circular(25))),
                                            backgroundColor:
                                                const Color(0xff0D1C26),
                                            builder: (context) {
                                              // genel bilgi sekmesi açılıyor.
                                              return const SpendDetail();
                                            },
                                          ).then((value) {
                                            item.length == 1 ? Navigator.pop(context) : null;
                                          });
                                        }
                                      },
                                      child: SizedBox(
                                        height: 48,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Theme.of(context).indicatorColor,
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
                                                          : Theme.of(context).canvasColor,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                "${item[index].operationDate}",
                                                style: TextStyle(
                                                  fontFamily: 'NEXA3',
                                                  fontSize: 18,
                                                  color: Theme.of(context).canvasColor,
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: item[index].operationType ==
                                                        "Gelir"
                                                    ? RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:item[index].realAmount.toString(),style: TextStyle(
                                                        fontFamily: 'NEXA3',
                                                        fontSize: 18,
                                                          color: Theme.of(context).canvasColor
                                                      ),
                                                      ),
                                                      TextSpan(
                                                        text: readSettings.prefixSymbol,
                                                        style: TextStyle(
                                                          fontFamily: 'TL',
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w600,
                                                            color: Theme.of(context).canvasColor
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ) : RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:item[index].realAmount.toString(),style: TextStyle(
                                                        fontFamily: 'NEXA3',
                                                        fontSize: 18,
                                                        color: renkler.kirmiziRenk,
                                                      ),
                                                      ),
                                                      TextSpan(
                                                        text: readSettings.prefixSymbol,
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
                      width: size.width*0.98,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 15,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                "${item.length}",
                                style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18,fontFamily: 'NEXA3'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                            child: Padding(
                              padding: const EdgeInsets.only( right: 5),
                              child: Text(
                                "${item.length}",
                                style: TextStyle(color: Theme.of(context).dialogBackgroundColor,fontSize: 18,fontFamily: 'NEXA3'),
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
    var readSettings = ref.read(settingsRiverpod);
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
                  child: Text(translation(context).totalAmountStatistics,style: TextStyle(
                    height: 1,
                    fontFamily: 'NEXA3',
                    fontSize: 17,
                    color: Theme.of(context).canvasColor,
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
                                fontFamily: 'NEXA3',
                                fontSize: 17,
                                color: Color(0xff0D1C26),
                              ),
                              ),
                              TextSpan(
                                text: readSettings.prefixSymbol,
                                style: const TextStyle(
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

class AppbarCategoryInfo extends ConsumerWidget implements PreferredSizeWidget {
  const AppbarCategoryInfo({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(80);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readSettings = ref.read(settingsRiverpod);
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
                decoration: BoxDecoration(
                  borderRadius: readSettings.localChanger() == const Locale("ar") ?
                  const BorderRadius.horizontal(
                    left: Radius.circular(15),
                  ) :
                  const BorderRadius.horizontal(
                    right: Radius.circular(15),
                  ),
                  color: Theme.of(context).highlightColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      myCategory[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "NEXA3",
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      myDate[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "NEXA3",
                        fontSize: 13,
                      ),
                    ),
                  ],
                ), /// başlıktaki yazılar
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15,),
              child: SizedBox(
                width: 40,
                height: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xff0D1C26),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    icon:  Image.asset(
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
            ), /// çarpı işareti
          ],
        ),
      ),
    );
  }
}
