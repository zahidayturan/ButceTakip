import 'package:flutter/material.dart';
import 'package:butcekontrol/classes/appBarStatistics.dart';
import 'package:butcekontrol/classes/navBar.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:path/path.dart';

class Statistics extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _StatisticsState();

}

class _StatisticsState extends State<Statistics>{
  var listMonths = ["OCAK", "SUBAT", "MART", "NISAN", "MAYIS", "HAZIRAN", "TEMMUZ", "AGUSTOS", "EYLUL", "EKIM", "KASIM", "ARALIK"];
  var renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size ;

    return Scaffold(
      appBar: AppBarStatistics(),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(    // burasi üç sütundan oluşmaktadır ilk sütün gelir gider tuşları, ikinci sütun pasta şeması, üçüncü sütun tarih ve buton var
              children: [
                Expanded( // gelir gider butonlari, expanded kullanma nedeni satırı üç ayrı kolona ayırabilmek için.
                  child: Align( // butonları sola yasladım
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        RotatedBox( //butonları çevirmek için
                            quarterTurns: 3,
                            child: CustomButton(),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded( // burasi pasta modelinin olduğu kısımç
                  child: Column(
                    children: [
                      Text("slam")
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                  color: renkler.koyuuRenk,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container( // bunu ayrı bir dart dosyasında yazmaya çalış
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 40,
                                      child: Text('AY'),
                                      decoration: BoxDecoration(
                                        color: renkler.sariRenk,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                        // buraya ay yıl hafta açılabilir menu gelecek, veya stack i kullanarak position ile üstüne yazarız
                                      ),
                                    ),

                                    Text( // yukarıdaki oluşturulan ay listesinden indexleme ile ay çekiliyor
                                      "${listMonths[DateTime.now().month - 1]}",
                                      style: TextStyle(
                                        color: renkler.YaziRenk,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      " ${DateTime.now().year}",
                                      style: TextStyle(
                                        color: renkler.YaziRenk,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(),
          ],
        ),
      ),
      bottomNavigationBar: navBar(),
    );
  }
}


class CustomButton extends StatefulWidget { // gelir gider buton animasyonlari
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double buttonHeight = 34; //Basılmamış yükseklik
  double buttonHeight2 = 40; //Basılmış yükseklik
  Color containerColor2 = const Color(0xff0D1C26); //Basılmamış renk
  Color containerColor = const Color(0xffF2CB05); //Basılmış renk
  Color textColor2 = Colors.white; //Basılmamış yazı rengi
  Color textColor = const Color(0xff0D1C26); //Basılmış yazı rengi
  int index = 0; // Gider ve Gelir butonları arasında geçiş yapmak için

  void changeColor2(int index) {
    if (index == 0) { //index 0 olunca Gider için ayarlanıyor
      setState(() {
        buttonHeight2 = 40;
        buttonHeight = 34;
        containerColor = const Color(0xffF2CB05);
        containerColor2 = const Color(0xff0D1C26);
        textColor = const Color(0xff0D1C26);
        textColor2 = Colors.white;
        this.index = 1;
      });
    } else { //index 0'dan farklı olunca Gelir için ayarlanıyor
      setState(() {
        buttonHeight = 40;
        buttonHeight2 = 34;
        containerColor2 = const Color(0xffF2CB05);
        containerColor = const Color(0xff0D1C26);
        textColor = Colors.white;
        textColor2 = const Color(0xff0D1C26);
        this.index = 0;
      });
    }
  }

  Widget customButtonTheme2() {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              color: Color(0xff0D1C26),
            ),
            height: 34,
            width: 170,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 11),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: containerColor,
                  ),
                  height: buttonHeight2,
                  child: SizedBox(
                    width: 75,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            changeColor2(0);
                          });
                        },
                        child: Text("GİDER",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 17,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w800))),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: containerColor2,
                  ),
                  height: buttonHeight,
                  child: SizedBox(
                    width: 75,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            changeColor2(1);
                          });
                        },
                        child: Text("GELİR",
                            style: TextStyle(
                                color: textColor2,
                                fontSize: 17,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w800))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return customButtonTheme2();
  }
}