import 'package:butcekontrol/UI/Generalinfo.dart';
import 'package:butcekontrol/constains/MaterialColor.dart';
import 'package:butcekontrol/appbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bütce Kontol Uygulaması',
      theme: ThemeData(

        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Bütce Kontol Uygulaması'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  CustomColors renkler = CustomColors();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:appbarCustom(),
      body: Generalinfo()   // arkadaşlar istediğiniz düzenlemeyi yapabilirsiniz devam widgetler için bunu Ccolumn içine almak lazım Zahid Stack widgetine bakmak isteyebilirsin.
    );
  }
}
