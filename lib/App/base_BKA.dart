import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';
import '../classes/appbar.dart';
import '../classes/navBar.dart';

class base_BKA extends ConsumerWidget {
  const base_BKA({Key ? key}) :super(key :key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var watch = ref.watch(botomNavBarRiverpod);
    return Scaffold(
      body:watch.body(),
      bottomNavigationBar: navBar(),
    );
  }
}