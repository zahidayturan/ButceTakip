import 'package:butcekontrol/UI/app_status.dart';
import 'package:butcekontrol/UI/introduction_page.dart';
import 'package:butcekontrol/app/information_app.dart';
import 'package:butcekontrol/classes/nav_bar.dart';
import 'package:butcekontrol/utils/notification_service.dart';
import 'package:butcekontrol/utils/security_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Pages/more/password_splash.dart';
import '../riverpod_management.dart';
import '../utils/cvs_converter.dart';

class base_BKA extends ConsumerStatefulWidget {
  final bool showBTA;
  final Map<String, String>? appInfo;
  const base_BKA({Key ? key,required this.showBTA, required this.appInfo}) :super(key :key);

  @override
  ConsumerState<base_BKA> createState() => _base_BKAState();
}

class _base_BKAState extends ConsumerState<base_BKA> {
  Future<void> backup(String fileName, ref) async {
    var readGglAuth = ref.read(gglDriveRiverpod);
    var readSetting =  ref.read(settingsRiverpod);
    if(readSetting.errorStatusBackup == "internet"){
      readSetting.setbackUpAlert(true);
      readGglAuth.setAccountStatus(false);
    }else{
      await writeToCvs(fileName);
      // await Future.delayed(const Duration(milliseconds: 500));
      try{
        await readGglAuth.uploadFileToStorage();
        readSetting.setLastBackup();
        /*
        await readGglAuth.uploadFileToDrive(fileName).then((value) {
          readSetting.setLastBackup();
        });

         */
      }catch(e){
        print("Yedeklenme sırasında hata saptandı = $e");
        try{
          backup(fileName, ref);
        }catch(b){
          if(e == b){
            readSetting.setbackUpAlert(true);
            return ;
          }else{
            print("farklı hata");
          }
        }
      }
      //readGglAuth.controlListCount(); //30 kayıt kontrolu sağlanıyor.
    }
  }

  Future<void> loadData()  async {
    // örnek gecikme
    DateTime date = DateTime.now();
    final String fileName = "Bka_CSV.cvs" ;
    //final String fileName = "BT_Data*${date.day}.${date.month}.${date.year}.csv"; //Dosay adı.
    var readSetting =  ref.read(settingsRiverpod); //read okuma işlemleri gerçekleşti
    var readCurrency = ref.read(currencyRiverpod);
    var readGglAuth = ref.read(gglDriveRiverpod);
    var checkAuth = readGglAuth.checkAuthState(ref); //Google User açık mı sorgusu yapılıyor
    var Query = readSetting.controlSettings(context);
    //Future.delayed(Duration(milliseconds: 100));// Settings tablosunu çekiyoruz. ve implemente ettik
    Query.then((value) async {
      if(readSetting.isPassword == 1 && readSetting.Password != "null") { // password controll
        print("Password var göster");
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
      }else if (readSetting.isPassword == null){
        print("Password için emulator yavas kaldı.");
      }

      await readSetting.setMonthStarDayForHomePage(readSetting.monthStartDay!);
      await ref.read(databaseRiverpod).setMonthandYear(readSetting.monthIndex.toString(), readSetting.yearIndex.toString());
      ref.read(homeRiverpod).setStatus();
      await ref.read(calendarRiverpod).setMonthStartDay(readSetting.monthStartDay!);

      await readCurrency.controlCurrency(ref).then((value) { //currency control
        var readHome = ref.read(homeRiverpod);
        var readUpdateData =  ref.read(updateDataRiverpod);
        readUpdateData.customizeRepeatedOperation(ref).then((value) => readHome.setStatus());
        readUpdateData.customizeInstallmentOperation(ref).then((value) => readHome.setStatus());
      }); // Güncel kur database sorgusunu gerçekleştirir

      if(readSetting.isBackUp == 1){ //yedekleme açık mı?
        int counter = 2 ;
        print("Yedeklenme açık");
        checkAuth.then((value) async {
          if(readGglAuth.accountStatus == true) {
            List<String> datesplit = readSetting.lastBackup!.split(".");
            if(readSetting.Backuptimes == "Günlük"){
              print("günlük giriş var");
              if(int.parse(datesplit[0]) != DateTime.now().day) {
                print("gunluk guncelleniyor.");
                await backup(fileName, ref);
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
                  await backup(fileName, ref);
                }
              }else{
                await backup(fileName, ref);
              }
            }else if(readSetting.Backuptimes == "Yıllık"){
              print("Yıllık giriş var");
              if(int.parse(datesplit[2]) != DateTime.now().year){
                //readSetting.Backup();
                await backup(fileName, ref);
              }
            }
          }else{
            readSetting.setBackup(false);
            print("yedeklenmesi gerekiyor ama hesabın açık değil GAHPE");
          }
        });
      }else if(readSetting.isBackUp == 0) {
        print("Yedekleme kapalı");
      }else{
        print("Sorgular için Emulator yavas kalıyor.");
      }
    }
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
    FirebaseNotificationService().connectNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(botomNavBarRiverpod);
    bool bottomNavigationBar = true;
    String currentVersion = informationApp.version;
    String newVersion = widget.appInfo!["version"]!;
    int compareVersions(String version1, String version2) {
      List<int> v1 = version1.split('.').map(int.parse).toList();
      List<int> v2 = version2.split('.').map(int.parse).toList();
      for (int i = 0; i < 3; i++) {
        if (v1[i] < v2[i]) {
          return -1; // version1, version2'den küçük
        } else if (v1[i] > v2[i]) {
          return 1;  // version1, version2'den büyük
        }
      }
      return 0; // version1 ve version2 aynı
    }
    Widget getWidgetToStart(){
      if(widget.appInfo!["appInfoString"] != securityFile().careCode && widget.appInfo!["appInfoString"] != securityFile().updateCode){
        if(widget.showBTA){
          bottomNavigationBar = true;
          return watch.body();
      }else{
          bottomNavigationBar = false;
          return IntroductionPage();
        }
      }else if(widget.appInfo!["appInfoString"] == securityFile().careCode){
        bottomNavigationBar = false;
        return AppStatus(status:"care");
      }
      else if(widget.appInfo!["appInfoString"] == securityFile().updateCode){
        if(compareVersions(currentVersion,newVersion) == -1){
          bottomNavigationBar = false;
          return AppStatus(status:"update");
        }else{
          bottomNavigationBar = true;
          return watch.body();
        }
      }else{
        bottomNavigationBar = true;
        return watch.body();
      }
    }
    return Scaffold(
      body : getWidgetToStart(),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: bottomNavigationBar == true ? NavBar() : null,
    );
  }
}