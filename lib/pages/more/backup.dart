import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/constans/text_pref.dart';
import 'package:butcekontrol/utils/cvs_converter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../classes/app_bar_for_page.dart';
import '../../classes/nav_bar.dart';
import '../../riverpod_management.dart';

class BackUp extends ConsumerStatefulWidget {
  const BackUp({Key? key}) : super(key: key);

  @override
  ConsumerState<BackUp> createState() => _BackUpState();
}

class _BackUpState extends ConsumerState<BackUp> {
  Future <ListResult> ?futureFiles ;
  @override
  void initState(){
    super.initState();
    futureFiles = FirebaseStorage.instance.ref("/files").listAll();
  }
  @override
  Widget build(BuildContext context) {
    var readSetting = ref.read(settingsRiverpod);
    var readGglAuth = ref.read(gglDriveRiverpod);
    ref.watch(gglDriveRiverpod).RfPageSt;
    readGglAuth.checkAuthState();
    //bool isExpandGDrive = false ;
    //bool isExpandExcel = false ;
    bool isopen = readSetting.isBackUp == 1 ? true : false ; // databaseden alınacak
    CustomColors renkler = CustomColors();
    var size = MediaQuery.of(context).size;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffF2F2F2),
          bottomNavigationBar: const NavBar(),
          appBar: const AppBarForPage(title: "YEDEKLE"),
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
                      color: renkler.arkaRenk,
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
                          const Spacer(),
                          isopen ? const Text("Açık", style: TextStyle(fontFamily: "Nexa3"),)
                              : const Text("Kapalı", style: TextStyle(fontFamily: "Nexa3"),),
                          Switch(
                            activeColor: renkler.sariRenk,
                            value: isopen ,
                            onChanged: (bool value) {
                              setState(() {
                                readSetting.setBackup(value);
                                readSetting.setisuseinsert();
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
              if (!isopen) const SizedBox() else ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: renkler.arkaRenk,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Google Cloud ile Yedekle",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Nexa4"
                          ),
                        ),
                        Divider(thickness: 2.0,color: renkler.sariRenk),
                        readGglAuth.accountStatus == true || readGglAuth.isSignedIn
                          ?Column(
                            children: [
                              SizedBox(height: size.height * 0.015),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextMod("Email:", Colors.black,  15),
                                  TextMod("${readGglAuth.getUserEmail()}", Colors.black, 15),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextMod("Ad ve Soyad:", Colors.black, 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 2),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: SizedBox(
                                            height : 20,
                                            width: 20,
                                            child: Container(
                                                child: Image.network("${readGglAuth.getUserPhotoUrl()}")
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.01),
                                      TextMod("${readGglAuth.getUserDisplayName()}", Colors.black, 15),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextMod("Son Yedekleme Tarihi:", Colors.black, 15),
                                  TextMod(readSetting.lastBackup.toString() != '00.00.0000' ? "${readSetting.lastBackup}" : "Yedeklenmedi", Colors.black, 15),
                                ],
                              ),
                              SizedBox(height: size.height * 0.015),
                              Divider(thickness: 2.0,color: renkler.sariRenk),
                              SizedBox(height: size.height * 0.01),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Yedeklenme Sıklığı",
                                    style:TextStyle(
                                      fontFamily: "Nexa3",
                                      fontSize: 15  ,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      toolCustomButton(context),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      readGglAuth.downloadFileToDevice();
                                      //GoogleDrive().uploadFileToGoogleDrive();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          backgroundColor:
                                          Color(0xff0D1C26),
                                          duration: Duration(seconds: 1),
                                          content: Text(
                                            'Cloud üzerinden Verileriniz Çekildi',
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
                                    child: Container(
                                      height: 32,
                                      width: size.width * 0.23,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
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
                                  SizedBox(width:size.width * 0.04,),
                                  InkWell(
                                    onTap: () async {
                                      await writeToCvs().then((value) {
                                        readGglAuth.uploadFileToStorage();
                                        readSetting.setLastBackup();
                                      });
                                      //readGglAuth.uploadFile();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          backgroundColor:
                                          Color(0xff0D1C26),
                                          duration: Duration(seconds: 1),
                                          content: Text(
                                            'Cloud sistemine yüklendi',
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
                                    child: Container(
                                      height: 32,
                                      width: size.width * 0.23,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
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
                                  ),

                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                              InkWell(
                                onTap: () async {
                                  await readGglAuth.signOutWithGoogle();
                                  readGglAuth.setAccountStatus(false);
                                },
                                child: SizedBox(
                                  width: size.width * 0.5,
                                  height: 32,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffB72E2E),
                                    ),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          "Çıkış Yap",
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
                          :Column(
                            children: [
                              SizedBox(height: size.height * 0.005),
                              InkWell(
                                onTap: () async {
                                  await readGglAuth.signInWithGoogle();
                                  readGglAuth.setAccountStatus(true);
                                },
                                child: SizedBox(
                                  width: size.width * 0.5,
                                  height: 32,
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
                              SizedBox(height: 5),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
  double heightTool_ = 32;
  double heightTool2_ = 38;
  double heightTool3_ = 32;
  Color _containerColorTool3 = const Color(0xff0D1C26);
  Color _containerColorTool2 = const Color(0xff0D1C26);
  Color _containerColorTool = const Color(0xffF2CB05);
  Color _textColorTool = const Color(0xff0D1C26);
  Color _textColorTool2 = Colors.white;
  Color _textColorTool3 = Colors.white;
  Widget toolCustomButton(BuildContext context) {
    var readSetting = ref.read(settingsRiverpod);
    if(readSetting.Backuptimes == "Günlük"){
      setState(() {
        heightTool2_ = 32;
        heightTool_ = 26;
        heightTool3_ = 26;
        _containerColorTool = const Color(0xffF2CB05);
        _containerColorTool2 = const Color(0xff0D1C26);
        _containerColorTool3 = const Color(0xff0D1C26);
        _textColorTool = const Color(0xff0D1C26);
        _textColorTool2 = Colors.white;
        _textColorTool3 = Colors.white;
      });
    }else if(readSetting.Backuptimes == "Aylık"){
      setState(() {
        heightTool_ = 32;
        heightTool2_ = 26;
        heightTool3_ = 26;
        _containerColorTool2 = const Color(0xffF2CB05);
        _containerColorTool = const Color(0xff0D1C26);
        _containerColorTool3 = const Color(0xff0D1C26);
        _textColorTool = Colors.white;
        _textColorTool2 = const Color(0xff0D1C26);
        _textColorTool3 = Colors.white;
      });
    }else{
      setState(() {
        heightTool_ = 26;
        heightTool2_ = 26;
        heightTool3_ = 32;
        _containerColorTool3 = const Color(0xffF2CB05);
        _containerColorTool = const Color(0xff0D1C26);
        _containerColorTool2 = const Color(0xff0D1C26);
        _textColorTool = Colors.white;
        _textColorTool2 = Colors.white;
        _textColorTool3 = const Color(0xff0D1C26);
      });
    }
    return SizedBox(
      height: 32,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2,bottom: 2),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xff0D1C26),
              ),
              height: 28,
              width: 156,
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
                  width: 60,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          readSetting.setBackuptimes("Günlük");
                        });
                      },
                      child: Text("Günlük",
                          style: TextStyle(
                              color: _textColorTool,
                              fontSize: 13,
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
                  width: 48,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          readSetting.setBackuptimes("Aylık");
                        });
                      },
                      child: Text("Aylık",
                          style: TextStyle(
                              color: _textColorTool2,
                              fontSize: 13,
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
                  width: 48,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          readSetting.setBackuptimes("Yıllık");
                        });
                      },
                      child: Text("Yıllık",
                          style: TextStyle(
                              color: _textColorTool3,
                              fontSize: 13,
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



