import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';

class Aylikinfo extends StatelessWidget {
  const Aylikinfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ceyrekwsize = MediaQuery.of(context).size.width / 5;
    Aylikinfoclass f5 = new Aylikinfoclass("31 Sal", 0, 66.5, "Agustos", "2023", "Gider");  //aşağıda belirtilen class yapısından türler yaratıyoruz.
    Aylikinfoclass f4 = new Aylikinfoclass("22 Cum", 0, 30, "Agustos", "2023", "Gider");
    Aylikinfoclass f3 = new Aylikinfoclass("20 çar", 0, 250, "Agustos", "2023", "Gider");
    Aylikinfoclass f2 = new Aylikinfoclass("16 cmt", 500.0, 22.0, "Agustos", "2023", "Gelir");
    Aylikinfoclass f1 = new Aylikinfoclass("15 Cum", 200.0, 300.0, "Agustos", "2023", "Gider");

    List <Aylikinfoclass> Aylikinfoclasslist = [f5, f4, f3, f2, f1, f4, f3, f2, f1]; //class tipinde liste yaratıyoruz.
    return SizedBox(
      height: 221,
      child: Padding( //borderin scroll ile birleşimi gözüksü diye soldan padding
        padding: const EdgeInsets.only(left: 3.0),
        child: DecoratedBox( // border için
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(width: 5,color: Color(0xFF0D1C26)))
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              scrollbarTheme: ScrollbarThemeData(
                thumbColor: MaterialStateProperty.all(Color(0xFFF2CB05)),
              )
            ),
            child: Scrollbar(
              scrollbarOrientation: ScrollbarOrientation.left,
              isAlwaysShown: true,
              interactive: true,
              thickness: 8,
              radius: Radius.circular(15.0),
              child: ListView.builder(
                  itemCount : Aylikinfoclasslist.length,
                  itemBuilder: (BuildContext context, index) {
                    var toplam = Aylikinfoclasslist[index].gelir - Aylikinfoclasslist[index].gider ;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              height: 26.0,
                              color:  CustomColors.ArkaRenk,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: ceyrekwsize  ,
                                        child: Text(
                                          Aylikinfoclasslist[index].date,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                    ),
                                    SizedBox(
                                      width: ceyrekwsize,
                                      child: Center(
                                        child: Text(
                                          Aylikinfoclasslist[index].gelir.toString(),
                                          style: const TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ceyrekwsize,
                                      child: Center(
                                        child: Text(
                                          Aylikinfoclasslist[index].gider.toString(),
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ceyrekwsize,
                                      child: Center(
                                        child: Text(
                                          toplam.toString(),
                                          style: const TextStyle(
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      constraints: const BoxConstraints(
                                        maxHeight: 30,
                                      ),
                                      padding: const EdgeInsets.all(1),
                                      icon: const Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.black,
                                      ),
                                      onPressed: () => print("Bilgiler sekmesi"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4)   // elemanlar arasına bşluk bırakmak için kulllandım.
                      ],
                    );
                  }
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class Aylikinfoclass {
  final String date ;
  final double gelir;
  final double gider;
  final String ay ;
  final String yil ;
  final String status ;
  const Aylikinfoclass(this.date, this.gelir, this.gider, this.ay, this.yil, this.status) ;
}