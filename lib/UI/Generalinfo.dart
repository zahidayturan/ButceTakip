import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';

class Generalinfo extends StatefulWidget {
  const Generalinfo({Key? key}) : super(key: key);

  @override
  State<Generalinfo> createState() => _GeneralinfoState();
}

class _GeneralinfoState extends State<Generalinfo> {
  var month = "Ağustos";
  var year = " 2023" ;
  var gelir = 6950.0 ;
  var gider = 440.5 ;
  var toplam = "+255.4" ;
  var renkler = CustomColors();

  @override
  Widget build(BuildContext context) {
    final double devicedata = MediaQuery.of(context).size.width;
    return Container(
      constraints: const BoxConstraints(
        maxHeight: double.infinity, //container in boyutunu içindekiler belirliyor.
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column( //Tarih bilgisini değiştirebilme
            children: [
              IconButton(
                icon: const Icon(
                  Icons.expand_less_sharp,
                  size: 30,
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minHeight: 28,
                  minWidth: 25,
                ),
                onPressed: () {},),
              ClipRRect( // yuvarlıyorum ay değişimi barını
                borderRadius: BorderRadius.only(topRight:Radius.circular(50),bottomRight: Radius.circular(50)),
                child: Container(
                  height: 24,
                  width: 110,
                  color: CustomColors.koyuuRenk,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        Text(
                          month,
                          style: const TextStyle(
                            color:  Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ), // Ay gösterge
                        const SizedBox(width: 2), // bunu verdim çünkü yıl ile ay arsnıdna boşluk yapmam gereiyordu.
                        Text(
                          year,
                         style: const TextStyle(
                           color:  Colors.white,
                           fontSize: 16,
                           fontWeight: FontWeight.bold,

                         ),
                        ), // Yıl gösterge
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                    Icons.expand_more,
                    size: 30,
                ),
                padding: EdgeInsets.zero,
                alignment: Alignment.topRight,
                constraints: const BoxConstraints(
                  minHeight: 28,
                  minWidth: 25,
                ),
                onPressed: () {},
              ),
            ],
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 3),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: SizedBox(
                width: devicedata - 110.0 ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Gelir",
                          style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "100" ,
                          style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ), //Gelir bilgisi
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          "Gider",
                          style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Text(
                        "500" ,
                        style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.normal,
                          color: Colors.red,
                          ),
                        ),
                        ],
                      ), // gider bilgisi
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Toplam",
                          style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          toplam ,
                          style: const TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),//Toplam bilgi
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 35  ,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 45,
                      ),
                      onPressed: () {  },
                    ), //Ayrıntılı gösterme butonu
                  ],
                ),
              ),
            ),
          ),//Aylık özet bilgileri
        ],
      ),
    );
  }
}
