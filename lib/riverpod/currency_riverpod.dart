import 'package:butcekontrol/models/currency_info.dart';
import 'package:butcekontrol/models/settings_info.dart';
import 'package:butcekontrol/utils/firestore_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
  String ?JOD;
  String ?IQD;
  String ?SAR;
  String ?lastApiUpdateDate;
  List<currencyInfo> currrenciesFirestoreList = [];
  List<currencyInfo>  currencySqlList = [];
  List<currencyInfo> currenciesAllHistory = [];

  double calculateRealAmount(double Amount, String moneyType, String prefix, {currencyInfo? currency})  { // amount moneytype kaç Prefix ?
    double ?realAmount;
    if(double.tryParse((currency ?? currencySqlList[currencySqlList.length -1]).toMap()[moneyType.substring(0,3)])! > 0.0){
      realAmount = double.parse((Amount * (double.tryParse((currency ?? currencySqlList[currencySqlList.length -1]).toMap()[prefix])! / double.tryParse((currency ?? currencySqlList[currencySqlList.length -1]).toMap()[moneyType.substring(0,3)])!)).toStringAsFixed(2));
    }else{
      realAmount = Amount ;
    }
    return realAmount ?? 0.0;
  }

  Future<double?> calculateHistoryAmount(double Amount, String moneyType, String prefix, String date, currencyInfo currency)  async { // amount moneytype kaç Prefix ?
    double ?realAmount;
    print("Real Amount hesapatılıyor.");
    if(double.tryParse(currency.toMap()[moneyType.substring(0,3)])! > 0.0){
      realAmount = double.parse((Amount * (double.tryParse(currency.toMap()[prefix])! / double.tryParse(currency.toMap()[moneyType.substring(0,3)])!)).toStringAsFixed(2));
    }else{
      realAmount = Amount ;
    }
    return realAmount ?? 0.0;
  }

  double calculateRate(String moneyType, String prefix, {currencyInfo? currency}){ //kur hesaplıyor.
    double ?rate;
    if(double.tryParse((currency ?? currencySqlList[currencySqlList.length -1]).toMap()[moneyType])! > 0.0){
      rate = double.parse(((double.tryParse((currency ?? currencySqlList[currencySqlList.length -1]).toMap()[prefix])! / double.tryParse((currency ?? currencySqlList[currencySqlList.length -1]).toMap()[moneyType.substring(0,3)])!)).toStringAsFixed(5));
    }else{
      rate = 0.0 ;
    }
    return rate ;
  }

  Future<void> calculateAllSQLHistoryTime() async { ///bu fonksiyon sadece varsayılan para birimini değiştirdiğimizde çalışması gerekiyor.
    List<SpendInfo> AllData = await SQLHelper.getItems();
    if(AllData.isNotEmpty){
      List<SettingsInfo> settingsList = await SQLHelper.settingsControl();

      await firestoreHelper.getHistoryCurrency().then((value) {
        ///küçükten büyüğe doğru sıraladık.
        value.sort((a, b) => DateTime.tryParse(a.lastApiUpdateDate!)!.compareTo(DateTime.tryParse(b.lastApiUpdateDate!)!));
        currenciesAllHistory = value ;
      });
      print("********************");
      currenciesAllHistory.forEach((element) async {
        print(element.lastApiUpdateDate);
      });
      print("********************");

      for (var info in AllData) {
        if (info.moneyType == "0") {
          info.moneyType = "TRY";
        }

        if (info.moneyType!.substring(0,3) == settingsList[0].prefix!) { //pasif ve varsayılan birimi ile aynı olan kayıtlar buraya girecek.
          info.realAmount = info.amount;
        }else {//aktif ve pasif olup prefixle aynı olmayan kayıtlar buraday girecek. sorgu eski tarihteki currency e göre alınacak.
          if(currenciesAllHistory.isNotEmpty){
            print("---------------------------------------");
            print("\nBakalım  ${info.operationDate} tarihli kaydımız için en yakın ver bulalım.");
            currencyInfo ?historyCurrency ;

            List a = currenciesAllHistory.where((element) {
                var date = DateTime.tryParse(element.lastApiUpdateDate!);
                String formattedDate = DateFormat('dd.MM.yyyy').format(date!);
                return formattedDate == info.operationDate;
              },
            ).toList();

            a.forEach((element) {
              if(element != null) {
                historyCurrency = element ;
                print("Günü bulduk.");
              }
            });

            if(historyCurrency == null){
              print("En yakın gün bulacağız.");
              List<String> Date = info.operationDate!.split(".") ; //"00.00.0000"
              currencyInfo ?lastdays ;
              currencyInfo  ?firstdays ;
              if(DateTime.tryParse(currenciesAllHistory.first.lastApiUpdateDate!)!.isAfter(DateTime(int.parse(Date[2]),int.parse(Date[1]), int.parse(Date[0])))){
                print("GERİ KAYIT");
                firstdays = currenciesAllHistory.first ;
              }else if(DateTime.tryParse(currenciesAllHistory.last.lastApiUpdateDate!)!.isBefore(DateTime(int.parse(Date[2]),int.parse(Date[1]), int.parse(Date[0])))){
                print("ILERI KAYIT");
                lastdays = currenciesAllHistory.last ;
              }
              if(firstdays == null && lastdays == null) {
                print("ARA Kayıt bulunuyor.");
                for(var element in currenciesAllHistory){
                  if(DateTime(int.parse(Date[2]),int.parse(Date[1]), int.parse(Date[0])).isBefore(DateTime.tryParse(element.lastApiUpdateDate!)!)){ // günü mevcut.
                    lastdays = element;
                  }else{
                    firstdays = element;
                  }
                }
                print("***");
                if(lastdays != null && firstdays != null){
                  Duration fark1 = DateTime.tryParse(lastdays.lastApiUpdateDate!)!.difference(DateTime(int.parse(Date[2]),int.parse(Date[1]), int.parse(Date[0])));
                  Duration fark2 = DateTime.tryParse(firstdays.lastApiUpdateDate!)!.difference(DateTime(int.parse(Date[2]),int.parse(Date[1]), int.parse(Date[0])));
                  if(fark1 < fark2){
                    historyCurrency = lastdays;
                    print("FİNALLL === > ${lastdays.lastApiUpdateDate}");
                  }else{
                    historyCurrency = firstdays;
                    print("FİNALLL === > ${firstdays.lastApiUpdateDate}");
                  }
                }else if(lastdays != null) {
                  historyCurrency = lastdays;
                  print("FİNALLL === > ${lastdays.lastApiUpdateDate}");
                }else{
                  historyCurrency = firstdays;
                  print("FİNALLL === > ${firstdays!.lastApiUpdateDate}");
                }
              }else{
                if(firstdays != null){
                  historyCurrency = firstdays;
                  print("FİNALLL === > ${firstdays!.lastApiUpdateDate}");
                }else{
                  historyCurrency = lastdays;
                  print("FİNALLL === > ${lastdays!.lastApiUpdateDate}");
                }
              }
            }
            info.realAmount = await calculateHistoryAmount(
              info.amount!,
              info.moneyType!,
              settingsList[0].prefix!,
              info.operationDate!,
              historyCurrency!
            );
            currenciesAllHistory.clear();
          }else{
            info.realAmount = await calculateRealAmount(
              info.amount!,
              info.moneyType!,
              settingsList[0].prefix!,
            );
          }

        }

        await SQLHelper.updateItem(info);

        print("Kayıt güncellendi: ${info.category} - Eski miktar: ${info.amount} ${info.moneyType} - RealAmount miktar: ${info.realAmount} ${settingsList[0].prefix!} - ID: ${info.id}");
        //ref.read(settingsRiverpod).setisuseinsert();
      }
    }else{
      //kayıt yok. işlem yapma.
    }
  }

  Future<void> calculateAllSQLRealTime() async {
    List<SpendInfo> AllData = await SQLHelper.getItems();
    List<SettingsInfo> settingsList = await SQLHelper.settingsControl();

    for (var info in AllData) {
      if (info.moneyType == "0") {
        info.moneyType = "TRY";
      }

      if(info.moneyType!.length == 4 ) {//aktif kayıtlarler(Giderler) buraya girecek.
        info.realAmount = await calculateRealAmount(
          info.amount!,
          info.moneyType!,
          settingsList[0].prefix!,
        );
        print("Kayıt güncellendi: ${info.category} - Eski miktar: ${info.amount} ${info.moneyType} - RealAmount miktar: ${info.realAmount} ${settingsList[0].prefix!} - ID: ${info.id}");
      }
      await SQLHelper.updateItem(info);
      //ref.read(settingsRiverpod).setisuseinsert();
    }
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
    JOD = currency[currency.length - 1].JOD;
    IQD = currency[currency.length - 1].IQD;
    SAR = currency[currency.length - 1].SAR;

    lastApiUpdateDate = currency[currency.length -1].lastApiUpdateDate;
    print("""
      id  : ${currency[currency.length - 1].id}
      BASE: ${currency[currency.length - 1].BASE}
      TRY : ${currency[currency.length - 1].TRY}               USD : ${currency[currency.length - 1].USD}
      EUR : ${currency[currency.length - 1].EUR}        GBP : ${currency[currency.length - 1].GBP}
      KWD : ${currency[currency.length - 1].KWD}        JOD : ${currency[currency.length - 1].JOD}
      IQD : ${currency[currency.length - 1].IQD}       SAR : ${currency[currency.length - 1].SAR}
      lastApiUpdateDate :${currency[currency.length - 1].lastApiUpdateDate}
      """);
    notifyListeners();
  }

  Future<currencyInfo> fetchExchangeRates()  async {
    DateTime globalNow = await NTP.now();
    const String apiBaseUrl = 'https://api.apilayer.com/exchangerates_data';
    const String endpoint = '/latest';
    String apiKey = securityFile().api_key ?? "request API for currency rates";
    Map<String, dynamic> ?responseMap;
    final response = await http.get(Uri.parse("https://api.apilayer.com/exchangerates_data/latest?base=TRY&symbols=TRY,USD,EUR,GBP,KWD,JOD,IQD,SAR"),
        headers: {
          "apikey" : apiKey
        });

    if(response.statusCode == 200){
      //başarılı
      responseMap = jsonDecode(response.body);
      print("***********************");
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
        responseMap["rates"]["JOD"].toString(),
        responseMap["rates"]["IQD"].toString(),
        responseMap["rates"]["SAR"].toString(),
        globalNow.add(Duration(hours: 3)).toString(),
      );
    }else{
      return currencyInfo("noInternet", "1", "1", "1", "1", "1", "1", "1", "1", DateTime.now().toString()); //bir kişide olan bir sıkıntı milyonları etkileyebilir.
    }
  }

  Future controlCurrency(WidgetRef ref) async{ //currency Kayıt değerlendiriyoruz.
    DateTime ?globalNow;
    currencySqlList = await SQLHelper.currencyControl();
    DateTime dateLocal = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy').format(dateLocal);
    try{
      currrenciesFirestoreList = await firestoreHelper.readCurrenciesFirestore();
      globalNow = await NTP.now();
      print("GLOBAL SAAT =>${globalNow}");
      if(currrenciesFirestoreList.isNotEmpty){
        DateTime? date = DateTime.tryParse(currrenciesFirestoreList[currrenciesFirestoreList.length -1].lastApiUpdateDate!);
        if(date!.isBefore(globalNow)){ // son kullanma tarihi geçmiş diye kontrol ediyorum.
          print("3 saat veya daha önce güncellenmiş");
          await fetchExchangeRates().then((info) {
            if(info.BASE != 'noInternet'){
              firestoreHelper.createCurrencyFirestore(info);
              firestoreHelper.searchHistoryRate(formattedDate, info);
              if(currencySqlList.isNotEmpty){
                var dateSQL = DateTime.tryParse(currencySqlList[currencySqlList.length - 1].lastApiUpdateDate!);
                if(dateSQL!.isBefore(globalNow!)){
                  print("yerel database ile firestore daki veriler arasında 3 saatten den fazla zaman gecikmiş");
                  firestoreHelper.readCurrenciesFirestore().then((currrenciesFirestoreList) {
                    SQLHelper.addItemCurrency(currrenciesFirestoreList[currrenciesFirestoreList.length - 1]).then((value) {
                      calculateAllSQLRealTime();
                      readDb();
                    });
                  },);
                }else{
                  print("Bugün zaten veriler senkronizeee");
                  readDb();
                }
              }else {
                print("bulutta veri var sql de yoktu ekledik");
                SQLHelper.addItemCurrency(currrenciesFirestoreList[currrenciesFirestoreList.length - 1]).then((value) {
                  SQLHelper.currencyControl().then((value) => currencySqlList = value);
                  calculateAllSQLRealTime();
                  readDb();
                });
              }
            }else{//api çekerken hata oluştuysa ne yapacağız.
              if(currencySqlList.isEmpty) {
                SQLHelper.addItemCurrency(info).then((value) {
                  readDb();
                  },
                );
              }else{
                readDb();
              }
            }
          }
          );
        }else{
          print("Firestore DataBase zaten güncel");
          if(currencySqlList.isNotEmpty){
            var dateSQL = DateTime.tryParse(currencySqlList[currencySqlList.length - 1].lastApiUpdateDate!);
            if(dateSQL!.isBefore(globalNow)){
              print("yerel database ile firestore daki veriler arasında 3 saatten den fazla zaman gecikmiş");
              firestoreHelper.readCurrenciesFirestore().then((currrenciesFirestoreList) {
                SQLHelper.addItemCurrency(currrenciesFirestoreList[currrenciesFirestoreList.length - 1]).then((value) {
                  calculateAllSQLRealTime();
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
              SQLHelper.currencyControl().then((value) => currencySqlList = value);
              calculateAllSQLRealTime();
              readDb();
            });
          }
        }
      }else{ //buraya düşmesiz imkansız gbi bir şey? //buluttaki veri silinirse düşer.
        await fetchExchangeRates().then((info) {
          firestoreHelper.createCurrencyFirestore(info);
          firestoreHelper.searchHistoryRate(formattedDate, info);
          //SQLHelper.addItemCurrency(info);
          readDb();
        });
      }
    }catch(e){
      print("INTERNET BULUNAMADI(DİD FOUND INTERNET TAKED DEFAULT INFORMATION [$e]");
      if(currencySqlList.isNotEmpty){
        readDb();
      }else{
        await SQLHelper.addItemCurrency(currencyInfo("noInternet", "1", "1", "1", "1", "1", "1", "1", "1", "00.00.0000"));
        readDb();
      }
      ///internet yokken girildiğinde eski verileri kullanır yoksa tüm kurları 1 yapar.
      //fetchExchangeRates().then((value) => readDb()); =>
      ///zaten internet yok tekrar Api çekmeye gerek yok
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
      JOD,
      IQD,
      SAR,
      lastApiUpdateDate,
    );
    await SQLHelper.updateCurrency(info);
  }

  void setBASE(String? prefix) {
    BASE = prefix;
    Updating();
  }
}