import 'package:butcekontrol/Pages/more/Help/PasswordSplash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';
import '../classes/navBar.dart';

class base_BKA extends ConsumerStatefulWidget {
  const base_BKA({Key ? key}) :super(key :key);

  @override
  ConsumerState<base_BKA> createState() => _base_BKAState();
}

class _base_BKAState extends ConsumerState<base_BKA> {
  void loadData()  async {
 // örnek gecikme
    var readSetting =  ref.read(settingsRiverpod);
    readSetting.controlSettings() ; // Settings tablosunu çekiyoruz. ve implemente ettik
    await Future.delayed(Duration(milliseconds: 1000));
    if(readSetting.isPassword == 1 && readSetting.Password != "null") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => passwordSplash()));
    }
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
      bottomNavigationBar: navBar(),
    );
  }
}