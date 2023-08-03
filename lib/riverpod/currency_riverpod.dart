import 'package:butcekontrol/models/currency_info.dart';
import 'package:butcekontrol/utils/firestore_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:ntp/ntp.dart';
import '../utils/db_helper.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CurrencyRiverpod extends ChangeNotifier {
  int ?id;
  String ?BASE;
  String ?TRY;
  String ?USD;
  String ?EUR;
  String ?GBP;
  String ?KWD;
  String ?lastApiUpdateDate;

  Future readDb() async{
    List<currencyInfo> currency = await SQLHelper.currencyControl() ;
    id = currency[currency.length - 1].id ;
    BASE = currency[currency.length - 1].BASE ;
    TRY = currency[currency.length - 1].TRY;
    USD = currency[currency.length - 1].USD;
    EUR = currency[currency.length - 1].EUR;
    GBP = currency[currency.length - 1].GBP;
    KWD = currency[currency.length - 1].KWD;
    lastApiUpdateDate = currency[currency.length -1].lastApiUpdateDate;
    print("""
      id : ${currency[currency.length - 1].id}
      BASE :${currency[currency.length - 1].BASE}
      TRY :${currency[currency.length - 1].TRY}
      USD : ${currency[currency.length - 1].USD}
      EUR : ${currency[currency.length - 1].EUR}
      GBP : ${currency[currency.length - 1].GBP}
      KWD :${currency[currency.length - 1].KWD}
      lastApiUpdateDate :${currency[currency.length - 1].lastApiUpdateDate}
      """);
    notifyListeners();
  }
  Future<currencyInfo> fetchExchangeRates(String? prefix)  async {
    DateTime globalNow = await NTP.now();
    const String apiBaseUrl = 'https://api.exchangeratesapi.io';
    const String endpoint = '/latest';
    const String apiKey = 'd6a35d6d178c2cb4e7a6b5305b50f396';
    setBASE(prefix);
    Map<String, dynamic> ?responseMap;
    final response = await http.get(Uri.parse("https://api.apilayer.com/exchangerates_data/latest?base=TRY&symbols=TRY,USD,EUR,GBP,KWD"),
        headers: {
          "apikey" : "bYRgW5gWlBEvjYgFnxLZs9Gdl5twQLtN"
        });

    if(response.statusCode == 200){
      //başarılı
      responseMap = jsonDecode(response.body);
      print("***********************");
      print(responseMap);
    }else if (response.statusCode == 104){
      //Aylık istenilen max isteğe ulaşıldı
      print("c");
    }else{
      print("b");
      print(response.statusCode);
      //başarısız
    }
    print("veri databaseye kaydoldu");

    if (responseMap != null) {
      return currencyInfo(
        "TRY",
        responseMap["rates"]["TRY"].toString(),
        responseMap["rates"]["USD"].toString(),
        responseMap["rates"]["EUR"].toString(),
        responseMap["rates"]["GBP"].toString(),
        responseMap["rates"]["KWD"].toString(),
        globalNow.add(Duration(hours: 6)).toString(),
      );
    }else{
      return currencyInfo("TRY", "TRY", "USD", "EUR", "GBP", "KWD", DateTime.now().toString());
    }

    /*
    if (responseMap != null) {
      List<String> baseList = ["TRY", "USD", "EUR", "GBP", "KWD"]; // dil eklendiğinde değiştirilecek
      List<currencyInfo> ratesList = [] ;
      currencyInfo ?BaseDif;
      for(int index = 0 ; index < baseList.length ; index ++){
        if(baseList[index] == "TRY") {
          BaseDif = currencyInfo(
            "TRY",
            responseMap["rates"]["TRY"].toString(),
            responseMap["rates"]["USD"].toString(),
            responseMap["rates"]["EUR"].toString(),
            responseMap["rates"]["GBP"].toString(),
            responseMap["rates"]["KWD"].toString(),
            globalNow.add(Duration(hours: 6)).toString(),
          );
        }else if(baseList[index] == "USD"){
          BaseDif = currencyInfo(
              "USD",
              (responseMap["rates"]["TRY"] / responseMap["rates"]["USD"]).toString(),
              (responseMap["rates"]["USD"] / responseMap["rates"]["USD"]).toString(),
              (responseMap["rates"]["EUR"] / responseMap["rates"]["USD"]).toString(),
              (responseMap["rates"]["GBP"] / responseMap["rates"]["USD"]).toString(),
              (responseMap["rates"]["KWD"] / responseMap["rates"]["USD"]).toString(),
            globalNow.add(Duration(hours: 6)).toString(),
          );
        }else if(baseList[index] == "EUR"){
          BaseDif = currencyInfo(
            "EUR",
            (responseMap["rates"]["TRY"] / responseMap["rates"]["EUR"]).toString(),
            (responseMap["rates"]["USD"] / responseMap["rates"]["EUR"]).toString(),
            (responseMap["rates"]["EUR"] / responseMap["rates"]["EUR"]).toString(),
            (responseMap["rates"]["GBP"] / responseMap["rates"]["EUR"]).toString(),
            (responseMap["rates"]["KWD"] / responseMap["rates"]["EUR"]).toString(),
            globalNow.add(Duration(hours: 6)).toString(),
          );
        }else if(baseList[index] == "GBP"){
          BaseDif = currencyInfo(
            "GBP",
            (responseMap["rates"]["TRY"] / responseMap["rates"]["GBP"]).toString(),
            (responseMap["rates"]["USD"] / responseMap["rates"]["GBP"]).toString(),
            (responseMap["rates"]["EUR"] / responseMap["rates"]["GBP"]).toString(),
            (responseMap["rates"]["GBP"] / responseMap["rates"]["GBP"]).toString(),
            (responseMap["rates"]["KWD"] / responseMap["rates"]["GBP"]).toString(),
            globalNow.add(Duration(hours: 6)).toString(),
          );
        }else{//KWD
          BaseDif = currencyInfo(
            "KWD",
            (responseMap["rates"]["TRY"] / responseMap["rates"]["KWD"]).toString(),
            (responseMap["rates"]["USD"] / responseMap["rates"]["KWD"]).toString(),
            (responseMap["rates"]["EUR"] / responseMap["rates"]["KWD"]).toString(),
            (responseMap["rates"]["GBP"] / responseMap["rates"]["KWD"]).toString(),
            (responseMap["rates"]["KWD"] / responseMap["rates"]["KWD"]).toString(),
            globalNow.add(Duration(hours: 6)).toString(),
          );
        }
        ratesList.add(BaseDif!);
      }
      print("RATES LİSTT ==> $ratesList");
      return ratesList;
    }else{
        print("API DE HATA ÇIKTI LİSTE GELMEDİ");
       List<currencyInfo> a = [currencyInfo("TRY", "TRY", "USD", "EUR", "GBP", "KWD", DateTime.now().toString())];
       return a;
    }
    */
  }

  Future controlCurrency(String? prefix) async{ //currency Kayıt değerlendiriyoruz.
    List<currencyInfo> currrenciesFirestoreList = [];
    List<currencyInfo> ? currencySqlList = [];
    DateTime ?globalNow;
    try{
      currrenciesFirestoreList = await firestoreHelper.readCurrenciesFirestore();
      currencySqlList = await SQLHelper.currencyControl();
      globalNow = await NTP.now();
      if(currrenciesFirestoreList.isNotEmpty){
        DateTime? date = DateTime.tryParse(currrenciesFirestoreList[currrenciesFirestoreList.length -1].lastApiUpdateDate!);
        if(date!.isBefore(globalNow!)){ // son kullanma tarihi geçmiş diye kontrol ediyorum.
          print("dün veya daha önce güncellenmiş");
          await fetchExchangeRates(prefix).then((info) {
            firestoreHelper.createCurrencyFirestore(info);
            if(currencySqlList!.isNotEmpty){
              var dateSQL = DateTime.tryParse(currencySqlList[currencySqlList.length - 1].lastApiUpdateDate!);
              if(dateSQL!.isBefore(globalNow!)){
                print("yerel database ile firestore daki veriler arasında 1 den fazla gün gecikmiş");
                firestoreHelper.readCurrenciesFirestore().then((currrenciesFirestoreList) {
                  SQLHelper.addItemCurrency(currrenciesFirestoreList[currrenciesFirestoreList.length - 1]).then((value) => readDb());
                },);
              }else{
                print("Bugün zaten veriler senkronizeee");
                readDb();
              }
            }else {
              print("bulutta veri var sql de yoktu ekledik");
              SQLHelper.addItemCurrency(currrenciesFirestoreList[currrenciesFirestoreList.length - 1]).then((value) => readDb());
            }
          });
        }else{
          print("Firestore DataBase zaten güncel");
          if(currencySqlList!.isNotEmpty){
            var dateSQL = DateTime.tryParse(currencySqlList[currencySqlList.length - 1].lastApiUpdateDate!);
            if(dateSQL!.isBefore(globalNow)){
              print("yerel database ile firestore daki veriler arasında 1 den fazla gün gecikmiş");
              firestoreHelper.readCurrenciesFirestore().then((currrenciesFirestoreList) {
                SQLHelper.addItemCurrency(currrenciesFirestoreList[currrenciesFirestoreList.length - 1]).then((value) => readDb());
              },);
            }else{
              print("Bugün zaten veriler senkronize");
              readDb();
            }
          }else {
            print("bulutta veri var sql de yoktu ekledik");
            SQLHelper.addItemCurrency(currrenciesFirestoreList[currrenciesFirestoreList.length - 1]).then((value) => readDb());
          }
        }
      }else{
        await fetchExchangeRates(prefix).then((info) {
          firestoreHelper.createCurrencyFirestore(info);
          //SQLHelper.addItemCurrency(info);
          readDb();
        });
      }
    }catch(e){
      Exception("INTERNET YOKKKKKKKKK");
      print("INTERNET BULUNAMADI(DİD FOUND INTERNET TAKED DEFAULT INFORMATION [$e]");
      //varsayılan değerleri aldırsana abi tekrar kntrol gerekiyor.
    }
  }

  Future Updating() async {
    final info = currencyInfo.withId(
      id,
      BASE,
      TRY,
      USD,
      EUR,
      GBP,
      KWD,
      lastApiUpdateDate,
    );
    await SQLHelper.updateCurrency(info);
  }

  void setBASE(String? prefix) {
    BASE = prefix;
    Updating();
  }
}