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
                            child: Container(
                              height: 40,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: renkler.koyuuRenk,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () {

                                      },
                                      child: Text(
                                        "GELIR",
                                        style: TextStyle(
                                            color: renkler.YaziRenk,
                                            fontSize: 20
                                        ),

                                      )
                                  ),
                                  TextButton(
                                    onPressed: () {

                                    },
                                    child: Text(
                                      "GIDER",
                                      style: TextStyle(
                                          color: renkler.YaziRenk,
                                          fontSize: 20
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
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