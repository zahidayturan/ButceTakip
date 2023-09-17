import 'package:butcekontrol/models/currency_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class firestoreHelper {

  static void createHistoryRates(currencyInfo info) async {
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy').format(date);
    final docCurrency = await FirebaseFirestore.instance.collection("historyRates").doc(formattedDate);
    final json = info.toMap();
    await docCurrency.set(json);
  }
  static Future<List<currencyInfo>> getHistoryCurrency() async {
    currencyInfo currency ;//bir kişide olan bir sıkıntı milyonları etkileyebilir.
    final collectionReference = FirebaseFirestore.instance.collection("historyRates");
    QuerySnapshot querySnapshot = await collectionReference.get();
    List<currencyInfo> currenciesList = [];
    if(querySnapshot.docs.isNotEmpty){
      querySnapshot.docs.forEach((document) {
        currency = currencyInfo.fromObject(document.data());
        currenciesList.add(currency);
      });
    }
    return currenciesList;
    /*
    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((document) {
        currency = currencyInfo.fromObject(document.data());
      });
      print("Veri bulduk o da ==>> ${currency.BASE}");
      return currency;
    } else { // eğer yoksa en yakın tarihe git.
      print("EN YAKIN TARİH ALINACAK");
      String maxDate = "01.01.2030";
      String minDate = "01.01.2020";
      QuerySnapshot querySnapshott = await collectionReference
          .where(FieldPath.documentId, isGreaterThan: formattedDate)
          .get();
      if (querySnapshott.docs.isNotEmpty) {
          currency = currencyInfo.fromObject(querySnapshott.docs[0].data());
          return currency;
      }else {
        print("Bir şey bulamadım.");
      }
    }

     */
  }
  static void searchHistoryRate(String formattedDatee, currencyInfo info) async {
    final collectionReference = FirebaseFirestore.instance.collection("historyRates");
    QuerySnapshot querySnapshot = await collectionReference.where(FieldPath.documentId, isEqualTo: formattedDatee).get();
    if (querySnapshot.docs.isEmpty) {
      print("BUGÜN İLK KEZ GİRİLDİ KAYIT OLUŞTURULUYOR...");
      createHistoryRates(info);
    } else {
      print("BUGÜN ZATEN GİRİŞ YAPILMIŞ");
    }
  }

  static void createCurrencyFirestore(currencyInfo info) async {
    final docCurrency = await FirebaseFirestore.instance.collection("rates").doc("currencies");
    final json = info.toMap();
    await docCurrency.set(json);
  }

  static void updateCurrencyFirestore(currencyInfo info) async {
    final docCurrency = await FirebaseFirestore.instance.collection("rates").doc("currencies");
    final json = info.toMap();
    await docCurrency.update(json);
  }

  static Future<Map<String, dynamic>?> getAppInfo() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("appInfo").doc("security").get();
      return querySnapshot.data();
    } catch (e) {
      print("Hata oluştu: $e");
      return null; // Hata durumunda null dönebilirsiniz veya uygun bir hata işleme stratejisi uygulayabilirsiniz.
    }
  }

  static Future<List<currencyInfo>> readCurrenciesFirestore() async {
    currencyInfo ? currency;
    List<currencyInfo> currencies = [];
    var snapshot = await FirebaseFirestore.instance.collection("rates").get();
    if(snapshot != null && snapshot.docs.length > 0 ){
      snapshot.docs.forEach((document) {
        currency = currencyInfo.fromObject(document.data());
        currencies.add(currency!);
      });
    }
    return currencies;
  }
}