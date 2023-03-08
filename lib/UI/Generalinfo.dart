import 'package:butcekontrol/constains/MaterialColor.dart';
import 'package:flutter/material.dart';

class Generalinfo extends StatefulWidget {
  const Generalinfo({Key? key}) : super(key: key);

  @override
  State<Generalinfo> createState() => _GeneralinfoState();
}

class _GeneralinfoState extends State<Generalinfo> {
  var month = "Mart";
  var year = " 2023" ;
  var gelir = 695.9 ;
  var renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(
            maxHeight: double.infinity,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.expand_less_sharp,
                      size: 35.0,
                    ),
                    onPressed: () {},
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(topRight:Radius.circular(50),bottomRight: Radius.circular(50)),
                    child: Container(
                      height: 25,
                      width: 105,
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            Text(
                              month,
                              style: const TextStyle(
                                color:  Colors.white,
                                fontSize: 18,
                              ),
                            ), // Ay gösterge
                            const SizedBox(width: 5),
                            Text(
                              year,
                             style: const TextStyle(
                               color:  Colors.white,
                               fontSize: 18,
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
                        size: 35.0,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),//Tarih bilgisini değiştirebilme
              DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Gelir",
                            style: TextStyle(
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Text(
                            gelir.toString() ,
                            style: const TextStyle(
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ), //Gelir bilgisi
                      SizedBox(width: 20), // araya noşluk vermek için kullandım
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Gider",
                            style: TextStyle(
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        Text(
                          gelir.toString() ,
                          style: const TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                            color: Colors.red,
                            ),
                          ),
                          ],
                        ), // gider bilgisi
                      SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Toplam",
                            style: TextStyle(
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Text(
                            gelir.toString() ,
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
                        onPressed: () {  },
                      ), //Ayrıntılı gösterme butonu
                    ],
                  ),
                ),
              ),//Aylık özet bilgileri
            ],
          ),
        ),

      ],
    );
  }
}
