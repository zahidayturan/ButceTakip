import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../classes/language.dart';
import '../riverpod_management.dart';
import '../utils/cvs_converter.dart';

/*
Navigator.push(
  context,
  PageRouteBuilder(
    opaque: false, //sayfa saydam olması için
    transitionDuration: const Duration(milliseconds: 1),
    pageBuilder: (context, animation, nextanim) => changeCurrencyPage(data![index]),
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

class warningBackUp extends ConsumerStatefulWidget {
  const warningBackUp({Key? key}) : super(key: key);

  @override
  ConsumerState<warningBackUp> createState() => _warningBackUp();
}

class _warningBackUp extends ConsumerState<warningBackUp> {
  bool isClicked = false;
  String ?errormessage ;
  int counter = 2 ;
  Future<void> uploadDrive(WidgetRef ref) async {
    var readSettings = ref.read(settingsRiverpod);
    var readGglAuth = ref.read(gglDriveRiverpod);
    DateTime date = DateTime.now();
    final String fileName = "BT_Data*${date.day}.${date.month}.${date.year}.csv"; //Dosay adı.
    try{
      await writeToCvs(fileName).then((value) async  {
        await Future.delayed(const Duration(seconds: 1));
        await readGglAuth.uploadFileToDrive(fileName).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor:
              const Color(0xff0D1C26),
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
          readSettings.setLastBackup();
          readSettings.setErrorStatusBackup("");
          readSettings.setbackUpAlert(false);
          Navigator.of(context).pop();
        });
      });
    }catch(e){
      print(e);
      if(counter > 0 ){ // 2 kere daha deniyor.
        counter -= 1;
        uploadDrive(ref);
      }else{
        setState(() {
          errormessage = "Geliştiricilere raporlayın Hata mesajı = $e";
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    var readSettings = ref.read(settingsRiverpod);
    var readGglAuth = ref.read(gglDriveRiverpod);
    var size = MediaQuery
        .of(context)
        .size;
    var renkler = CustomColors();
    return WillPopScope(
      onWillPop: ()async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {

                  },
                  child: Container( //boyut
                    height: readSettings.errorStatusBackup == "internet" ? size.height * .23 : size.height * .46,
                    width: size.width * .94,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: renkler.arkaRenk,
                        width: 1
                      )
                    ),
                    child: readSettings.errorStatusBackup == "internet"
                    ?Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.warning_rounded,
                            color: Theme.of(context).disabledColor,
                            size: 35,
                          ),
                          Text(
                            translation(context).noInternetConnection,
                            style: TextStyle(
                              fontFamily: "Nexa3",
                              fontSize: 18,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          InkWell(
                            onTap: () async {
                              readSettings.setbackUpAlert(false);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .02
                              ),
                              width :double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: renkler.arkaRenk,
                                  width: 1,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Theme.of(context).disabledColor, renkler.koyuuRenk],
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    translation(context).okAnladim,
                                    style: const TextStyle(color: Colors.white,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    :isClicked
                    ?SizedBox(
                      height: size.width *.5 ,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: size.height * .04),
                          SizedBox(
                            height: size.width * .25,
                            width: size.width * .25,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).disabledColor,
                              backgroundColor: renkler.koyuuRenk,
                            ),
                          ),
                          SizedBox(height: size.height * .04),
                          Text(
                            "Verileriniz indiriliyor.\n   Lütfen bekleyiniz.",
                            style: TextStyle(
                              fontFamily: "Nexa3",
                              fontSize: 22,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: size.height * .04),
                          errormessage != null
                          ?Expanded(
                            child: Text(
                              "$errormessage",
                              style: TextStyle(
                                  color: renkler.kirmiziRenk,
                                  height: 1.1,
                                  fontSize: 15
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                          :const SizedBox(width: 1)
                        ],
                      ),
                    )
                    :Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              color: Theme.of(context).disabledColor,
                              size: 35,
                            ),
                            SizedBox(width : size.width * .07),
                            Text(
                              translation(context).backupFailed,
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).canvasColor
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                translation(context).backupFailedDescription
                                ,style: TextStyle(color: Theme.of(context).canvasColor,height: 1.1,fontSize: 15),textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * .07,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translation(context).lastBackupDate,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        height: 1.1,
                                        fontSize: 15
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${readSettings.lastBackup}",
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          height: 1.1,
                                          fontSize: 15
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translation(context).backupFrequency,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        height: 1.1,
                                        fontSize: 15
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${readSettings.Backuptimes}",
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          height: 1.1,
                                          fontSize: 15
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translation(context).activeAccount,
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        height: 1.1,
                                        fontSize: 15
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${readGglAuth.getUserEmail()}",
                                      style: TextStyle(
                                        color: Theme.of(context).canvasColor,
                                        height: 1.1,
                                        fontSize: 15
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .11,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    isClicked = true ;
                                  });
                                  await readGglAuth.checkAuthState(ref);
                                  uploadDrive(ref);
                                },
                                child: Container(
                                  height: 40,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * .02
                                  ),
                                  width :double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: renkler.arkaRenk,
                                      width: 1,
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [const Color(0xFF426CB1), renkler.koyuuRenk],
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/icons/google.png",
                                        height: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        translation(context).signInAndBackupWithGoogle,
                                        style: const TextStyle(color: Colors.white,height: 1.1,fontSize: 12),textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await readGglAuth.signOutWithGoogle();
                                  readSettings.setBackup(false);
                                  readSettings.setbackUpAlert(false);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 40,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * .02
                                  ),
                                  width :double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: renkler.arkaRenk,
                                      width: 1,
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [renkler.kirmiziRenk, renkler.koyuuRenk],
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        translation(context).turnOffBackupAndSignOutFromGoogle,
                                        style: const TextStyle(color: Colors.white,height: 1.1,fontSize: 12),textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}