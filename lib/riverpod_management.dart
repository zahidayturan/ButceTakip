import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/firestore_service.dart';
import 'features/addData/logic/update_data_riverpod.dart';
import 'features/addData/logic/add_data_riverpod.dart';
import 'features/home/logic/home_riverpod.dart';
import 'features/introduction/logic/introduction_riverpod.dart';
import 'features/statistics/logic/statistics_riverpod.dart';

import 'core/logic/bottom_nav_bar_riverpod.dart';

/// Feature Riverpod
final homeRiverpod = ChangeNotifierProvider((ref) => HomeRiverpod());
final statisticsRiverpod = ChangeNotifierProvider((ref) => StatisticsRiverpod());
final updateDataRiverpod = ChangeNotifierProvider((ref) => UpdateDataRiverpod());
final addDataRiverpod = ChangeNotifierProvider((ref) => AddDataRiverpod());
final introductionRiverpod = ChangeNotifierProvider((ref) => IntroductionRiverpod(ref));

/// Core Riverpod
final bottomNavBarRiverpod = ChangeNotifierProvider((ref) => BottomNavBarRiverpod());


/// Main Overrride Riverpod
final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); //main override
});


/// Firebase Riverpod
final firestoreInstanceProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// Service Riverpod
final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  final firestore = ref.watch(firestoreInstanceProvider);
  return FirestoreService(firestore);
});