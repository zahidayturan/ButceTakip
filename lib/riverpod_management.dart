import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/addData/logic/update_data_riverpod.dart';
import 'features/addData/logic/add_data_riverpod.dart';
import 'features/home/logic/home_riverpod.dart';
import 'features/statistics/logic/statistics_riverpod.dart';

import 'core/logic/bottom_nav_bar_riverpod.dart';

/// Feature Riverpod
final homeRiverpod = ChangeNotifierProvider((ref) => HomeRiverpod());
final statisticsRiverpod = ChangeNotifierProvider((ref) => StatisticsRiverpod());
final updateDataRiverpod = ChangeNotifierProvider((ref) => UpdateDataRiverpod());
final addDataRiverpod = ChangeNotifierProvider((ref) => AddDataRiverpod());

/// Core Riverpod
final bottomNavBarRiverpod = ChangeNotifierProvider((ref) => BottomNavBarRiverpod());