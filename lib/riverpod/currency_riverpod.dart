import 'package:butcekontrol/models/currency_info.dart';
import 'package:butcekontrol/utils/firestore_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:ntp/ntp.dart';
import '../models/spend_info.dart';
import '../utils/db_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/security_file.dart';


class CurrencyRiverpod extends ChangeNotifier {
  int ?id;
  String ?BASE;
  String ?TRY;
  String ?USD;
  String ?EUR;
  String ?GBP;
  String ?KWD;
  String ?lastApiUpdateDate;
  List<currencyInfo> currrenciesFirestoreList = [];
  List<currencyInfo>  currencySqlList = [];

  double calculateRealAmount(double Amount, String moneyType, String prefix){// amount moneytype kaç Prefix ?
    double realAmount;
    if(double.tryParse(currencySqlList![currencySqlList.length -1].toMap()[moneyType])! > 0.0){
      realAmount = double.parse((Amount * (double.tryParse(currencySqlList[currencySqlList.length -1].toMap()[prefix])! / double.tryParse(currencySqlList[currencySqlList.length -1].toMap()[moneyType])!)).toStringAsFixed(2))!;
    }else{
      realAmount = Amount ;
    }
    return realAmount ?? 0.0;
  }
  void calculateAllSQLRealTime(String Prefix) async { //Bütün kayıtları dolaşıp realAmount güncellenmesi yapıyor.
    List<SpendInfo> AllData = await SQLHelper.getItems();
    AllData.forEach((info) async {
      if(info.moneyType == "0"){
        info.moneyType = "TRY";
      }
      info.realAmount = calculateRealAmount(info.amount!, info.moneyType! , Prefix); // amount moneytype kaç Prefix ?
      await SQLHelper.updateItem(info).then((value) => print("GÜNCELLENMİŞ KAYIT ===>>>${info.category} eski miktar ${info.amount} ${info.moneyType} realAmount miktar ====>> ${info.realAmount} $Prefix İD => ${info.id}"));
      /*
      if(info.moneyType != Prefix){  //yanlış iflitreleme

      }else{

      }

       */
    });
  }

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
    const String apiBaseUrl = 'https://api.apilayer.com/exchangerates_data';
    const String endpoint = '/latest';
    String apiKey = securityFile().api_key ?? "request API for currency rates";
    setBASE(prefix);
    Map<String, dynamic> ?responseMap;
    final response = await http.get(Uri.parse("https://api.apilayer.com/exchangerates_data/latest?base=TRY&symbols=TRY,USD,EUR,GBP,KWD"),
        headers: {
          "apikey" : apiKey
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
      return currencyInfo("TRY", "1", "1", "1", "1", "1", DateTime.now().toString());
    }
  }

  Future controlCurrency(String? prefix) async{ //currency Kayıt değerlendiriyoruz.
    DateTime ?globalNow;
    try{
      currrenciesFirestoreList = await firestoreHelper.readCurrenciesFirestore();
      currencySqlList = await SQLHelper.currencyControl();
      globalNow = await NTP.now();
      print("GLOBAL SAAT =>$globalNow");
      if(currrenciesFirestoreList!.isNotEmpty){
        DateTime? date = DateTime.tryParse(currrenciesFirestoreList![currrenciesFirestoreList!.length -1].lastApiUpdateDate!);
        if(date!.isBefore(globalNow!)){ // son kullanma tarihi geçmiş diye kontrol ediyorum.
          print("dün veya daha önce güncellenmiş");
          await fetchExchangeRates(prefix).then((info) {
            firestoreHelper.createCurrencyFirestore(info);
            if(currencySqlList!.isNotEmpty){
              var dateSQL = DateTime.tryParse(currencySqlList![currencySqlList!.length - 1].lastApiUpdateDate!);
              if(dateSQL!.isBefore(globalNow!)){
                print("yerel database ile firestore daki veriler arasında 1 den fazla gün gecikmiş");
                firestoreHelper.readCurrenciesFirestore().then((currrenciesFirestoreList) {
                  SQLHelper.addItemCurrency(currrenciesFirestoreList[currrenciesFirestoreList.length - 1]).then((value) {
                    calculateAllSQLRealTime(prefix!);
                    readDb();
                  });
                },);
              }else{
                print("Bugün zaten veriler senkronizeee");
                readDb();
              }
            }else {
              print("bulutta veri var sql de yoktu ekledik");
              SQLHelper.addItemCurrency(currrenciesFirestoreList![currrenciesFirestoreList!.length - 1]).then((value) {
                calculateAllSQLRealTime(prefix!);
                readDb();
              });
            }
          });
        }else{
          print("Firestore DataBase zaten güncel");
          if(currencySqlList!.isNotEmpty){
            var dateSQL = DateTime.tryParse(currencySqlList![currencySqlList!.length - 1].lastApiUpdateDate!);
            if(dateSQL!.isBefore(globalNow)){
              print("yerel database ile firestore daki veriler arasında 1 den fazla gün gecikmiş");
              firestoreHelper.readCurrenciesFirestore().then((currrenciesFirestoreList) {
                SQLHelper.addItemCurrency(currrenciesFirestoreList[currrenciesFirestoreList.length - 1]).then((value) {
                  calculateAllSQLRealTime(prefix!);
                  readDb();
                });
              },);
            }else{
              print("Bugün zaten veriler senkronize");
              readDb();
            }
          }else {
            print("bulutta veri var sql de yoktu ekledik");
            SQLHelper.addItemCurrency(currrenciesFirestoreList![currrenciesFirestoreList!.length - 1]).then((value) {
              calculateAllSQLRealTime(prefix!);
              readDb();
            });
          }
        }
      }else{ //buraya düşmesiz imkansız gbi bir şey?
        await fetchExchangeRates(prefix).then((info) {
          firestoreHelper.createCurrencyFirestore(info);
          //SQLHelper.addItemCurrency(info);
          readDb();
        });
      }
    }catch(e){
      Exception("INTERNET YOKKKKKKKKK");
      print("INTERNET BULUNAMADI(DİD FOUND INTERNET TAKED DEFAULT INFORMATION [$e]");
      //varsayılan değerleri aldırsana abi tekrar kontrol gerekiyor.
      fetchExchangeRates(prefix).then((value) => readDb());
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