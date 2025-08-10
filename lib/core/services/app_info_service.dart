import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appInfoServiceProvider = Provider<AppInfoService>((ref) {
  return AppInfoService(FirebaseFirestore.instance);
});

class AppInfoService {
  final FirebaseFirestore _firestore;

  AppInfoService(this._firestore);

  Future<Map<String, String>> getAppInfo() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
      await _firestore.collection("appInfo").doc("security").get();
      Map<String, dynamic>? data = querySnapshot.data();

      if (data != null) {
        String? appInfoString = data["appStatus"];
        String? appVersionInfoString = data["version"];
        return {
          "appInfoString": appInfoString ?? "normal",
          "version": appVersionInfoString ?? "1.0.0"
        };
      } else {
        debugPrint("App info not found in Firestore.");
        return {"appInfoString": "normal", "version": "1.0.0"};
      }
    } catch (e) {
      debugPrint("Error fetching app info: $e");
      return {"appInfoString": "normal", "version": "1.0.0"}; // Default fallback
    }
  }
}
