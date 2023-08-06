import 'package:butcekontrol/classes/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';

class base_BKA extends ConsumerStatefulWidget {
  const base_BKA({Key ? key}) :super(key :key);

  @override
  ConsumerState<base_BKA> createState() => _base_BKAState();
}

class _base_BKAState extends ConsumerState<base_BKA> {

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(botomNavBarRiverpod);
    return Scaffold(
      body: watch.body(),
      bottomNavigationBar: NavBar(),
    );
  }
}