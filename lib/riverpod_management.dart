import 'package:butcekontrol/Riverpod/appbarType2Riverpod.dart';
import 'package:butcekontrol/Riverpod/editInfo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Riverpod/Bottom_nav_bar_riverpod.dart';
import 'Riverpod/DbProvider.dart';
import 'Riverpod/homeRiverpod.dart';

final botomNavBarRiverpod = ChangeNotifierProvider((ref) => BottomNavBarRiverpod());
final databaseRiverpod = ChangeNotifierProvider((ref) => DbProvider());
final homeRiverpod = ChangeNotifierProvider((ref) => HomeRiverpod());
final AppBarTypeProvider = ChangeNotifierProvider((ref) => AppBarType2Riverpod());
final editinfoProvider = ChangeNotifierProvider((ref) => editInfo());