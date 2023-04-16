import 'dart:io';

import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/utils/CvsConverter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../classes/appBarForPage.dart';
import '../../classes/navBar.dart';
import '../../riverpod_management.dart';

class backUp extends ConsumerStatefulWidget {
  const backUp({Key? key}) : super(key: key);

  @override
  ConsumerState<backUp> createState() => _backUpState();
}

class _backUpState extends ConsumerState<backUp> {
  @override
  Widget build(BuildContext context) {
    var readSetting = ref.read(settingsRiverpod);
    CustomColors renkler = CustomColors();
    String choice = "sanana" ;
    bool isExpandGDrive = false ;
    bool isExpandExcel = false ;
    bool isExpandCvs = false ;
    bool isopen = readSetting.isBackUp == 1 ? true : false ; // databaseden alınacak
    var size = MediaQuery.of(context).size;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: navBar(),
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
                      color: renkler.ArkaRenk,
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
                                  readSetting.setBackup(value);
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
                !isopen
                ?SizedBox()
                :Column(
                  children: [
                    /*
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right:  15.0, bottom: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          color : Color(0xffD9D9D9),
                          child: ExpansionTile(
                              onExpansionChanged: (bool expanding) => setState(() => isExpandGDrive = expanding),
                              title: Text("Google Drive ile Yedekle"),
                            children: [
                              Divider(thickness: 2.0,color: renkler.sariRenk),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Google Drive ile ilişkilendir"
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final directory = await getExternalStorageDirectory() ;
                                          print(directory?.path);
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
                            onExpansionChanged: (bool expanding) => setState(() => isExpandExcel = expanding),
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

                     */
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right:  15.0, bottom: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          color:  renkler.ArkaRenk,
                          child: ExpansionTile(
                            title: Text("CVS formatında indir (.cvs)"),
                            onExpansionChanged: (bool expanding) => setState(() => isExpandCvs = expanding),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  children: [
                                    Divider(thickness: 2.0,color: renkler.sariRenk),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Yedeklenme Sıklığı",
                                              style:TextStyle(
                                                fontFamily: "Nexa4",
                                                fontSize: 15  ,
                                              ),
                                            ),
                                            ToolCustomButton(context),
                                          ],
                                        ),
                                        SizedBox(height: 10 ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                restore();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      backgroundColor:
                                                      Color(0xff0D1C26),
                                                      duration: Duration(seconds: 1),
                                                      content: Text(
                                                        'Verileriniz Çekildi',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontFamily: 'Nexa3',
                                                          fontWeight: FontWeight.w600,
                                                          height: 1.3,
                                                        ),
                                                      ),
                                                    ),
                                                );
                                              },
                                              child: FittedBox(
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: renkler.koyuuRenk,
                                                  ),
                                                  child: const Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.all(8),
                                                      child: Text(
                                                        "Geri Yükle",
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
                                            InkWell(
                                              onTap: () {
                                                writeToCvs();
                                                setState(() {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        backgroundColor:
                                                        Color(0xff0D1C26),
                                                        duration: Duration(seconds: 1),
                                                        content: Text(
                                                          '/Download/BKA_data.cvs indirildi !',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontFamily: 'Nexa3',
                                                            fontWeight: FontWeight.w600,
                                                            height: 1.3,
                                                          ),
                                                        ),
                                                      )
                                                  );
                                                });
                                              },
                                              child: FittedBox(
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: renkler.koyuuRenk,
                                                  ),
                                                  child: const Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.all(8),
                                                      child: Text(
                                                        "Yedekle",
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
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
  Widget ToolCustomButton(BuildContext context) {
    var readSetting = ref.read(settingsRiverpod);
    int ?index ;
    if(readSetting.Backuptimes == "Günlük"){
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
    }else if(readSetting.Backuptimes == "Haftalık"){
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
    }else{
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
                          readSetting.setBackuptimes("Günlük");
                        });
                      },
                      child: Text("Günlük",
                          style: TextStyle(
                              color: _textColorTool,
                              fontSize: 15,
                              fontFamily: 'Nexa3',
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
                          readSetting.setBackuptimes("Haftalık");
                        });
                      },
                      child: Text("Haftalık",
                          style: TextStyle(
                              color: _textColorTool2,
                              fontSize: 15,
                              fontFamily: 'Nexa3',
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
                          readSetting.setBackuptimes("Yıllık");
                        });
                      },
                      child: Text("Yıllık",
                          style: TextStyle(
                              color: _textColorTool3,
                              fontSize: 17,
                              fontFamily: 'Nexa3',
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



