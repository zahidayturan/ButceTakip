import 'package:butcekontrol/models/currency_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class firestoreHelper {

  static void createCurrencyFirestore(currencyInfo info) async {
    final docCurrency = await FirebaseFirestore.instance.collection("rates").doc("currencies");
    final json = info.toMap();
    await docCurrency.set(json);
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
    print(currencies);
    return currencies;
  }
}