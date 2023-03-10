import 'package:butcekontrol/UI/Generalinfo.dart';
import 'package:butcekontrol/appbar.dart';
import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:flutter/material.dart';

class ButceKontrolApp extends StatelessWidget {
  const ButceKontrolApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bütçe Kontrol Uygulaması",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State <MyHomePage> {
  CustomColors renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(),
      body: Column(
        children: [
          Generalinfo(),
        ],
      ),
    );
  }
}