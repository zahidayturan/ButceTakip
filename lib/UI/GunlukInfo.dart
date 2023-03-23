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
  List liste = ['a', 'b', 'c', 'f', 's', 'a', 't', 'f', 's', 'a', 't'];
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
              SizedBox(
                height: 190,
                child: Padding(      //borderin scroll ile birleşimi gözüksü diye soldan padding
                  padding: const EdgeInsets.only(left: 3.0, top: 20),
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
                            itemCount : liste.length,
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
                                              Text("harf: ${liste[index]}"),
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