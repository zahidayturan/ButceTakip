import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../app/data/models/currency_info.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;
  FirestoreService(this._firestore);

  Future<Map<String, String>> getAppInfo() async {
    try {
      final doc = await _firestore.collection("appInfo").doc("security").get();
      final data = doc.data();

      if (data == null) return _defaultAppInfo;

      return {
        "appInfoString": data["appStatus"] ?? "normal",
        "version": data["version"] ?? "1.0.0"
      };
    } catch (e) {
      debugPrint("getAppInfo Error: $e");
      return _defaultAppInfo;
    }
  }

  Map<String, String> get _defaultAppInfo => {
    "appInfoString": "normal",
    "version": "1.0.0"
  };


  /// Geçmiş kurları getirir ve tarihe göre azalan şekilde sıralar
  Future<List<CurrencyInfo>> getHistoryCurrency() async {
    try {
      final snapshot = await _firestore.collection("historyRates").get();

      final list = snapshot.docs
          .map((doc) => CurrencyInfo.fromObject(doc.data()))
          .toList();

      list.sort((a, b) {
        final dateA = DateTime.tryParse(a.lastApiUpdateDate ?? "") ?? DateTime(2000);
        final dateB = DateTime.tryParse(b.lastApiUpdateDate ?? "") ?? DateTime(2000);
        return dateB.compareTo(dateA);
      });

      return list;
    } catch (e) {
      debugPrint("getHistoryCurrency Error: $e");
      return [];
    }
  }

  /// Eğer o gün için kayıt yoksa yeni bir tarihsel kayıt oluşturur
  Future<void> checkAndCreateDailyRate(CurrencyInfo info) async {
    final String todayDocId = DateFormat('dd.MM.yyyy').format(DateTime.now());
    final docRef = _firestore.collection("historyRates").doc(todayDocId);

    final doc = await docRef.get();
    if (!doc.exists) {
      debugPrint("Günün ilk girişi: Kayıt oluşturuluyor...");
      await docRef.set(info.toMap());
    }
  }

  /// Anlık kurları Firestore'a kaydeder veya günceller
  Future<void> syncCurrencies(CurrencyInfo info) async {
    await _firestore
        .collection("rates")
        .doc("currencies")
        .set(info.toMap(), SetOptions(merge: true));
    // merge: true kullanarak hem oluşturma hem güncelleme tek metotta
  }

  Future<List<CurrencyInfo>> readCurrencies() async {
    final snapshot = await _firestore.collection("rates").get();
    return snapshot.docs
        .map((doc) => CurrencyInfo.fromObject(doc.data()))
        .toList();
  }
}