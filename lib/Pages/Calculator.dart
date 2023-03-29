import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod_management.dart';

class Calculator extends ConsumerWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size ;
    var readNavBar = ref.read(botomNavBarRiverpod);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hesap Makinresi"),
        backgroundColor: renkler.koyuuRenk,
        leading: IconButton(
          icon : Icon(Icons.home_filled),
          onPressed: () => readNavBar.setCurrentindex(0),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              bottom: 7.0,
              right: 20.0,
              left: 20.0,
            ),
            child: SizedBox(
              height: size.height*00.584 ,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomLeft:  Radius.circular(40),
                ),
                child: Container(
                  color: renkler.koyuuRenk,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                "LEBLEBİ",
                                style: TextStyle(
                                  color: renkler.sariRenk,
                                  fontSize: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.white, thickness: 2),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Buttoncreate("AC",size),
                                  Buttoncreate("<=",size),
                                  Buttoncreate("½",size),
                                  Buttoncreate("/",size)
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Buttoncreate("7",size),
                                  Buttoncreate("8",size),
                                  Buttoncreate("9",size),
                                  Buttoncreate("x",size)
                                ],
                              ),

                            ],
                          ),
                        ), //Tus takımı bulunacaktır.
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(),///orta cizgi gelicek
          Row(),/// Sayfa butonları gelecek.
        ],
      ),
    );
  }
    Widget equalsBtnCreat(Size size){
      return SizedBox(
        height: size.width * 00.135 ,
        width: size.width * 00.135 ,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "=",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      );
    }
    Widget Buttoncreate(String symbol, Size size) {
      return SizedBox(
        height: size.width* 00.135 ,
        width: size.width* 00.135 ,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                symbol,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      );
    }
}
