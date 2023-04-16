import 'package:butcekontrol/UI/spendDetail.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
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
class registeryListW extends ConsumerWidget {
  const registeryListW({Key? key}) : super(key: key);
  ///Bu widgeti kullanmak için showDialog un çocuğu olarak göndermeniz gerekmektedir.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readDB = ref.read(databaseRiverpod);
    var readDailyInfo = ref.read(dailyInfoRiverpod);
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size ;
    return FutureBuilder(
      future: readDB.registeryList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var item = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(0),
          child: AlertDialog(
            content: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 377,
              ),
              child: Container(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Kaydedilen İşlemler",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Nexa3",
                              fontSize: 18
                          ),
                        ),
                        SizedBox(
                          height: 40 ,
                          width: 40,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: renkler.ArkaRenk,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height : 10.0 ,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [

                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "     İşlem\nKategorisi",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Nexa4",
                                ),
                              ),
                            ),
                            Text(
                              "  İşlem\nMiktarı",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Nexa4",
                              ),
                            ),
                          ],
                        ), //baslıklar
                        SizedBox(
                          height: 280,
                          child: Padding(
                            padding: EdgeInsets.only(left: 1),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  scrollbarTheme: ScrollbarThemeData(
                                      thumbColor: MaterialStateProperty.all(renkler.sariRenk)
                                  )
                              ),
                              child: SizedBox(
                                height: 300,
                                width:500,
                                child: Scrollbar(
                                  scrollbarOrientation: ScrollbarOrientation.right,
                                  thumbVisibility: true,
                                  interactive: true,
                                  thickness: 7,
                                  radius: Radius.circular(20),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 1),
                                    child:  DecoratedBox(
                                      decoration: BoxDecoration(
                                        border:item.length > 8 ? Border(
                                            right: BorderSide(
                                              width: 5,
                                              color: renkler.ArkaRenk,
                                            )
                                        )
                                            : Border(
                                            right: BorderSide(
                                              color: renkler.koyuuRenk,
                                              width: 1,
                                            )
                                        ) ,
                                      ),
                                      child: ListView.builder(
                                        itemCount: item.length,
                                        itemBuilder:  (context, index) {
                                          return  InkWell(
                                            onTap: () {
                                              readDailyInfo.setSpendDetail(item, index);
                                              showModalBottomSheet(
                                                context: context,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.vertical(
                                                        top: Radius.circular(25))),
                                                backgroundColor:
                                                const Color(0xff0D1C26),
                                                builder: (context) {
                                                  // genel bilgi sekmesi açılıyor.
                                                  ref.watch(databaseRiverpod).deletst;
                                                  return SpendDetail();
                                                },
                                              );
                                            },
                                            child: SizedBox(
                                              height: 35,
                                              child: Stack(
                                                fit: StackFit.expand,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:6,horizontal: 15),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(20),
                                                      child: Container(
                                                        color: renkler.ArkaRenk,
                                                        height: 1,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 2),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: size.width / 20,
                                                              ),
                                                              SizedBox(
                                                                width : size.width/3.6,
                                                                child: Center(
                                                                  child: Text(
                                                                    "${item[index].category}",
                                                                    style: const TextStyle(
                                                                      fontFamily: "Nexa4",
                                                                      fontSize: 15,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: size.width / 20,
                                                              ),
                                                              SizedBox(
                                                                width: size.width/5,
                                                                child: Center(
                                                                  child: Text(
                                                                    "${item[index].amount}",
                                                                    style: TextStyle(
                                                                      color: item[index].operationType == "Gelir"
                                                                          ? Colors.green
                                                                          : Colors.red ,
                                                                      fontFamily: "Nexa4",
                                                                      fontSize: 15,
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
                                                    left :1,
                                                    child: SizedBox(
                                                      width:  30,
                                                      height: 30,
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            color: renkler.ArkaRenk,
                                                            borderRadius: BorderRadius.circular(20)
                                                        ),
                                                        child: Icon(
                                                          Icons.remove_red_eye,
                                                          color: renkler.sariRenk,
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
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${item.length}",
                              style: TextStyle(
                                  color: renkler.sariRenk,
                                  fontSize: 13
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: renkler.koyuuRenk,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),

            ),
          ),
        );
      },
    );
  }
}
