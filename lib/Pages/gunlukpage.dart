import 'package:butcekontrol/Pages/addData.dart';
import 'package:butcekontrol/classes/appbarType2.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/constans/TextPref.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class gunlukpages extends ConsumerWidget {
  const gunlukpages( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomColors renkler = CustomColors();
    int gelirlength = 0;
    int giderlength = 0 ;
    var read = ref.read(databaseRiverpod);
    var readHome = ref.read(homeRiverpod);
    var size = MediaQuery.of(context).size ;
    var readnavbar = ref.read(botomNavBarRiverpod);
    var readeditInfo = ref.read(editinfoProvider);

    return Scaffold(
      backgroundColor: renkler.ArkaRenk,
      appBar: appbarType2(),
      body: FutureBuilder(
        future: read.myMethod2(),
        builder: (context, AsyncSnapshot<List<spendinfo>>snapshot) {
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
                  height: size.height - 179,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(border: Border(
                          right: BorderSide(width: 5, color: renkler
                              .koyuuRenk))),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            scrollbarTheme: ScrollbarThemeData(
                                thumbColor: MaterialStateProperty.all(
                                    renkler.sariRenk)
                            )
                        ),
                        child: Scrollbar(
                          scrollbarOrientation: ScrollbarOrientation.right,
                          thumbVisibility: true,
                          interactive: true,
                          thickness: 7,
                          radius: Radius.circular(15),
                          child: ListView.builder(
                            itemCount: item.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 15, top: 5, bottom: 5),
                                child: InkWell(
                                  onTap: () {
                                    {print(gelirlength);
                                      print(giderlength);
                                      ref.watch(databaseRiverpod).Delete ; //silme işlemi sonrası listeyi yeniletiyor.
                                      showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(30))
                                        ),
                                        backgroundColor: renkler.koyuuRenk,
                                        builder: (
                                            context) { // genel bilgi sekmesi açılıyor.
                                          return SizedBox(
                                            height: size.height / 1.2,
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 18.0,
                                                  vertical: 20.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      Textmod("İŞLEM DETAYI",
                                                          renkler.YaziRenk, 30),
                                                      Icon(
                                                        Icons.remove_red_eye,
                                                        color: renkler.sariRenk,
                                                        size: 30,
                                                      ),
                                                      Spacer(),
                                                      DecoratedBox(
                                                        decoration: BoxDecoration(
                                                          color: renkler
                                                              .YaziRenk,
                                                          borderRadius: BorderRadius
                                                              .circular(40),
                                                        ),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                          },
                                                          icon: const Icon(
                                                            Icons.clear,
                                                            size: 30,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Textmod("TARİH",
                                                          renkler.YaziRenk, 15),
                                                      SizedBox(
                                                        height: 15,
                                                        child: DecoratedBox(
                                                          decoration: BoxDecoration(
                                                            color: renkler
                                                                .ArkaRenk,
                                                            borderRadius: const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10)
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left: 15.0,
                                                                  right: 15.0,
                                                                  top: 2.0),
                                                              child: Text(
                                                                "${item[index]
                                                                    .operationDate}",
                                                                style: TextStyle(fontSize: 15,),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Textmod("SAAT",
                                                          renkler.YaziRenk, 15),
                                                      Textmod("${item[index]
                                                          .operationTime}",
                                                          renkler.YaziRenk, 18),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Textmod("KATEGORI",
                                                          renkler.YaziRenk, 15),
                                                      Textmod("${item[index]
                                                          .category}",
                                                          renkler.YaziRenk, 18),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Textmod("ÖDEME TÜRÜ",
                                                          renkler.YaziRenk, 15),
                                                      Textmod("${item[index]
                                                          .operationTool}",
                                                          renkler.YaziRenk, 18),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Textmod("TUTAR",
                                                          renkler.YaziRenk, 15),
                                                      Textmod("${item[index]
                                                          .amount}",
                                                          renkler.YaziRenk, 18),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Textmod("NOT",
                                                          renkler.YaziRenk, 15),
                                                      Textmod(
                                                          "${item[index].note}",
                                                          renkler.YaziRenk, 18),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceAround,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          DecoratedBox(
                                                            decoration: BoxDecoration(
                                                              color: renkler
                                                                  .sariRenk,
                                                              borderRadius: BorderRadius
                                                                  .circular(20),
                                                            ),
                                                            child: IconButton(
                                                                iconSize: 30,
                                                                icon: item[index].registration == 0
                                                                  ? Icon(Icons.bookmark_outline)
                                                                  : Icon(Icons.bookmark_outlined),
                                                                onPressed: () {
                                                                  ///updateedd DATA BAASEE LOOKK AT HERE
                                                                }
                                                                ),
                                                            ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 4.0),
                                                            child: Textmod("işaretle", renkler.sariRenk, 12),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          DecoratedBox(
                                                            decoration: BoxDecoration(
                                                              color: renkler
                                                                  .sariRenk,
                                                              borderRadius: BorderRadius
                                                                  .circular(20),
                                                            ),
                                                            child: IconButton(
                                                              icon: const Icon(
                                                                Icons.delete,
                                                                size: 30,
                                                              ),
                                                              onPressed: () {
                                                                read.Delete(item[index].id!);
                                                                read.myMethod2();
                                                                readnavbar.setCurrentindex(5);
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 4.0),
                                                            child: Textmod("Sil", renkler.sariRenk, 12),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          DecoratedBox(
                                                            decoration: BoxDecoration(
                                                              color: renkler.sariRenk,
                                                              borderRadius: BorderRadius.circular(20),
                                                            ),
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons.create_rounded,
                                                                size: 35,
                                                                color: renkler.YaziRenk,
                                                              ),
                                                              onPressed: () {
                                                                readeditInfo.set_id(item[index].id!);
                                                                Navigator.of(context).pop();
                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddData()));
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .only(top: 4.0),
                                                            child: Textmod(
                                                                "Düzenle",
                                                                renkler
                                                                    .sariRenk,
                                                                12),
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
                                        color: renkler.YaziRenk,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(9.0),
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              color: item[index].operationType == "Gider"
                                                  ? renkler.kirmiziRenk
                                                  : renkler.yesilRenk,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Textmod(
                                              "${item[index].category}",
                                              Colors.black, 19),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 8.0),
                                            child: item[index].operationType == "Gelir"
                                              ? Textmod(
                                                item[index].amount.toString().toUpperCase(), Colors.green, 18)
                                              :Textmod(item[index].amount.toString(), Colors.red, 18),
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
                    padding: EdgeInsets.only(top: 5.0, right: size.width * 0.017),
                    child: Row( //Toplam kayıt sayısını gösterecek
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${item.length}",
                          style: TextStyle(color: renkler.sariRenk),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: SizedBox( //arkaborder sabit kalıyor.
                          height: size.height * 0.038 , //26
                          width: size.width * 0.85,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: renkler.koyuuRenk,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(15)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          right: size.width * 0.65,
                          top: size.height * 0.008,
                          child: Textmod("${readHome.income}", renkler.YaziRenk, 17)),
                      //gelir bilgisi
                      Positioned(
                        left: size.width * 0.27,
                        child: SizedBox(
                          height: size.height * 0.05 , //30,
                          width: size.width * 0.2857,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20)),
                              color: renkler.sariRenk,
                            ),
                            child: Center(child: Textmod(
                                "${readHome.totally}", Colors.black, 17)), //Toplam değişim.
                          ),
                        ),
                      ),
                      Positioned(
                        left: size.width * 0.256 ,
                        top: size.height * 0.011,
                        child: SizedBox( //yesil top
                          height: size.width* 0.043,
                          width: size.width* 0.043,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: renkler.yesilRenk,
                              borderRadius: BorderRadius.all(Radius.circular(size.width * 0.048)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: size.width * 0.5279 ,
                        top: size.height * 0.011,
                        child: SizedBox( //kırmızı nokta
                          height: size.width* 0.043,
                          width: size.width* 0.043,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: renkler.kirmiziRenk,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: size.width * 0.6569,
                          top: size.height * 0.008,
                          child: Center(
                              child: Textmod("${readHome.expense}", renkler.YaziRenk, 17))),
                      //Gider bilgisi
                    ],
                  ),
                ), //Değişim miktarları gosterilecek
                Padding(
                  padding:  EdgeInsets.symmetric(
                      vertical: size.height * 0.0146 , horizontal: size.width * 0.0729 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text("${read.geliramount} Gelir Bilgisi"),
                      Text("${read.gideramount} gider bilgisi"),
                    ],
                  ),
                ), //degisim turune gore kayıt sayısı gosterilecek.
              ]
          );
        }
      ),
    );
  }
}