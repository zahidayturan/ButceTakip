import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/constans/TextPref.dart';
import 'package:flutter/material.dart';

class testPages extends StatefulWidget {
  const testPages({Key? key}) : super(key: key);

  @override
  State<testPages> createState() => _testPagesState();
}

class _testPagesState extends State<testPages> {

  CustomColors renkler = CustomColors();
  var heightt = 45.0;
  var widthh = 75.0;
  var top  = 1.0;
  var bottom ;
  var right  ;
  var left  = 1.0 ;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size ;
    return Scaffold(
      appBar: AppBar(title: Text("iboşko Test")),
      body: SizedBox(
        height: 144,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Stack(
              fit: StackFit.passthrough,
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 900),
                  curve: Curves.fastOutSlowIn,
                  height: heightt,
                  width: widthh,
                  top: top,
                  bottom: bottom,
                  right: right,
                  left: left,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: heightt,
                          width: widthh,
                          color: renkler.sariRenk,
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed:() {
                                setState(() {
                                  left = 0.0;
                                  top = 1.0;
                                  widthh = size.width/5.5 ;
                                });
                              },
                              child: Text("Yemek")),
                          TextButton(
                              onPressed:() {
                                setState(() {
                                  top = 1.0 ;
                                  left = size.width/4.2 ;
                                  widthh = size.width/5.1 ;
                                });
                              },
                              child: Text("Giyim")),
                          TextButton(
                              onPressed:() {
                                setState(() {
                                  top = 1.0 ;
                                  left= size.width/2.1 ;
                                  widthh = size.width/4.5 ;
                                });
                              },
                              child: Text("Eğlence")),
                          TextButton(
                              onPressed:() {
                                setState(() {
                                  top = 1.0 ;
                                  left= size.width/1.35 ;
                                  widthh = size.width/5.5;
                                });
                              },
                              child: Text("Eğitim")),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: TextButton(
                                onPressed:() {
                                  setState(() {
                                    top = 50.0 ;
                                    left= 0.0 ;
                                    widthh =size.width/3.2 ;
                                  });
                                },
                                child: Textmod("Aidat/kira", renkler.koyuuRenk, 18)
                            ),
                          ),
                          TextButton(
                              onPressed:() {
                                setState(() {
                                  top = 50.0 ;
                                  left= size.width/3.2 ;
                                  widthh = size.width/4.5;
                                });
                              },
                              child: Text("Alışveriş")),
                          TextButton(
                              onPressed:() {
                                setState(() {
                                  top = 50.0 ;
                                  left= size.width/1.82;
                                  widthh = size.width/6;
                                });
                              },
                              child: Text("Özel")),
                          TextButton(
                              onPressed:() {
                                setState(() {
                                  top = 50.0 ;
                                  left= size.width/1.35;
                                  widthh = size.width/5.5;
                                });
                              },
                              child: Text("Ulaşım")),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: TextButton(
                                onPressed:() {
                                  setState(() {
                                    top = 98.0 ;
                                    left= 0.0 ;
                                    widthh = size.width/5.4 ;
                                  });
                                },
                                child: Text("Sağlık")),
                          ),
                          TextButton(
                              onPressed:() {
                                setState(() {
                                  top = 98.0 ;
                                  left= size.width/4.9 ;
                                  widthh = size.width/3.2;
                                });
                              },
                              child: Text("Günlük Yaşam")),
                          TextButton(
                              onPressed:() {
                                setState(() {
                                  top = 98.0 ;
                                  left= size.width/1.9 ;
                                  widthh = size.width/4.9;
                                });
                              },
                              child: Text("Hobi")),
                          TextButton(
                              onPressed:() {
                                setState(() {
                                  top = 98.0 ;
                                  left= size.width/1.35 ;
                                  widthh = size.width/5.5;
                                });
                              },
                              child: Text("Diğer")),
                        ],
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
