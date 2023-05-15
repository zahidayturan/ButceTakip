import 'package:butcekontrol/classes/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/more/password_splash.dart';
import '../riverpod_management.dart';

class base_BKA extends ConsumerStatefulWidget {
  const base_BKA({Key ? key}) :super(key :key);

  @override
  ConsumerState<base_BKA> createState() => _base_BKAState();
}

class _base_BKAState extends ConsumerState<base_BKA> {
  void loadData()  async {
    // örnek gecikme
    var readSetting =  ref.read(settingsRiverpod);
    var read  = readSetting.controlSettings() ; // Settings tablosunu çekiyoruz. ve implemente ettik
    await Future.delayed(Duration(milliseconds: 500));
    read.then((value){
      if(readSetting.isBackUp == 1){
        List<String> datesplit = readSetting.lastBackup!.split(".");
        if(readSetting.Backuptimes == "Günlük"){
          print("günlük giriş var");
          if(int.parse(datesplit[0]) != DateTime.now().day){
            print("gunluk guncellendi.");
            readSetting.Backup();
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
              readSetting.Backup();
            }
          }else{
            readSetting.Backup();
          }
        }else if(readSetting.Backuptimes == "Yıllık"){
          print("Yıllık giriş var");
          if(int.parse(datesplit[2]) != DateTime.now().year){
            readSetting.Backup();
          }
        }
      }
      if(readSetting.isPassword == 1 && readSetting.Password != "null") {
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1),
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
    });
  }
  @override
  void initState() {
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(botomNavBarRiverpod);
    return Scaffold(
      body:watch.body(),
      bottomNavigationBar: NavBar(),
    );
  }
}