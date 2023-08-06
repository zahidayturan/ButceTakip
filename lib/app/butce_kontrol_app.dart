import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Pages/more/password_splash.dart';
import '../riverpod_management.dart';
import '../utils/cvs_converter.dart';
import '../utils/notification_service.dart';
import 'base_BKA.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ButceKontrolApp extends ConsumerStatefulWidget {
  const ButceKontrolApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ButceKontrolApp> createState() => _ButceKontrolAppState();
}

class _ButceKontrolAppState extends ConsumerState<ButceKontrolApp> {
  Future<void> loadData()  async {
    // örnek gecikme
    var readSetting =  ref.read(settingsRiverpod); //read okuma işlemleri gerçekleşti
    var readGglAuth = ref.read(gglDriveRiverpod);
    var readCurrency = ref.read(currencyRiverpod);
     readCurrency.controlCurrency();
    var read =  readSetting.controlSettings() ; // Settings tablosunu çekiyoruz. ve implemente ettik
    readGglAuth.checkAuthState(); //Google User açık mı sorgusu yapılıyor
    read.then((value) async {
      if(readSetting.isPassword == 1 && readSetting.Password != "null") { // password controll
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (context, animation, nextanim) => PasswordSplash(),
          reverseTransitionDuration: Duration(milliseconds: 1),
          transitionsBuilder: (context, animation, nexttanim, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        );
      }
      if(readSetting.isBackUp == 1){ //yedekleme açık mı?
        print("Yedeklenme açık");
        if(readGglAuth.accountStatus == true) {
          List<String> datesplit = readSetting.lastBackup!.split(".");
          if(readSetting.Backuptimes == "Günlük"){
            print("günlük giriş var");
            if(int.parse(datesplit[0]) != DateTime.now().day) {
              print("gunluk guncellendi.");
              //readSetting.Backup();
              await writeToCvs().then((value) {
                readGglAuth.uploadFileToStorage();
                readSetting.setLastBackup();
              });
            }else{
              print("mevcut gün => ${DateTime.now().day}");
              print("son kayıt => ${datesplit[0]}");
              print("bugün zaten yuklenmiş");
            }
          }else if(readSetting.Backuptimes == "Aylık"){
            print("Aylık giriş var");
            if(int.parse(datesplit[2]) == DateTime.now().year){
              if(DateTime.now().month - int.parse(datesplit[1]) >= 1 ){
                print("ay bazında kayıt yapıyoruz.");
                //readSetting.Backup();
                await writeToCvs().then((value) {
                  readGglAuth.uploadFileToStorage();
                  readSetting.setLastBackup();
                });
              }
            }else{
              await writeToCvs().then((value) {
                readGglAuth.uploadFileToStorage();
                readSetting.setLastBackup();
              });
              //readSetting.Backup();
            }
          }else if(readSetting.Backuptimes == "Yıllık"){
            print("Yıllık giriş var");
            if(int.parse(datesplit[2]) != DateTime.now().year){
              //readSetting.Backup();
              await writeToCvs().then((value) {
                readGglAuth.uploadFileToStorage();
                readSetting.setLastBackup();
              });
            }
          }
        }else{
          readGglAuth.setBackupAlert(true); //aktif değil
          readSetting.setBackup(false);
          print("yedeklenmesi gerekiyor ama hesabın açık değil GAHPE");
        }
      }else{
        print("Yedekleme kapalı");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    FirebaseNotificationService().connectNotification(context);
   }

  @override
  Widget build(BuildContext context) {
    var readSetting = ref.read(settingsRiverpod);
    ref.watch(passwordRiverpod).isuseinsert;
    /*
    ref.listen(settingsRiverpod, (previous, next) {
      ref.read(passwordRiverpod).setisuseinsert();
    });

     */
    loadData().then((value) => print("DAHA YENİ BİTTTİİ"));
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        );
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr'),
      ],
      locale: const Locale('tr'),
      debugShowCheckedModeBanner: false,
      title: "Bütçe Takip",
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: "Nexa3",
        unselectedWidgetColor: Colors.orange, // checkbox border rengi için kullandım.
      ),
      home: (readSetting.isPassword == null || (readSetting.isPassword == 0 && readSetting.Password == "null" ))  ? const base_BKA() : PasswordSplash(),
      //home: const base_BKA(),
    );
  }
}



