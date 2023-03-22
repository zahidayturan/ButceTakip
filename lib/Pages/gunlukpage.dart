import 'package:butcekontrol/classes/appbarType2.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/constans/TextPref.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:flutter/material.dart';

class gunlukpages extends StatefulWidget {
  const gunlukpages({Key? key}) : super(key: key);
  @override
  State<gunlukpages> createState() => _gunlukpagesState();
}

class _gunlukpagesState extends State<gunlukpages> {
  CustomColors renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    spendinfo a =new spendinfo("200", "300", "Cumartesi", "Mart", "2023");
    List <spendinfo> anam = [a,a,a,a,a,a,a,a,a,a,a,a,a,a,a] ;
    var size = MediaQuery.of(context).size ;
    return Scaffold(
      backgroundColor: renkler.ArkaRenk,
      appBar: appbarType2(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: size.height - 155 ,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(border: Border(right:BorderSide(width: 5,color: renkler.koyuuRenk) )),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    scrollbarTheme: ScrollbarThemeData(
                      thumbColor: MaterialStateProperty.all(renkler.sariRenk)
                    )
                  ),
                  child: Scrollbar(
                    scrollbarOrientation: ScrollbarOrientation.right,
                    isAlwaysShown: true,
                    interactive: true,
                    thickness: 7,
                    radius: Radius.circular(15),
                    child: ListView.builder(
                        itemCount: anam.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 15, top: 5, bottom:  5),
                            child: InkWell(
                              onTap: () {
                                {

                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                                    ),
                                    backgroundColor: renkler.koyuuRenk,
                                    builder: (context) {
                                      return SizedBox(
                                        height: size.height/1.2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 20.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Textmod("İŞLEM DETAYI", renkler.YaziRenk, 30),
                                                  Icon(
                                                    Icons.remove_red_eye,
                                                    color: renkler.sariRenk,
                                                    size: 30,
                                                  ),
                                                  Spacer(),
                                                  DecoratedBox(
                                                    decoration:BoxDecoration(
                                                      color: renkler.YaziRenk,
                                                      borderRadius: BorderRadius.circular(40),
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      icon:  Icon(
                                                        Icons.clear,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Textmod("TARİH", renkler.YaziRenk, 15),
                                                  DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      color: renkler.ArkaRenk,
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                                      child: Text(
                                                          "mayıs"
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Textmod("SAAT",renkler.YaziRenk, 15),
                                                  Textmod("22.48",renkler.YaziRenk, 15),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Textmod("KATEGORI",renkler.YaziRenk, 15),
                                                  Textmod("Gunluk Yasam",renkler.YaziRenk, 15),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Textmod("ÖDEME TÜRÜ", renkler.YaziRenk, 15),
                                                  Textmod("Nakit", renkler.YaziRenk, 15),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Textmod("TUTAR",renkler.YaziRenk, 15),
                                                  Textmod("154,22",renkler.YaziRenk, 15),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Textmod("NOT",renkler.YaziRenk, 15),
                                                  Textmod("Günlerden PAzartesi \n hava hafif rüzgarlı", renkler.YaziRenk, 15),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      DecoratedBox(decoration: BoxDecoration(
                                                        color: renkler.sariRenk,
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons.bookmark_outlined,
                                                            size: 30,
                                                          ),
                                                          onPressed: () {
                                                          },),
                                                      ),
                                                      Textmod("işaretle", renkler.sariRenk, 12),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      DecoratedBox(decoration: BoxDecoration(
                                                        color: renkler.sariRenk,
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons.create_rounded,
                                                            size: 35,
                                                            color: renkler.YaziRenk,
                                                          ),
                                                          onPressed: () {},
                                                        ),
                                                      ),
                                                      Textmod("Düzenle", renkler.sariRenk, 12),
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
                                height: 48  ,
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: renkler.YaziRenk,
                                    ),
                                  child: Row(
                                    children: const [
                                      Padding(
                                        padding: const EdgeInsets.all(9.0),
                                        child: Icon(
                                          Icons.remove_red_eye,
                                          color : Colors.red ,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Textmod("EĞLENCE",Colors.black, 18),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Textmod("45 TL", Colors.green, 15),
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
            height: 15  ,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0,right: 5),
              child: Row(            //Toplam kayıt sayısını gösterecek
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "${anam.length}",
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
                SizedBox( //arkaborder sabit kalıyor.
                  height: 26,
                  width: size.width - 60,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: renkler.koyuuRenk,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                    ),
                  ),
                ),
                Positioned(right: size.width/1.6,top:6, child: Textmod("+240 TL",renkler.YaziRenk, 18)), //gelir bilgisi
                Positioned(
                  left: size.width/3.7,
                  child: SizedBox(
                    height: 30,
                    width: size.width/3.5,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color:  renkler.sariRenk,
                        ),
                      child: Center(child: Textmod("-143 TL", Colors.black, 20)), //Toplam değişim.
                    ),
                  ),
                ),
                Positioned(
                  left: size.width/3.9,
                  top: 5,
                  child: SizedBox( //yesil top
                    height: 18,
                    width: 18,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: renkler.yesilRenk,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                    ),
                  ),
                ),
                Positioned(
                  right: size.width/3.6,
                  top: 5,
                  child: SizedBox( //kırmızı nokta
                    width: 18,
                    height: 18,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: renkler.kirmiziRenk,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                Positioned(left: size.width/1.6,top: 6 ,child: Center(child: Textmod("-383 TL",renkler.YaziRenk, 18))), //Gider bilgisi
              ],
            ),
          ), //Değişim miktarları gosterilecek
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("0 Gelir Bilgisi"),
                Text("15 gider bilgisi"),
              ],
            ),
          ), //degisim turune gore kayıt sayısı gosterilecek.
        ],
      ) ,
    );
  }
}
