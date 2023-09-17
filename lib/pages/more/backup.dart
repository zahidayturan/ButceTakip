import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/constans/text_pref.dart';
import 'package:butcekontrol/pages/more/Help/help_backup.dart';
import 'package:butcekontrol/utils/banner_ads.dart';
import 'package:butcekontrol/utils/cvs_converter.dart';
import 'package:butcekontrol/utils/interstitial_ads.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../classes/app_bar_for_page.dart';
import '../../classes/nav_bar.dart';
import '../../riverpod_management.dart';

class BackUp extends ConsumerStatefulWidget {
  const BackUp({Key? key}) : super(key: key);

  @override
  ConsumerState<BackUp> createState() => _BackUpState();
}

class _BackUpState extends ConsumerState<BackUp> {
  final InterstitialAdManager _interstitialAdManager = InterstitialAdManager();

  Future <ListResult> ?futureFiles ;
  int  backupPushCount = 5 ;

  @override
  void initState() {
    var readSettings = ref.read(settingsRiverpod);
    var adCounter = readSettings.adCounter;
    if (adCounter! < 1) {
      _interstitialAdManager.loadInterstitialAd();
    } else {
    }
    super.initState();
  }
  void _showInterstitialAd(BuildContext context) {
    _interstitialAdManager.showInterstitialAd(context);
  }
  @override
  Widget build(BuildContext context) {
    var readSetting = ref.read(settingsRiverpod);
    var readGglAuth = ref.read(gglDriveRiverpod);
    ref.watch(gglDriveRiverpod).RfPageSt;
    bool isopen = readSetting.isBackUp == 1 ? true : false ; // databaseden alınacak
    CustomColors renkler = CustomColors();
    var readSettings = ref.read(settingsRiverpod);
    var adCounter = readSettings.adCounter;
    var size = MediaQuery.of(context).size;
    return Container(
      color: renkler.koyuuRenk,
      child: SafeArea(
        child: Scaffold(
          //backgroundColor: const Color(0xffF2F2F2),
          bottomNavigationBar: const NavBar(),
          appBar: AppBarForPage(title: translation(context).backupTitle),
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
                      color: Theme.of(context).indicatorColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Text(
                              translation(context).backupStatus,
                              style: TextStyle(
                                fontFamily: "Nexa3",
                                color: Theme.of(context).canvasColor,
                              ),
                            ),
                          const Spacer(),
                          isopen ? Text(translation(context).on, style: TextStyle(fontFamily: "Nexa3",color:  Theme.of(context).canvasColor,),)
                              : Text(translation(context).off, style: TextStyle(fontFamily: "Nexa3",color: Theme.of(context).canvasColor,),),
                          Switch(
                            activeColor: Theme.of(context).disabledColor,
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
                  color: Theme.of(context).indicatorColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translation(context).backupViaGoogleAccount,
                              style: TextStyle(
                                height: 1,
                                fontSize: 16,
                                fontFamily: "Nexa4",
                                color: Theme.of(context).canvasColor,
                              ),
                            ),
                            /*
                            Image.asset(
                              "assets/image/googleDrive.png",
                              width: 85,
                              height: 25,
                            )
                            */
                          ],
                        ),
                        Divider(thickness: 2.0,color: Theme.of(context).disabledColor),
                        readGglAuth.accountStatus == true || readGglAuth.isSignedIn
                          ?Column(
                            children: [
                              SizedBox(height: size.height * 0.015),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextMod(translation(context).email,  Theme.of(context).canvasColor,  15),
                                  TextMod("${readGglAuth.getUserEmail()}", Theme.of(context).canvasColor, 15),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextMod(translation(context).nameAndSurname, Theme.of(context).canvasColor, 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: SizedBox(
                                            height : 20,
                                            width: 20,
                                            child: Image.network("${readGglAuth.getUserPhotoUrl()}"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.01),
                                      TextMod("${readGglAuth.getUserDisplayName()}", Theme.of(context).canvasColor, 15),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextMod(translation(context).lastBackupDate, Theme.of(context).canvasColor, 15),
                                  TextMod(readSetting.lastBackup.toString() != '00.00.0000' ? "${readSetting.lastBackup}" : translation(context).notBackedUp, Theme.of(context).canvasColor, 15),
                                ],
                              ),
                              SizedBox(height: size.height * 0.015),
                              Divider(thickness: 2.0,color: Theme.of(context).disabledColor),
                              SizedBox(height: size.height * 0.01),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      translation(context).backupFrequency,
                                      style:TextStyle(
                                        fontFamily: "Nexa3",
                                        fontSize: 15  ,
                                        color: Theme.of(context).canvasColor,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      backupCustomButton(context),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async { // geri yükle.
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (context) {
                                          return Center(
                                              child: CircularProgressIndicator(
                                                color: Theme.of(context).disabledColor,
                                                backgroundColor: renkler.koyuuRenk,
                                              ));
                                        },
                                      );
                                      await readGglAuth.downloadFileToDevice();
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          backgroundColor:
                                          const Color(0xff0D1C26),
                                          duration: const Duration(seconds: 1),
                                          content: Text(
                                            "Verileriniz İndirildi",
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
                                      /*
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          opaque: false, //sayfa saydam olması için
                                          transitionDuration: const Duration(milliseconds: 1),
                                          pageBuilder: (context, animation, nextanim) => const listBackUpPopUp(),
                                          reverseTransitionDuration: const Duration(milliseconds: 1),
                                          transitionsBuilder: (context, animation, nexttanim, child) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                     */
                                    },
                                    child: SizedBox(
                                      height: 32,
                                      width: size.width * 0.32,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: renkler.koyuuRenk,
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 1
                                            )
                                          ]
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              translation(context).restoreData, // geri yükle
                                              style: TextStyle(
                                                height: 1,
                                                  color: renkler.arkaRenk,
                                                  fontSize: 15,
                                                  fontFamily: "Nexa3"
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width:size.width * 0.04),
                                  InkWell( ///upload File restore
                                    onTap: () async { // Yedekle.
                                      if (adCounter == 0) {
                                        _showInterstitialAd(context);
                                        readSettings.resetAdCounter();
                                      } else {
                                        readSettings.useAdCounter();
                                      }
                                      final String fileName = "Bka_CSV.cvs" ;
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (context) {
                                          return Center(
                                              child: CircularProgressIndicator(
                                                color: Theme.of(context).disabledColor,
                                                backgroundColor: renkler.koyuuRenk,
                                              ));
                                        },
                                      );
                                      try{
                                        await writeToCvs(fileName);
                                        await readGglAuth.uploadFileToStorage();
                                        readSetting.setLastBackup();
                                        readSetting.setbackUpAlert(false);
                                        readGglAuth.refreshPage();
                                        Navigator.of(context).pop();

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            backgroundColor: const Color(0xff0D1C26),
                                            duration: const Duration(seconds: 1),
                                            content: Text(
                                              "Verileriniz Yedeklendi",
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

                                        /*
                                        await Future.delayed(const Duration(milliseconds: 400));
                                        await readGglAuth.uploadFileToDrive(fileName).then((value) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: const Color(0xff0D1C26),
                                              duration: const Duration(seconds: 1),
                                              content: Text(
                                                translation(context).uploadedToGoogleDrive,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'Nexa3',
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.3,
                                                ),
                                              ),
                                            ),
                                          );
                                          readSetting.setLastBackup();
                                          readSetting.setbackUpAlert(false);
                                          readGglAuth.refreshPage();
                                        });
                                       */
                                      }catch(e){
                                        print("HATAAAAAAAAAAA ===============>>>>>>>>>>${e.toString()}");
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor:
                                            const Color(0xff0D1C26),
                                            duration: const Duration(seconds: 1),
                                            content: Text(
                                              translation(context).backupError,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'Nexa3',
                                                fontWeight: FontWeight.w600,
                                                height: 1.3,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      /*
                                      if(backupPushCount == 0)  {
                                        readGglAuth.controlListCount();
                                      }else{
                                        backupPushCount -= 1 ;
                                      }
                                       */
                                    },
                                    child: SizedBox(
                                      height: 32,
                                      width: size.width * 0.32,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: renkler.koyuuRenk,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 1
                                            )
                                          ]
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              translation(context).backup,
                                              style: TextStyle(
                                                  color: renkler.arkaRenk,
                                                height: 1,
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
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, PageRouteBuilder(
                                          transitionDuration: const Duration(milliseconds: 1),
                                          pageBuilder: (context, animation, nextanim) => const HelpBackup(),
                                          reverseTransitionDuration: const Duration(milliseconds: 1),
                                          transitionsBuilder: (context, animation, nexttanim, child) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width : 25,
                                      height : 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        border: Border.all(
                                          color: Theme.of(context).canvasColor,
                                          width: 1
                                        ),
                                      ),
                                      child: Icon(
                                          Icons.question_mark,
                                        size: 18,
                                        color: Theme.of(context).canvasColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width * .08),
                                  InkWell(
                                    onTap: () async {
                                      await readGglAuth.signOutWithGoogle();
                                      readGglAuth.setAccountStatus(false);
                                    },
                                    child: SizedBox(
                                      width: size.width * 0.56,
                                      height: 30,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 1
                                            )
                                          ],
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [renkler.kirmiziRenk, renkler.koyuuRenk],
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              translation(context).logOut,
                                              style: TextStyle(
                                                height: 1,
                                                  color: renkler.arkaRenk,
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
                            ],
                          )
                          :Column(
                            children: [
                              SizedBox(height: size.height * 0.02),
                              InkWell(
                                onTap: () async {
                                    await readGglAuth.signInWithGoogle();
                                    //await readGglAuth.checkAuthState(ref);
                                    readGglAuth.setAccountStatus(true);
                                    readGglAuth.refreshPage();

                                },
                                child: SizedBox(
                                  width: size.width * 0.56,
                                  height: 30,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 1
                                        )
                                      ],
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [const Color(0xff2A2895), renkler.koyuuRenk],
                                      ),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icons/google.png"
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              translation(context).signIn,
                                              style: TextStyle(
                                                  color: renkler.arkaRenk,
                                                height: 1,
                                                  fontSize: 15,
                                                  fontFamily: "Nexa3"
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
                Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: BannerAds(
                    adSize: AdSize.banner,
                  ),
                ),
              ],

          ),
        ),
      ),
      )
    );
  }

  Widget backupCustomButton(BuildContext context) {
    var readSetting = ref.read(settingsRiverpod);
    int  initialLabelIndex = readSetting.Backuptimes == "Günlük" ? 0 : readSetting.Backuptimes == "Aylık" ? 1 : 2;
    return SizedBox(
      height: 30,
      child: ToggleSwitch(
        initialLabelIndex: initialLabelIndex,
        totalSwitches: 3,
        labels: [translation(context).dailyBackup, translation(context).monthlyBackup, translation(context).yearlyBackup],
        activeBgColor: [Theme.of(context).disabledColor],
        activeFgColor: const Color(0xff0D1C26),
        inactiveBgColor: const Color(0xff0D1C26),
        inactiveFgColor: const Color(0xFFE9E9E9),
        minWidth: 68,
        cornerRadius: 20,
        radiusStyle: true,
        animate: true,
        curve: Curves.linearToEaseOut,
        customTextStyles: const [
          TextStyle(
              fontSize: 12, fontFamily: 'Nexa3', fontWeight: FontWeight.w800)
        ],
        onToggle: (index) {
          if (index == 0) {
            setState(() {
              readSetting.setBackuptimes("Günlük");
              initialLabelIndex = 0;
            });
          } else if (index == 1) {
            setState(() {
              readSetting.setBackuptimes("Aylık");
            });
          }
          else if (index == 2){
            setState(() {
              readSetting.setBackuptimes("Yıllık");
            });
          }
          else{

          }
          initialLabelIndex = index!;
        },
      )
    );
  }
}



