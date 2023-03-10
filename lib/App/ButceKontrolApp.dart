import 'package:butcekontrol/UI/Generalinfo.dart';
import 'package:butcekontrol/appbar.dart';
import 'package:flutter/material.dart';

class ButceKontrolApp extends StatefulWidget {
  const ButceKontrolApp({Key? key}) : super(key: key);

  @override
  State<ButceKontrolApp> createState() => _ButceKontrolAppState();
}

class _ButceKontrolAppState extends State<ButceKontrolApp> {
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
