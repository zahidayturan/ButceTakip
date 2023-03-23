import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/utils/dpHelper.dart';
import 'package:flutter/material.dart';

class GunlukInfo extends StatefulWidget{
  const GunlukInfo({super.key});


  @override
  State<StatefulWidget> createState() => _GunlukInfoState();

}

class _GunlukInfoState extends State<GunlukInfo>{
  bool _isLoading = true;
/*
  void _refreshSpendinfoList() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshSpendinfoList();
  }

 */ // şuan kullanılmadığı için yorum satırı yaptım
  final ScrollController Scrollbarcontroller2 = ScrollController();
  var renkler = CustomColors();
  List<Map<String, dynamic>> myData = [
    {'kategori': 'Burs', 'odeme': 'Kart', 'miktar' : 20, 'saat' : 14.55, 'gelir' : 1},
    {'kategori': 'Diger', 'odeme': 'Nakit', 'miktar' : 40, 'saat' : 16.21, 'gelir' : 0},
    {'kategori': 'Yemek', 'odeme': 'Nakit', 'miktar' : 20, 'saat' : 13.22, 'gelir' : 0},
    {'kategori': 'Bahsis', 'odeme': 'Kart', 'miktar' : 49, 'saat' : 10.34, 'gelir' : 1},
    {'kategori': 'Market', 'odeme': 'Nakit', 'miktar' : 100, 'saat' : 19.27, 'gelir' : 0},
    {'kategori': 'Ulasım', 'odeme': 'Kart', 'miktar' : 20, 'saat' : 22.14, 'gelir' : 0},
    {'kategori': 'Yemek', 'odeme': 'Nakit', 'miktar' : 15, 'saat' : 4.22, 'gelir' : 0},
    {'kategori': 'Ulasım', 'odeme': 'Nakit', 'miktar' : 19, 'saat' : 4.11, 'gelir' : 0},
    {'kategori': 'Ulasım', 'odeme': 'Kart', 'miktar' : 39, 'saat' : 1.45, 'gelir' : 0},
  ];

  Widget gelirGiderInfo(int index, List<Map<String, dynamic>> mydata) { //bu fonksiyon gelir mi gider mi diye kontrol ediyor. ona göre sayının rengi ayarlanıyor
    if (mydata[index]['gelir'] == 1) {
      return Text(
        '${mydata[index]['miktar']}',
        style: TextStyle(
          color: renkler.yesilRenk,
        ),
      );
    } else {
      return Text(
        '${mydata[index]['miktar']}',
        style: TextStyle(
          color: renkler.kirmiziRenk,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row( // günlük yarcama yazı ve tarih kısmı
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(bottomRight:Radius.circular(20), topRight:Radius.circular(20)),
                      color: renkler.sariRenk,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 10, top: 5,),
                      child: Text(
                          "Bügünün islem bilgileri",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only( right: 25, top: 5,),
                child: Text(
                    '22.11.2023',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )

            ],
          ),

        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 27, top: 15,),
                child: Row( // tür bilgilendirme kısmı.(kategori, ödeme, miktar, saat)
                  children: [
                    Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 16,
                        color: renkler.koyuuRenk,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 42),
                    Text(
                      'Ödeme',
                      style: TextStyle(
                        fontSize: 16,
                        color: renkler.koyuuRenk,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 48),
                    Text(
                      'Miktar',
                      style: TextStyle(
                        fontSize: 16,
                        color: renkler.koyuuRenk,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 45),
                    Text(
                      'Saat',
                      style: TextStyle(
                        fontSize: 16,
                        color: renkler.koyuuRenk,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 160,
                child: Padding(      //borderin scroll ile birleşimi gözüksü diye soldan padding
                  padding: const EdgeInsets.only(left: 3.0, top: 5, bottom: 10),
                  child: DecoratedBox( // border için
                    decoration: const BoxDecoration(
                        border: Border(left: BorderSide(width: 5,color: Color(0xFF0D1C26)))
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          scrollbarTheme: ScrollbarThemeData(
                            thumbColor: MaterialStateProperty.all(renkler.sariRenk),
                          )
                      ),
                      child: Scrollbar(
                        controller: Scrollbarcontroller2,
                        thumbVisibility: true,
                        scrollbarOrientation: ScrollbarOrientation.left,
                        interactive: true,
                        thickness: 8,
                        radius: Radius.circular(15.0),
                        child: ListView.builder(
                            itemCount : myData.length,
                            itemBuilder: (BuildContext context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15, right: 10),
                                    child: ClipRRect(           //Borderradius vermek için kullanıyoruz
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Container(
                                        height: 27.4,
                                        color:  renkler.ArkaRenk,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 12, right: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 30,left: 10),
                                                child: SizedBox(
                                                  child: Text(
                                                    '${myData[index]['kategori']}'
                                                  ),
                                                  width: 80,
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(right: 30),
                                                child: SizedBox(
                                                  child: Text(
                                                      '${myData[index]['odeme']}'
                                                  ),
                                                  width: 80,
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(right:4 ),
                                                child: SizedBox(
                                                  child: gelirGiderInfo(index, myData),
                                                  width: 80,
                                                ),
                                              ),

                                              SizedBox(
                                                child: Text(
                                                    '${myData[index]['saat']}'
                                                ),
                                                width: 40,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5)   // elemanlar arasına bşluk bırakmak için kulllandım.
                                ],
                              );
                            }
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

        )
        ],
      )
    );
}

}