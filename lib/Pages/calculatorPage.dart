import 'package:butcekontrol/classes/navBar.dart';
import 'package:butcekontrol/classes/pageAppbar.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = "0";
  List<String> ButtonList = [
    'AC',
    'delete',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '4',
    '?',
    '0',
    ',',
    '=',

  ];

  @override
  Widget build(BuildContext context) {
    CustomColors renkler = CustomColors();
    return Scaffold(
      appBar: pageAppbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //diğer seceneklere goz atmalısın...
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height/2,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: renkler.koyuuRenk,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                child : Column(
                  children: [
                    TextField(),
                    Divider(color: renkler.YaziRenk,thickness: 2,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton("AC",25,renkler.ArkaRenk),
                            CustomButton("sil",25,renkler.ArkaRenk),
                            CustomButton("%",25,renkler.ArkaRenk),
                            CustomButton("/",25,renkler.ArkaRenk),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton("7",25,renkler.ArkaRenk),
                            CustomButton("8",25,renkler.ArkaRenk),
                            CustomButton("9",25,renkler.ArkaRenk),
                            CustomButton("x",25,renkler.ArkaRenk),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton("4",25,renkler.ArkaRenk),
                            CustomButton("5",25,renkler.ArkaRenk),
                            CustomButton("6",25,renkler.ArkaRenk),
                            CustomButton("-",25,renkler.ArkaRenk),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton("1",25,renkler.ArkaRenk),
                            CustomButton("2",25,renkler.ArkaRenk),
                            CustomButton("3",25,renkler.ArkaRenk),
                            CustomButton("+",25,renkler.ArkaRenk),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton("?",25,renkler.ArkaRenk),
                            CustomButton("0",25,renkler.ArkaRenk),
                            CustomButton(",",25,renkler.ArkaRenk),
                            CustomButton("=",35,renkler.sariRenk),

                          ],
                        ),
                      ],
                    ),
                    Row( //Option seçenekleri bulunduğu satır

                    ),
                  ],
                ),
              )
            ),
          ),
        ],
      ),
      bottomNavigationBar: navBar(),

    );
  }
    Widget CustomButton(String text,var radiussize,Color renk ) {
    CustomColors renkler = CustomColors();
    var radiussize ;
    Color ?renk ;
      return SizedBox(
        height: 50,
        width: 50,
        child: InkWell(
          splashColor: renk,
          onTap: () {

          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radiussize),
            child: Container(
              color: renkler.YaziRenk,

              child: Center(
                child: Text(
                    text,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
}