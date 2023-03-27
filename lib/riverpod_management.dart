import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Riverpod/Bottom_nav_bar_riverpod.dart';
import 'Riverpod/DbProvider.dart';
import 'Riverpod/homeRiverpod.dart';

final botomNavBarRiverpod = ChangeNotifierProvider((ref) => BottomNavBarRiverpod());
final databaseRiverpod = ChangeNotifierProvider((ref) => DbProvider());
final homeRiverpod = ChangeNotifierProvider((ref) => HomeRiverpod());