import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../classes/appBarForPage.dart';

class backUp extends ConsumerStatefulWidget {
  const backUp({Key? key}) : super(key: key);

  @override
  ConsumerState<backUp> createState() => _backUpState();
}

class _backUpState extends ConsumerState<backUp> {
  CustomColors renkler = CustomColors();
  String choice = "sanana" ;
  bool isExpandGDrive = false ;
  bool isExpandExcel = false ;
  bool isExpandCvs = false ;
  bool isopen = false ; // databaseden alınacak
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarForPage(title: "YEDEKLE"),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal:18, vertical: 8 ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Container(
                      height: 40,
                      width: size.width,
                      color: Color(0xffD9D9D9),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            const Text(
                              "Yedeklenme Durumu",
                              style: TextStyle(
                                fontFamily: "Nexa3",
                              ),
                            ),
                            Spacer(),
                            isopen ? Text("Açık", style: TextStyle(fontFamily: "Nexa3"),)
                                : Text("Kapalı", style: TextStyle(fontFamily: "Nexa3"),),
                            Switch(
                              value: isopen ,
                              onChanged: (bool value) {
                                setState(() {
                                  isopen = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ), /// Giriş şifresi
                /// Yedeklenme durumunu kontrol etmemiz gerekiyor.
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right:  15.0, bottom: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      color : Color(0xffD9D9D9),
                      child: ExpansionTile(
                          onExpansionChanged: (bool expanding) => setState(() => this.isExpandGDrive = expanding),
                          title: Text("Google Drive ile Yedekle"),
                        children: [
                          Divider(thickness: 2.0,color: renkler.sariRenk),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Google Drive ile ilişkilendir"
                                  ),
                                  InkWell(
                                    onTap: () {

                                    },
                                    child: FittedBox( ///Google Drive Oturumvarlığını sorgulayalım.
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Color(0xff2A2895),
                                        ),
                                        child: const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                                "Oturum Aç",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: "Nexa3"
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right:  15.0, bottom: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      color:  Color(0xffD9D9D9),
                      child: ExpansionTile(
                        title: Text("Excel Dosyası olarak indir(.xlsx)"),
                        onExpansionChanged: (bool expanding) => setState(() => this.isExpandExcel = expanding),
                        children: [
                          Divider(thickness: 2.0,color: renkler.sariRenk),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "Yedeklenme Sıklığı"
                                    )
                                  ],
                                ),
                                Row(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right:  15.0, bottom: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      color:  Color(0xffD9D9D9),
                      child: ExpansionTile(
                        title: Text("CVS formatında indir (.cvs)"),
                        onExpansionChanged: (bool expanding) => setState(() => this.isExpandCvs = expanding),
                        children: [
                          Divider(thickness: 2.0,color: renkler.sariRenk),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  double heightTool_ = 34;
  double heightTool2_ = 42;
  double heightTool3_ = 34;
  Color _containerColorTool3 = const Color(0xff0D1C26);
  Color _containerColorTool2 = const Color(0xff0D1C26);
  Color _containerColorTool = const Color(0xffF2CB05);
  Color _textColorTool = const Color(0xff0D1C26);
  Color _textColorTool2 = Colors.white;
  Color _textColorTool3 = Colors.white;
  int index = 0;
  Widget ToolCustomButton(BuildContext context) {
    void changeColor(int index) {
      if (index == 0) {
        setState(() {
          heightTool2_ = 40;
          heightTool_ = 34;
          heightTool3_ = 34;
          _containerColorTool = const Color(0xffF2CB05);
          _containerColorTool2 = const Color(0xff0D1C26);
          _containerColorTool3 = const Color(0xff0D1C26);
          _textColorTool = const Color(0xff0D1C26);
          _textColorTool2 = Colors.white;
          _textColorTool3 = Colors.white;
        });
      } else if (index == 1) {
        setState(() {
          heightTool_ = 40;
          heightTool2_ = 34;
          heightTool3_ = 34;
          _containerColorTool2 = const Color(0xffF2CB05);
          _containerColorTool = const Color(0xff0D1C26);
          _containerColorTool3 = const Color(0xff0D1C26);
          _textColorTool = Colors.white;
          _textColorTool2 = const Color(0xff0D1C26);
          _textColorTool3 = Colors.white;
        });
      } else {
        setState(() {
          heightTool_ = 34;
          heightTool2_ = 34;
          heightTool3_ = 40;
          _containerColorTool3 = const Color(0xffF2CB05);
          _containerColorTool = const Color(0xff0D1C26);
          _containerColorTool2 = const Color(0xff0D1C26);
          _textColorTool = Colors.white;
          _textColorTool2 = Colors.white;
          _textColorTool3 = const Color(0xff0D1C26);
        });
      }
    }

    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 205,
            ),
          ),
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: _containerColorTool,
                ),
                height: heightTool2_,
                child: SizedBox(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          //_operationTool.text = "Nakit";
                          changeColor(0);
                        });
                      },
                      child: Text("NAKİT",
                          style: TextStyle(
                              color: _textColorTool,
                              fontSize: 17,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w800))),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: _containerColorTool2,
                ),
                height: heightTool_,
                child: SizedBox(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          //_operationTool.text = "Kart";
                          changeColor(1);
                        });
                      },
                      child: Text("KART",
                          style: TextStyle(
                              color: _textColorTool2,
                              fontSize: 17,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w800))),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: _containerColorTool3,
                ),
                height: heightTool3_,
                child: SizedBox(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          //_operationTool.text = "Diger";
                          changeColor(2);
                        });
                      },
                      child: Text("DİĞER",
                          style: TextStyle(
                              color: _textColorTool3,
                              fontSize: 17,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



